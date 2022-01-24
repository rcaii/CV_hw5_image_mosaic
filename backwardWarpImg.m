function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

w = dest_canvas_width_height(1);
h = dest_canvas_width_height(2);

% B = repmat(A,n) returns an array containing n copies of A in the row and 
% column dimensions. The size of B is size(A)*n when A is a matrix.
x = repmat((1:w)',1,h)';
x = x(:)';
y = repmat(1:h,1,w);
B = resultToSrc_H * [x;y;ones(1,w*h)];

% Calculating xs and ys at n
x_n = B(1,:)./B(3,:);
y_n = B(2,:)./B(3,:);

% Initialize the result image
result_img = zeros(w*h,3);

% Getting size of source image and taking out the points that is not in the
% range of the source image size
[m,n,~] = size(src_img);
out_pt = find(x_n >=1 & x_n <= n  & y_n >= 1 & y_n <= m);
for i = 1:3
    result_img(out_pt, i) = interp2(src_img(:,:,i), x_n(out_pt(:)), y_n(out_pt(:)));
end

result_img = reshape(result_img, h, w, 3);

mask = zeros(1, w*h);
mask(out_pt) = 1;
mask = reshape(mask, h, w);
