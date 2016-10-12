setup;
num_captures = 500


figure;
for i = 1:num_captures

[im_left, im_right] = snapshot();
[frameLeftRect, frameRightRect] =  rectifyStereoImages(im_left, im_right, stereoParams);
% Convert to grayscale.
frameLeftGray  = rgb2gray(frameLeftRect);
frameRightGray = rgb2gray(frameRightRect);

 % Compute disparity.
 disparityMap = disparity(frameLeftGray, frameRightGray);
 
 imshow(disparityMap, [0, 64]);
 title('Disparity Map');
 colormap jet
 colorbar

end