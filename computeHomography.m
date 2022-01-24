function H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2)

A = zeros(8,8);
x_s = src_pts_nx2(:,1);
y_s = src_pts_nx2(:,2);
x_d = dest_pts_nx2(:,1);
y_d = dest_pts_nx2(:,2);

% Calculating A matrix
for i = 1:4
    A(2*i-1,1:3) = [x_s(i), y_s(i), 1];
    A(2*i,4:6) = [x_s(i), y_s(i), 1];
    A(2*i-1,7:9) = -x_d(i)*[x_s(i), y_s(i), 1];
    A(2*i, 7:9) = -y_d(i)*[x_s(i), y_s(i), 1];
end

% Eigenvalue of A'A
[V, D] = eig(A'*A);
% Minimize the lost function
[~, I] = min(diag(D));

% Getting vector
v = V(:,I);

% fill in the homography matrix
for i = 1:3
    H_3x3(1,i) = v(i);
    H_3x3(2,i) = v(3+i);
    H_3x3(3,i) = v(6+i);
end


