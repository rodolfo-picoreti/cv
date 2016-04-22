#ifndef __LIB_CONGO_RANSAC_HPP__
#define __LIB_CONGO_RANSAC_HPP__

#include <armadillo>
#include <cstdint>
#include <cmath>

namespace congo {

using namespace arma;
using namespace std;

/* 
  @description: generate vector with random unique indices 
    values from [first, last).
*/
uvec rand_indices(uint_fast32_t first, uint_fast32_t last) {
  uvec range = regspace<uvec>(first, last-1);
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


struct parameters {
/* 
  .max_iter: the maximum number of iterations allowed.

  .nfit_points: the minimum number of data values required 
    to fit the model.
  
  .distance_threshold: a threshold value for determining when 
    a data point fits a model.
  
  .outlier_proportion: outliers proportion on the data set.

  .model_function: function used to estimate the model.

  .distance_function: function used to estimate the model cost.
*/
  //uint_fast32_t max_iter;
  uint_fast32_t nfit_points;
  double distance_threshold;
  //double outlier_proportion;

  function<mat(const mat&)> model_function;
  function<mat(const mat&, const mat&)> distance_function;
};

mat find_inliers(mat data, const parameters& params) {
  uint_fast32_t n_inliers = 0;
  double outlier_proportion;
  
  uvec best_indices;
  uvec indices = rand_indices(0, data.n_cols);
  
  uint_fast32_t iter = 0;
  uint_fast32_t iter_max = -1;
  while (iter < iter_max) {
    mat maybe_inliers = data.cols(indices.head(params.nfit_points));
    
    mat model = params.model_function(maybe_inliers);
    
    mat distances = params.distance_function(model, data);
    
    uvec inliers = find(distances < params.distance_threshold);
    
    if (inliers.n_elem > n_inliers) {
      n_inliers = inliers.n_elem;
      best_indices = inliers;
  
      outlier_proportion = 1.0 - (double) inliers.n_elem / (double) data.n_cols; 
      iter_max = lround(
        log(1.0 - 0.99) / log(1.0 - pow(1.0 - outlier_proportion, params.nfit_points))
      );
    }

    indices = shuffle(indices); // generate new random indexes
    ++iter;
  }

  return data.cols(best_indices);
}

} // ::ransac 

} // ::congo 

#endif // __LIB_CONGO_RANSAC_HPP__