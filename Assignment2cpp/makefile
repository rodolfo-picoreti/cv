COMPILER = g++
FLAGS = -std=c++14 -O3 -Wextra -Wall -Wundef -Wcast-align -Wswitch-enum
LIBS = -larmadillo -lblas -llapack

OPENCV_FLAGS = -I/usr/local/include -L/usr/local/lib -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_aruco -lopencv_bgsegm -lopencv_bioinspired -lopencv_ccalib -lopencv_dnn -lopencv_dpm -lopencv_fuzzy -lopencv_hdf -lopencv_line_descriptor -lopencv_optflow -lopencv_plot -lopencv_reg -lopencv_saliency -lopencv_stereo -lopencv_structured_light -lopencv_rgbd -lopencv_surface_matching -lopencv_tracking -lopencv_datasets -lopencv_text -lopencv_face -lopencv_xfeatures2d -lopencv_shape -lopencv_video -lopencv_ximgproc -lopencv_calib3d -lopencv_features2d -lopencv_flann -lopencv_xobjdetect -lopencv_objdetect -lopencv_ml -lopencv_xphoto -lopencv_highgui -lopencv_videoio -lopencv_imgcodecs -lopencv_photo -lopencv_imgproc -lopencv_core

DLIB_FLAGS = -I /home/melchior/Downloads/dlib-18.18/ -lpthread -lX11

main.o: main.cpp
	g++ main.cpp $(FLAGS) $(LIBS) -o main $(DLIB_FLAGS) $(OPENCV_FLAGS)  $(OPENCV_LIBS) 