%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210203
%% fuction: 拉普拉斯算子应用
%% --------------------------------

clear;
clc;
close all;
m = [0 0 0 255 255 255;
     0 0 0 255 255 255;
     0 0 0 255 255 255;
     0 0 0 255 255 255;
     0 0 0 255 255 255;
     0 0 0 255 255 255;];
img = imread('./images/blurry_moon.tif');
[height, width] = size(img);
figure;imshow(img);title('original image');

img1 = im2single(img);
w = fspecial('laplacian', 0);
I1 = imfilter(img, w, 'replicate');
figure;imshow(I1);title('laplacian image');
figure;imshow(img-I1);title('laplacian image');