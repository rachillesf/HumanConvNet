setup;
num_captures = 500

log = ones(500,1000,3,num_captures);
figure;
for i = 1:num_captures

[im_left, im_right] = snapshot();

[cordenadas,out] = GetCoordinades(im_left);
log(:,:,:,i) = out./256;

end