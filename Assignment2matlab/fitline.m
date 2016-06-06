%%
%% @fitline: Find correct line fit using ransac to filter noisy points
%%
addpath('./lib')
addpath('./data')
clc; clear;

N = 100;
M = 20;

x = linspace(0, 10, N);
y = 5*x + 2;
z = ones(1, N);
points = [x; y; z];

i = randperm(N,M);
points(2,i) = points(2,i) + rand(1,M)*100 - 50;

options.model = @(points) cross(points(:,1), points(:,2));
options.distance = @(line, points) abs(line'/norm(line) * points);
options.nfit = 2;
options.threshold = 1e-3;

inliers = ransac(points, options);

plot(points(1,:), points(2,:), inliers(1,:), inliers(2,:), 'x')