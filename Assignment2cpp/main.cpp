#include <armadillo> // -larmadillo
#include <cstdint>
#include <cmath>
#include <iostream>

#include "libs/congo/homography.hpp"
#include "libs/congo/transform.hpp"

#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/features2d/features2d.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/calib3d/calib3d.hpp>

#include <dlib/optimization.h>

arma::mat project (const arma::mat& H, const arma::mat& x) {
  using namespace arma;
  
  mat x_hat = H*x;
  x_hat.each_col([] (vec& col) {
    col /= col(2);
  });

  return x_hat;
}

double cost_function (const arma::mat& xi, 
                      const arma::mat& xli, 
                      const arma::mat& H) {
  using namespace arma;

  mat i2li = xli - project(H, xi);
  mat li2i = xi - project(inv(H), xli);

  double cost = sqrt(dot(i2li, i2li) + dot(li2i, li2i));
  return cost;
}

arma::mat optimize (const arma::mat& xi, 
                    const arma::mat& xli, 
                    const arma::mat& H0) {
  using namespace arma;

  mat Hvec = arma::vectorise(H0);
  dlib::matrix<double, 0, 1> H = dlib::mat(Hvec);

  dlib::find_min_using_approximate_derivatives(
    dlib::bfgs_search_strategy(),
    dlib::objective_delta_stop_strategy(1e-6),
    [&xi, &xli] (const dlib::matrix<double>& hi) {
      
      mat Hi {
        { hi(0), hi(3), hi(6) },
        { hi(1), hi(4), hi(7) },
        { hi(2), hi(5), hi(8) },
      };

      return cost_function(xi, xli, Hi);
    }, 
    H, 
    -1
  );

  mat Hopt {
    { H(0), H(3), H(6) },
    { H(1), H(4), H(7) },
    { H(2), H(5), H(8) },
  };

  return Hopt;
}

// Armadillo matrix to OpenCV matrix. NOTE: no copy is made
template <typename T>
cv::Mat_<T> arma_to_cv(const arma::Mat<T>& src) {
  return cv::Mat_<double> {
    int(src.n_cols), int(src.n_rows), const_cast<T*>(src.memptr())
  };
}

// OpenCV matrix to Armadillo matrix . NOTE: no copy is made
arma::mat cv_to_arma(const cv::Mat& src) {
  // unsafe?
  arma::mat dst(reinterpret_cast<double*>(src.data), src.rows, src.cols, true);
  return dst.t();
}

int main() {
  using namespace arma;
  arma_rng::set_seed_random();

  mat xi = randn(2, 4000);
  xi.cols(1000, 1999) *= 10;
  xi.cols(2000, 2999) *= 100;
  xi.cols(3000, 3999) *= 1000;
  xi = join_vert(xi, ones(1, xi.n_cols));
  
  // Original Homography
  mat Horig =   
    congo::rotate2d(-33.66) *
    congo::scale2d(7.66, 3.33) * 
    congo::rotate2d(-127.66) *
    congo::translate2d(13.1, 17.5) * 
    congo::rotate2d(67.22); 

  mat xli = Horig * xi;
  
  // Add noise to measurements
  xi.rows(0, 1) += 10*randn(size(xi.rows(0, 1)));
  xli.rows(0, 1) += 10*randn(size(xli.rows(0, 1)));

  cv::Mat xicv = arma_to_cv(xi);
  cv::Mat xlicv = arma_to_cv(xli);

  mat Hcv = cv_to_arma(cv::findHomography(xicv, xlicv));
  mat Hdlt = congo::homography2d(join_vert(xi, xli));
  mat Hdlt_opt = optimize(xi, xli, Hdlt);
  mat Hpinv = xli * pinv(xi);
  mat Hpinv_opt = optimize(xi, xli, Hpinv/norm(Hpinv));
  
  mat xli_hat_dlt = project(Hdlt, xi);
  mat xli_hat_dlt_opt = project(Hdlt_opt, xi);
  mat xli_hat_pinv = project(Hpinv, xi);
  mat xli_hat_pinv_opt = project(Hpinv_opt, xi);

  std::cout << "Cdlt : " << cost_function(xi, xli, Hdlt) << '\n'
            << "Cdlt_opt : " << cost_function(xi, xli, Hdlt_opt) << '\n'
            << "Cpinv : " << cost_function(xi, xli, Hpinv) << '\n'
            << "Cpinv_opt : " << cost_function(xi, xli, Hpinv_opt) << '\n'
            << "Ccv : " << cost_function(xi, xli, Hcv) << '\n';

  Horig.print("Horig");  
  Hcv.print("Hcv");  
  Hdlt.print("Hdlt");  
  Hdlt_opt.print("Hdlt_opt");
  Hpinv.print("Hpinv");  
  Hpinv_opt.print("Hpinv_opt");  
}