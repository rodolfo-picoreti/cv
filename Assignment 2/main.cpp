#include <armadillo> // -larmadillo
#include <cstdint>
#include <cmath>
#include <iostream>

#include "libs/congo/ransac.hpp"
#include "libs/congo/dlt.hpp"

#include <dlib/optimization.h>

arma::mat optimize (const arma::mat& _xi, 
                    const arma::mat& _xli, 
                    const arma::mat& _H) {
  using namespace dlib;

  matrix<double> xi = mat(_xi);
  matrix<double> xli = mat(_xli);
  matrix<double, 0, 1> H = mat(_H);

  find_min_using_approximate_derivatives(
    bfgs_search_strategy(),
    objective_delta_stop_strategy(1e-3),
    [&xi, &xli] (const matrix<double>& _H) {
      matrix<double> H = trans(reshape(_H, 3, 3)) / _H(8);
      matrix<double> i2li = (xli - H*xi);
      matrix<double> li2i = (xi - inv(H)*xli);


      double cost = dot(i2li, i2li) + dot(li2i, li2i);
      return cost;
    }, 
    H, 
    -1
  );

  arma::mat Hopt {
    { H(0), H(3), H(6) },
    { H(1), H(4), H(7) },
    { H(2), H(5), H(8) },
  };

  return Hopt / H(8);
}

int main() {
  using namespace arma;
  arma_rng::set_seed_random();
  
  mat xi {
    { 0.0, 0.0, 1.0, 1.0, 2.0 },
    { 0.0, 1.0, 0.0, 1.0, 2.0 },
    { 1.0, 1.0, 1.0, 1.0, 1.0 }
  };
  xi.rows(0, 1) *= 100; 

  mat xli = xi;
  xli.row(0) *= 5;
  xli.row(0) += 10;
  xli.row(1) *= 5;
  xli.row(1) += 10;

  xi.rows(0, 1) += randn(size(xi.rows(0, 1)));
  xli.rows(0, 1) += randn(size(xli.rows(0, 1)));

  mat H = congo::dlt::homography_2d(join_vert(xi, xli));
  mat xli_hat = H*xi;

  mat Hopt = optimize(xi, xli, arma::vectorise(H));
  mat xli_hat_opt = Hopt*xi;

  mat Hpinv = xli * pinv(xi);
  mat xli_pinv = Hpinv * xi;

  H.print("H");  
  Hopt.print("Hopt");
  Hpinv.print("Hpinv");  

  xli.print("x'i");  
  xli_hat.print("x'i_hat");  
  xli_hat_opt.print("x'i_hat_opt");  
  xli_pinv.print("x'i_pinv");  
}