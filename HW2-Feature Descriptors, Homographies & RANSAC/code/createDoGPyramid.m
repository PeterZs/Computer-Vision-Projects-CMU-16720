function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
%%Produces DoG Pyramid
% inputs
% Gaussian Pyramid - A matrix of grayscale images of size
%                    (size(im), numel(levels))
% levels      - the levels of the pyramid where the blur at each level is
%               outputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%               created by differencing the Gaussian Pyramid input


% test
load('GaussianPyramid.mat');
levels = size(GaussianPyramid, 3);

% fectch dimention
[H, W] = deal(size(GaussianPyramid, 1), size(GaussianPyramid, 2));

% initialize DoG matrix
DoGLevels = levels - 1;
DoGPyramid = zeros(H, W, DoGLevels);

for l = 2:levels
    DoGPyramid(:, :, l - 1) = GaussianPyramid(:, :, l) - GaussianPyramid(:, :, l - 1);
end 

save('DoGPyramid.mat');
