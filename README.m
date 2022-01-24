% README - WEIJIE CAI
% 
% Challenge a:
% 1: Completed computeHomography by calculating A matrixes, finding the 
% eigenvalue of A'A, getting the vector, and filling in the Homography
% matrix to receive the 3x3 matrix.
% 2: use the function we learned during class to receive the destination
% points via homogeneous coordinates of points.
% 3: draw red lines to show correspondent points between the source and 
% destination images, with setting up the image information.
% 
% Challenge b:
% Getting mask and destination image using backward warpping method discussed
% in class to fit the image into the destination canvas by reformating the 
% size of the canvas and setting them into required matrices, then apply
% the calculated homography matrix into it, and taking out outside points to
% receive the final image.
% 
% Challenge c:
% Finding inliners of the set of points using the concept of RANSAC discussed
% in class, which is less than the acceptable alignment pixels provided,
% returns the inliner id as the set of points and the matrix after the 
% homography.
% 
% Challenge d:
% Set masks into logical values, use euclidean distance transformation, and 
% getting 'blended' image using weighted blending method and 'overlay' image
% while unweighted.
%     
% Challenge e:
% Stitch the image by looping through all image input, using the homography 
% previously used to find the boundings of each image and update the rows 
% and cols of the result stitched image, then update the final Homography
% matrix using the similar methods.
% 
% Challenge f:
% I took 3 pictures of the NYC street and used the pre-defined stitched img
% method to implement the 'blended' street panorama, which receives the 
% expected output.