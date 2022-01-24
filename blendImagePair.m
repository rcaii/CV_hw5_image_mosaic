function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)

% turn masks into logical values
mask_s = logical(masks);
mask_d = logical(maskd);

d = mask_s .*mask_d;
% Euclidean distance transform
Ds = bwdist(mask_s-d)+1;
Dd = bwdist(mask_d-d)+1;

switch mode
    case 'blend'
        z1 = Ds .*mask_s;
        z1 = (max(z1(:))+1-z1).*mask_s/max(z1(:));
        z1 = nthroot(z1,1.5);
        
        z2 = Dd .*mask_d;
        z2 = (max(z2(:))+1-z2).*mask_d/max(z2(:));
        z2 = nthroot(z2,1.5);
        % I_blend = (w1I1 + w2I2)/w1+w2
        out_img = uint8((double(wrapped_imgs).*cat(3, z1, z1, z1)+double(wrapped_imgd).*cat(3, z2, z2, z2))./cat(3,z1+z2,z1+z2,z1+z2));
    case 'overlay'
        % hard overlay without weighted
        out_img = (wrapped_imgs.*uint8(cat(3, mask_s, mask_s, mask_s))).*uint8(cat(3,~mask_d,~mask_d,~mask_d))+wrapped_imgd.*uint8(cat(3, mask_d, mask_d, mask_d));
end