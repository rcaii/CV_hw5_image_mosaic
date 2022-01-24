function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)

% Getting xs
Matrix(1,:) = src_pts_nx2(:,1)';
% Getting ys
Matrix(2,:) = src_pts_nx2(:,2)';
% Setting zs
Matrix(3,:) = ones(1, length(src_pts_nx2));

% Apply homography to bars (destination) 
B = H_3x3 * Matrix;

for i = 1:2
    x(i,:) = B(i,:)./B(3,:);
end

dest_pts_nx2 = x';