#include <armadillo> // -larmadillo
#include <cstdint>
#include <cmath>
#include <iostream>
#include "libs/congo/ransac.hpp"

arma::mat fit_model(const arma::mat& data) {
  return arma::cross(data.col(0), data.col(1));
}

arma::mat cost_function(const arma::mat& model, const arma::mat& data) {
  double norm = sqrt(model(0,0)*model(0,0) + model(1,0)*model(1,0));
  arma::mat normalized_line = model/norm;
  return arma::abs(normalized_line.t() * data);
}

int main() {
  using namespace arma;
  arma_rng::set_seed_random();

  congo::ransac::options opt {
    .max_iter = 100,
    .nfit_points = 2,
    .tolerance = 1e-2,
    .model_function = fit_model,
    .cost_function = cost_function
  };

  int N = 100;
  double p = 0.45;
  int O = std::floor(p*N);

  mat data = ones(3, N);
  data.row(0) = linspace<mat>(1, 10, N).t(); 
  data.row(1) = linspace<mat>(1, 10, N).t()*2.5 + 3;
  
  uvec indices = congo::rand_indices(0, data.n_cols);
  data.cols(indices.head(O)) += 
    join_cols(
      join_cols( zeros(1,O), 100*randn(1,O) ), zeros(1,O) ); 
  
  mat inliers = congo::ransac::find_inliers(data, opt);

  data = data.t();
  inliers = inliers.t();

  data.save("data.mat", raw_ascii); 
  inliers.save("inliers.mat", raw_ascii);
}