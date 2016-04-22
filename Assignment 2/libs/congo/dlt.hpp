
#ifndef __LIB_CONGO_DLT_HPP__
#define __LIB_CONGO_DLT_HPP__

#include <armadillo>

namespace congo {

using namespace arma;

namespace dlt {

mat normalize_2d(subview<double> points) {
  // centroid
  double xc = mean(points.row(0));
  double yc = mean(points.row(1));
    
  mat T {
    { 1, 0, -xc },
    { 0, 1, -yc },
    { 0, 0,   1 }
  };
  points = T*points;

  double mean_norm = 0;
  points.rows(0,1).each_col([&mean_norm] (vec& col) {
    mean_norm += norm(col);
  });
  mean_norm /= (double) points.n_cols;

  double s = sqrt(2.0) / mean_norm;
  mat S {
    { s, 0, 0 },
    { 0, s, 0 },
    { 0, 0, 1 }
  };

  points = S*points;
  return S*T;
}

mat homography_2d(mat points) {
  if (points.n_rows != 6 || points.n_cols < 4) {
    throw std::logic_error("dlt_2d points matrix must be 6xn, where n >= 4");
  }

  mat Txi = normalize_2d(points.rows(0, 2));
  mat Txli = normalize_2d(points.rows(3, 5));

  mat A = zeros(2*points.n_cols, 9);

  for (uword i = 0; i < points.n_cols; i++) {
    mat Xi = points(span(0,2), i).t();
    
    double xli = points(3, i);
    double yli = points(4, i);
    double wli = points(5, i);

    A(2*i, span(3,5)) = -wli * Xi;
    A(2*i, span(6,8)) = +yli * Xi;

    A(2*i+1, span(0,2)) = +wli * Xi;
    A(2*i+1, span(6,8)) = -xli * Xi;
  }

  mat U;
  vec D;
  mat V;

  svd(U, D, V, A);
  
  mat H_tilda = reshape(V.col(8).t(), 3, 3);
  mat H = inv(Txli) * H_tilda * Txi;
  return H / H(2,2);
}

} // ::dlt

} // ::congo

#endif