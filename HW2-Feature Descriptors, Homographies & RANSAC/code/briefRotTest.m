function [] = briefRotTest()
% Script to test BRIEF under rotations
% load images and rotate, compute feature mathces

im = imread('../data/model_chickenbroth.jpg');

% initialize matrix to store number of matches
num_matches = zeros(1, 35);
index = 1;

% compute the matches against rotate angle
for angle = 0:10:350
    
    % rotate the image by certain angle
    im_rotate = imrotate(im, angle);
    
    im = im2double(im);
    im_rotate = im2double(im_rotate);
    
    % turn the images into gray scale
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    if size(im_rotate, 3) == 3
        im_rotate = rgb2gray(im_rotate);
    end

    % compute descriptors for both images
    [~, desc1] = briefLite(im);
    [~, desc2] = briefLite(im_rotate);

    % compute feature matches of two images
    [matches] = briefMatch(desc1, desc2, 0.8);
    num_matches(index, 1) = size(matches, 1);
    index = index + 1;
    
end 

% construct bar graph (rotation angle VS num_matches)
bar(0:10:350, num_matches, 'c', 'LineWidth', 0.75);

