COMPILER = g++
FLAGS = -std=c++14 -O3 -Werror -Wextra -Wall -Wfloat-equal -Wundef -Wshadow -Wcast-align -Wconversion -Wswitch-enum -Wswitch-default
LIBS = -larmadillo -lblas -llapack

main.o: main.cpp
	g++ main.cpp $(FLAGS) $(LIBS) -o main