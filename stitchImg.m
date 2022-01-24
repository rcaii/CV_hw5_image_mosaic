function stitched_img = stitchImg(varargin)

% Set the stitched img for the first input (center img)
input = varargin{1};
[m,n,l] = size(input);
test_pts = [1,1; n,1; 1,m; n,m];
stitched_img = input;

% Going through all image inputs
i = 1;
while i < length(varargin)
    % starting with the second image input
    i = i+1;
    input = varargin{i};
    
    [xs, xd] = genSIFTMatches(input, stitched_img);
    [~, H_3x3] = runRANSAC(xs, xd, 1000, 2.0);
    d_pts = applyHomography(H_3x3, test_pts);
    
    % boundings
    b1 = min(d_pts(:,1));
    b2 = max(d_pts(:,1));
    b3 = min(d_pts(:,2));
    b4 = max(d_pts(:,2));
    
    % out of boundary condition: extend the size 
    if (b1 < 1)
        stitched_img = [zeros(m, ceil(1-b1), l), stitched_img];
    end
    if (b2 > n)
        stitched_img = [stitched_img, zeros(m, ceil(b2-n), l)];
    end
    % new cols
    n = n + max(0, ceil(1-b1)) + max(0, ceil(b2-n));
    if (b3 < 1)
        stitched_img = [zeros(ceil(1-b3), n, l); stitched_img];
    end
    if (b4 > m)
        stitched_img = [stitched_img; zeros(ceil(b4-m), n, l)];
    end
    % new rows
    m = m + max(0,ceil(b4-m)) + max(0,ceil(1-b3));
    
    d_pts(:,1) = floor(d_pts(:,1) + max(0,ceil(1-b1)));
    d_pts(:,2) = floor(d_pts(:,2) + max(0,ceil(1-b3)));
    
    % use previously defined methods to get new Homography matrix
    H_3x3 = computeHomography(test_pts, d_pts);
    dest_canvas_width_height = [size(stitched_img, 2), size(stitched_img, 1)];
    [mask, dest_img] = backwardWarpImg(input, inv(H_3x3), dest_canvas_width_height);
    % blend the image
    stitched_img = blendImagePair(dest_img*255, mask, stitched_img*255, rgb2gray(stitched_img),'blend');
    stitched_img = im2single(stitched_img); 
end
