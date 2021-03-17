%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210316
%% fuction: 拉普拉斯算子应用
%% --------------------------------

clear;
clc;
close all;
img = imread('./images/house.tif');
[height, width] = size(img);
figure;subplot(121);imshow(img);title('original image');

img1 = im2single(img);
w = fspecial('laplacian', 0);
I1 = imfilter(img, w, 'replicate');
subplot(122);imshow(I1);title('laplacian image');