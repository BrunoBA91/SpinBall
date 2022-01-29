%%%%% Gear Mask Erosion %%%%%

width_contour = 5;
kernel = ones(3,3);
im = imread('GearMask.png');
im = (im > 50);
nim = im;
for i = 1:width_contour
    im_erode = imerode(nim, kernel);
    nim = im_erode;
end
im_result = 255*(im - im_erode);
imwrite(im_result,'GearMaskErodedMatlab.png');
imshow(im_result);
