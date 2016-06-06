#include <iostream>

#include "opencv2/core.hpp"
#include "opencv2/features2d.hpp"
#include "opencv2/imgcodecs.hpp"
#include "opencv2/imgproc.hpp"
#include "opencv2/highgui.hpp"
#include "opencv2/xfeatures2d.hpp"
#include <opencv2/calib3d/calib3d.hpp>

int main (int argc, char** argv) {
  using namespace std;
  using namespace cv;
  using namespace cv::xfeatures2d;
  
  if (argc != 3) { 
    std::cout << " Usage: ./surf <img1> <img2>" << std::endl; 
    return -1; 
  }
  
  Mat img1 = imread(argv[1], IMREAD_GRAYSCALE);
  Mat img2 = imread(argv[2], IMREAD_GRAYSCALE);
  
  if (!img1.data || !img2.data ) { 
    std::cout << " --(!) Error reading images " << std::endl; 
    return -1; 
  }
  
  //-- Step 1: Detect the keypoints using SURF Detector, compute the descriptors
  Mat descriptors1, descriptors2;
  std::vector<KeyPoint> keypoints1, keypoints2;
  int minHessian = 800;

  Ptr<SURF> detector = SURF::create();
  detector->setHessianThreshold(minHessian);
  detector->detectAndCompute(img1, Mat(), keypoints1, descriptors1);
  detector->detectAndCompute(img2, Mat(), keypoints2, descriptors2);

  //-- Step 2: Matching descriptor vectors using FLANN matcher
  std::vector<DMatch> matches;
  FlannBasedMatcher matcher;
  matcher.match(descriptors1, descriptors2, matches);
  
  //-- Quick calculation of max and min distances between keypoints
  double max_dist = 0; 
  double min_dist = 100;
  for (int i = 0; i < descriptors1.rows; i++) { 
    double dist = matches[i].distance;
    if (dist < min_dist) min_dist = dist;
    if (dist > max_dist) max_dist = dist;
  }
  
  //-- Draw only "good" matches (i.e. whose distance is less than 2*min_dist,
  //-- or a small arbitary value ( 0.02 ) in the event that min_dist is very
  //-- small)
  //-- PS.- radiusMatch can also be zused here.
  std::vector<DMatch> good_matches;  
  for (int i = 0; i < descriptors1.rows; i++) { 
    if (matches[i].distance <= max(2*min_dist, 0.02)) { 
      good_matches.push_back(matches[i]); 
    }
  }

  Mat xi(good_matches.size(), 3, CV_64F, 1.0);
  Mat xli(good_matches.size(), 3, CV_64F, 1.0);
  for (int i = 0; i < good_matches.size(); i++) { 
    xi.row(i).col(0) = keypoints1[good_matches[i].queryIdx].pt.x;
    xi.row(i).col(1) = keypoints1[good_matches[i].queryIdx].pt.y;
    xli.row(i).col(0) = keypoints2[good_matches[i].trainIdx].pt.x;
    xli.row(i).col(1) = keypoints2[good_matches[i].trainIdx].pt.y;
  }

  //-- Draw only "good" matches
  Mat img_matches;
  drawMatches(img1, keypoints1, img2, keypoints2,
              good_matches, img_matches, Scalar::all(-1), Scalar::all(-1),
              vector<char>(), DrawMatchesFlags::NOT_DRAW_SINGLE_POINTS);
  
  //-- Show detected matches
  imshow ("Good Matches", img_matches );

  Mat H = findHomography(xi, xli);
  Mat Hpinv = xi.inv(DECOMP_SVD)*xli; 
  
  std::cout << "H: \n:" << H << "\n\n";
  std::cout << "Hpinv: \n:" << Hpinv.t() << "\n\n";
  
  Mat img2warp(img1.rows, img1.cols, CV_32F);
  warpPerspective(img1, img2warp, Hpinv.t(), Size(img1.cols, img1.rows));
  imshow ("img2warp", img2warp);

  while (waitKey(0) != 27);
  return 0;
}