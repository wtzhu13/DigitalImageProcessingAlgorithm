%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210303
%% fuction: 局部在直方图增强
%% --------------------------------
clear;
clc;
close all;
img = imread('./images/tungsten_original.tif');
[m, n] = size(img);
figure
subplot(231);imshow(img);title('original image');
subplot(232);
[orgDistribution,x] = imhist(img, 256);
orgDistribution = orgDistribution/m/n;
stem(x,orgDistribution, 'Marker', 'none');
title('org hist image');

%% 局部增强
% 求整个图像的均值和标准差
img_mean = mean(mean(img));
img_std = std2(img);

% 定义一个5*5的邻域
% 对图像进行扩充
a = img(1,:);%取f的第1行
c = img(m,:);%取f的第m行
b = [img(1,1), img(1,1), img(:,1)', img(m,1), img(m,1)];
d = [img(1,n), img(1,n), img(:,n)', img(m,n), img(m,n)];
a1 = [a; a; img; c; c];
b1 = [b; b; a1'; d; d];
expandImage = double(b1');
newImg = zeros(m, n);
for i = 3: 300
    for j = 3: 254
        partial_matrix = [
                          expandImage(i-2, j-2) expandImage(i-2, j-1) expandImage(i-2, j) expandImage(i-2, j+1) expandImage(i-2, j+2);
                          expandImage(i-1, j-2) expandImage(i-1, j-1) expandImage(i-1, j) expandImage(i-1, j+1) expandImage(i-1, j+2);
                          expandImage(i, j-2)   expandImage(i, j-1)   expandImage(i, j)   expandImage(i, j+1)   expandImage(i, j+2);
                          expandImage(i+1, j-2) expandImage(i+1, j-1) expandImage(i+1, j) expandImage(i+1, j+1) expandImage(i+1, j+2);
                          expandImage(i+2, j-2) expandImage(i+2, j-1) expandImage(i+2, j) expandImage(i+2, j+1) expandImage(i+2, j+2);
                         ];
        partial_mean = mean(mean(partial_matrix));
        partial_std = std2(partial_matrix);
        if partial_mean <= (img_mean * 0.5) && partial_std >= (img_std * 0.3) && partial_std <= (img_std * 0.7)
            newImg(i, j) = 2 * img(i, j);
        else
            newImg(i, j) = img(i, j);
        end
    end
end








