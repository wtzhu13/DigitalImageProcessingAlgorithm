%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210203
%% fuction: 直方图均衡化
%% --------------------------------

clear;
clc;
close all;
img = imread('../images/gray64.jpg');
[height, width] = size(img);
figure
subplot(221);imshow(img);title('original image');
subplot(222);

%% 直方图归一化
[counts,x] = imhist(img, 256);
counts = counts/height/width;
stem(x,counts, 'Marker', 'none');
title('org hist image');

%% 直方图均衡化
% 定义LUT映射表
% 根据直方图均衡化计算公式计算出映射表
pixelLUT = linspace(0, 255, 256);
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

subplot(223);imshow(newImg);title('new image');
subplot(224);imhist(newImg);title('new hist');


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




