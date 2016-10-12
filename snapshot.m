function [im_left, im_right] = snapshot()


vid = videoinput('pointgrey', 1);
set(vid, 'ReturnedColorSpace', 'RGB');
snap = [];

%tira snap
snap = getsnapshot(vid);

%divide imagem
im = snap(200:768,:,:);

im_left = im(:,1:1024,:);
im_right = im(:,1025:2048,:);





end
