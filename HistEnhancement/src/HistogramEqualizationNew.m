%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210203
%% fuction: ֱ��ͼ���⻯
%% --------------------------------

clear;
clc;
close all;
img = imread('..\images\gray64.jpg');
[height, width] = size(img);
figure
subplot(121);imshow(img);title('original image');
subplot(122);

%% ֱ��ͼ��һ��
[counts,x] = imhist(img, 256);
counts = counts/height/width;
stem(x,counts, 'Marker', 'none');
title('org hist image');

%% ֱ��ͼ���⻯
% ����LUTӳ���
% ����ֱ��ͼ���⻯���㹫ʽ�����ӳ���
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

%% ʹ��MATLAB�Դ�������
histeqImg = histeq(img, 256);
figure();
subplot(121);imshow(histeqImg);title('hist image');
subplot(122);imhist(histeqImg);title('hist hist');

%% ֱ��ͼ���⻯֮��ͼ�����ƫ����������Ϊԭͼ����0�Ļ��ۣ�����ӳ����е�0��Ӧ�µı��в�Ϊ0
% Ϊ��������⣬��Ҫ���Ҷȼ�Ҳ����һ��
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

%% Ҳ�����Լ�����һ������ֱ��ͼ�ķ�ʽ��ʱ����
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




