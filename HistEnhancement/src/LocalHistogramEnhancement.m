%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210303
%% fuction: �ֲ���ֱ��ͼ��ǿ
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

%% �ֲ���ǿ
% ������ͼ��ľ�ֵ�ͱ�׼��
img_mean = mean(mean(img));
img_std = std2(img);

% ����һ��5*5������
% ��ͼ���������
a = img(1,:);%ȡf�ĵ�1��
c = img(m,:);%ȡf�ĵ�m��
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








