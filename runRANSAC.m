function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)

max = 0;

% while loop ends when reach the maximum number of RANSAC iterations
n = 1;
while n <= ransac_n
    % randomized 1*4 array
    i = randi(length(Xs),1,4);
    H_3x3 = computeHomography(Xs(i,:), Xd(i,:));
    d_pts = applyHomography(H_3x3,Xs);
    
    diff = d_pts - Xd;
    s = sqrt(sum(diff.*diff,2));
    % col array that meets s < eps (finding inliers)
    id = find(s < eps);
    if length(id) > max
        max = length(id);
        H = H_3x3;
        inliers_id = id;
    end
    % incrementing counters
    n = n + 1;
end