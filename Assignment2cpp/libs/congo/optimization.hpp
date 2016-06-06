#ifndef __LIB_CONGO_OPTIMIZATION_HPP__
#define __LIB_CONGO_OPTIMIZATION_HPP__

#include <armadillo>

namespace congo {

using namespace arma;

mat optimize (const mat& xi, 
              const mat& xli, 
              const mat& H0) {
  using namespace arma;

  mat Hvec = vectorise(H0);
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


} // ::congo

#endif