COMPILER = g++
FLAGS = -std=c++14 -O3 -Wextra -Wall -Wundef -Wcast-align -Wswitch-enum
LIBS = -larmadillo -lblas -llapack

DLIB_FLAGS = -I /home/melchior/Downloads/dlib-18.18/ -lpthread -lX11

main.o: main.cpp
	g++ main.cpp $(FLAGS) $(LIBS) -o main $(DLIB_FLAGS)