function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image

% % test
% img1 = imread('../data/incline_L.png');
% img2 = imread('../data/incline_R.png');

% warp the image
out_size = [800 1800];
warped = warpH(img2, H2to1, out_size);

% visualize the warped image
imshow(warped)
imwrite(warped, '../results/6_1.jpg')

% stitch images together to produce panorams
% panoImg = blend 

