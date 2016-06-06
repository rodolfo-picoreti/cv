#ifndef __LIB_CONGO_TRANSFORM_HPP__
#define __LIB_CONGO_TRANSFORM_HPP__

#include <armadillo>

namespace congo {

using namespace arma;

mat rotate2d(double theta) {
  theta *= datum::pi / 180.0;
  mat t {
    { cos(theta),  -sin(theta),  0.0 },
    { sin(theta),   cos(theta),  0.0 },
    { 0.0,           0.0,        1.0 }
  };
  return t;
}

mat translate2d(double tx, double ty) {
  mat t {
    { 1.0,  0.0,  tx  },
    { 0.0,  1.0,  ty  },
    { 0.0,  0.0,  1.0 }
  };
  return t;
}

mat scale2d(double sx, double sy) {
  mat t {
    { sx,   0.0,  0.0 },
    { 0.0,  sy,   0.0 },
    { 0.0,  0.0,  1.0 }
  };
  return t;
}

} // ::congo

#endif