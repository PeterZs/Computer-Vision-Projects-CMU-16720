function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC

% test

% set default value of parameters
if exist('nIter', 'var') == 0
    nIter = 1000;
end 
if exist('tol', 'var') == 0
    tol = 4;
end 

% initialize best H matrix
bestH = zeros(3,3);
maxInliners = -1;

% initialize the coordinates of points, 2xN matrix 
num_matches = size(matches, 1);
p1 = (locs1(matches(:,1), 1:2))';
p2 = (locs2(matches(:,2), 1:2))';

% iterative RANDSAC algorithm
for i = 1:nIter
    
    % randomly pick four points, 2xN matrix 
    randIndex = randperm(num_matches, 4);
    rand1 = (locs1(matches(randIndex,1), 1:2))';
    rand2 = (locs2(matches(randIndex,2), 1:2))';
    
    % compute the fitted H matrix 
    H = computeH(rand1, rand2);
    
    % add dummy 1s to p2 and compute the estimated p1s
    p2_dummy = [p2; ones(1, num_matches)];
    p1_est = H * p2_dummy;
    p1_est = p1_est ./ repmat(p1_est(3,:),3,1);
    
    % compute inliners
    Xdiff = (p1(1,:) - p1_est(1,:)).^2;
    Ydiff = (p1(2,:) - p1_est(1,:)).^2;
    num_inliners = 0;
    for j = 1:num_matches
       num_inliners = num_inliners + (Xdiff + Ydiff < tol^2);
    end
    if num_inliners > maxInliners
       maxInliners = num_inliners;
       bestH = H;
    end
end 
