#include <armadillo> 
#include <cstdint>
#include <cmath>

#include <iostream>
#include "libs/congo/ransac.hpp"

arma::mat generate_line_data(int length, double outlier_proportion) {
  using namespace arma;
  long int n_outliers = std::lround(outlier_proportion*length);

  mat data = ones(3, length);
  data.row(0) = linspace<mat>(1, 10, length).t(); 
  data.row(1) = linspace<mat>(1, 10, length).t()*2.5 + 3;
  
  uvec indices = congo::rand_indices(0, data.n_cols);
  data.cols(indices.head(n_outliers)) += 
    join_cols(
      join_cols( zeros(1,n_outliers), randn(1,n_outliers) ), zeros(1,n_outliers) ); 

  return data;
}

arma::mat fit_model(const arma::mat& data) {
  return arma::cross(data.col(0), data.col(1));
}

arma::mat distance_function(const arma::mat& model, const arma::mat& data) {
  double norm = sqrt(model(0,0)*model(0,0) + model(1,0)*model(1,0));
  arma::mat normalized_line = model/norm;
  return arma::abs(normalized_line.t() * data);
}

int main() {
  using namespace arma;
  arma_rng::set_seed_random();

  congo::ransac::parameters parameters {
    .nfit_points = 2,
    .distance_threshold = 1e-2,
    .model_function = fit_model,
    .distance_function = distance_function
  };

  mat data = generate_line_data(100, 0.45);
  mat inliers = congo::ransac::find_inliers(data, parameters);
    
  data = data.t();
  inliers = inliers.t();

  data.save("data.mat", raw_ascii); 
  inliers.save("inliers.mat", raw_ascii);
}