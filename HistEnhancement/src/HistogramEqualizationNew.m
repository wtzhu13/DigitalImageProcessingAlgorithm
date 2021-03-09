%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210203
%% fuction: 直方图均衡化
%% --------------------------------

clear;
clc;
close all;
img = imread('..\images\gray64.jpg');
[height, width] = size(img);
figure
subplot(121);imshow(img);title('original image');
subplot(122);

%% 直方图归一化
[counts,x] = imhist(img, 256);
counts = counts/height/width;
stem(x,counts, 'Marker', 'none');
title('org hist image');

%% 直方图均衡化
% 定义LUT映射表
% 根据直方图均衡化计算公式计算出映射表
pixelLUT = linspace(1, 256, 256);
p_sum = 0;
for i = 1:256
    p_sum = p_sum + counts(i);
    pixelLUT(i) = uint8(p_sum * 255);
end 

newImg = zeros(height, width);
for i =1:height
    for j =1:width
        newImg(i, j) = pixelLUT(uint64(img(i, j)) + 1);
    end
end 
newImg = uint8(newImg);
figure();
subplot(121);imshow(newImg);title('new image');
subplot(122);imhist(newImg);title('new hist');

%% 使用MATLAB自带的算子
histeqImg = histeq(img, 256);
figure();
subplot(121);imshow(histeqImg);title('hist image');
subplot(122);imhist(histeqImg);title('hist hist');

%% 直方图均衡化之后，图像会有偏亮的现象，因为原图像中0的积累，导致映射表中的0对应新的表中不为0
% 为解决此问题，需要将灰度级也均衡一下
newImg1 = zeros(height, width);
for i =1:height
    for j =1:width
        newImg1(i, j) = uint8((double(newImg(i, j) - pixelLUT(1)) / double(255 - pixelLUT(1))) * 255);
    end
end 
newImg1 = uint8(newImg1);
figure();
subplot(121);imshow(newImg1);title('new image1');
subplot(122);imhist(newImg1);title('new hist1');

%% 也可以自己定义一个绘制直方图的方式暂时不用
% histList = zeros(1, 256);
% Xaxis = linspace(0, 255, 256);
% for i =1:height
%     for j =1:width
%         histList(img(i, j) + 1) = histList(img(i, j) + 1) + 1;
%     end
% end
% for i = 1:255
%     histList(i) = histList(i) / (height *width);
% end
% figure();bar(Xaxis, histList);




