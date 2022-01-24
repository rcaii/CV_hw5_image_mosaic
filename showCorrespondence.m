function result_img = ...
    showCorrespondence(orig_img, warped_img, src_pts_nx2, dest_pts_nx2)

f1 = figure();
imshow([orig_img, warped_img]);

% source
hold on;
plot(src_pts_nx2(:,1), src_pts_nx2(:,2), 'r.', 'MarkerFaceColor', [1 1 1]);

% destination
hold on;
plot(dest_pts_nx2(:,1) + size(orig_img, 2), dest_pts_nx2(:,2), 'r.', 'MarkerFaceColor', [1 1 1]);

% drawing lines
for i = 1:length(src_pts_nx2)
    line([src_pts_nx2(i,1), dest_pts_nx2(i,1)+size(orig_img,2)], [src_pts_nx2(i,2), dest_pts_nx2(i,2)], 'LineWidth',2 , 'Color', [1, 0, 0]);
end

% getting independent window
set(f1, 'WindowStyle', 'normal');
img = getimage(f1);
% adjust the size
truesize(f1, [size(img, 1), size(img, 2)]);

frame = getframe(f1);
frame = getframe(f1);
result_img = frame.cdata;
