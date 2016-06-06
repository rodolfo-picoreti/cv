addpath('./lib')
addpath('./data')
clc; clear; close all;

load set03.mat

N = length(pts_img1);
points = [ pts_img1; ones(1,N); pts_img2; ones(1,N) ];

options.model = @(u) dlt(u(1:3,:), u(4:6,:));
options.distance = @(H, u) reprojerror(u(1:3,:), u(4:6,:), H); 
options.nfit = 8;
options.threshold = 4;

inliers = ransac(points, options);
u1 = inliers(1:3,:);
u2 = inliers(4:6,:);

% show all correspondences 
figure
showimgs(im1, im2);
pause(0.1)
hold on
plot([pts_img1(1,:); pts_img2(1,:)],[pts_img1(2,:); pts_img2(2,:)+size(im1,1)])

% show filtered correspondences 
figure
showimgs(im1, im2);
pause(0.1)
hold on
plot([u1(1,:); u2(1,:)],[u1(2,:); u2(2,:)+size(im1,1)])

Hdlt = dlt(u1, u2)
Edlt = mean(reprojerror(u1, u2, Hdlt)) % Mean error before optimization

Hopt = optimize(u1, u2, Hdlt) % Minimize reprojection error
Eopt = mean(reprojerror(u1, u2, Hopt)) % Mean error after optimization

im2w = warpimg(im1, Hopt);

% show warped image 
figure
showimgs(im2w, im2);