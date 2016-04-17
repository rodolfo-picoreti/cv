#ifndef __LIB_CONGO_RANSAC_HPP__
#define __LIB_CONGO_RANSAC_HPP__

#include <armadillo>
#include <cstdint>

namespace congo {

using namespace arma;

/* 
  @description: generate vector with random unique indices 
    values from [first, last).
*/
uvec rand_indices(uint_fast32_t first, uint_fast32_t last) {
  uvec range = regspace<uvec>(0, last-1);
  return shuffle(range);
}


namespace ransac {

/* 
  RANSAC - RANdom SAmple Consensus
    
    1. Select randomly the minimum number of points required 
      to determine the model parameters.
    
    2: Solve for the parameters of the model.
    
    3: Determine how many points from the set of all points 
      fit with a predefined tolerance.
    
    4: If the fraction of the number of inliers over the total 
      number points in the set exceeds a predefined threshold 
      τ, re-estimate the model parameters using all the
      identified inliers and terminate.
    
    5: Otherwise, repeat steps 1 through 4 (maximum of N times).
*/


struct options {
/* 
  .max_iter: the maximum number of iterations allowed.
  .nfit_points: the number of data points used to estimate the model.
  .tolerance: determines if a data point is inlier.

  .model_function: function used to estimate the model
  .cost_function: function used to estimate the model cost
*/
  uint_fast32_t max_iter;
  uint_fast32_t nfit_points;
  double tolerance;

  std::function<mat(const mat&)> model_function;
  std::function<mat(const mat&, const mat&)> cost_function;
};

mat find_inliers(mat data, options opt) {
  uint_fast32_t n_inliers = 0;
  uvec best_indices;

  uvec indices = rand_indices(0, data.n_cols);
  
  uint_fast32_t iter = 0;
  while (iter < opt.max_iter) {
    mat maybe_inliers = data.cols(indices.head(opt.nfit_points));
    mat model = opt.model_function(maybe_inliers);
    mat distances = opt.cost_function(model, data);
    uvec inliers = find(distances < opt.tolerance);

    if (inliers.n_elem > n_inliers) {
      n_inliers = inliers.n_elem;
      best_indices = inliers;
    }

    indices = shuffle(indices); // generate new random indexes
    ++iter;
  }

  return data.cols(best_indices);
}

} // ::ransac 

} // ::congo 

#endif // __LIB_CONGO_RANSAC_HPP__