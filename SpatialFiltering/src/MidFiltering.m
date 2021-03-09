%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210306
%% fuction: ��ֵ�˲�
%% --------------------------------
clear;
clc;
close all;
img = imread('./images/test_pattern_blurring_orig.tif');
[m, n] = size(img);
figure;subplot(221);imshow(img);title('original image');

%% �����ʱ����Ҫ�Ա�Ե������չ
% ��Ҫ���⴦����������Ȧ���к��У����㷨�н���������չһȦ��������Ȧ��ֵ���
headRowMat = img(1,:);%ȡf�ĵ�1��
tailRowMat = img(m,:);%ȡf�ĵ�m��
% ����չ������չʱ��Ҫע���ĸ�����Ҫ������չ��ȥ����Ȼ�ͳ���ʮ�ּ��ε�
headColumnMat = [img(1,1), img(:,1)', img(m,1)];
tailColumnMat = [img(1,n), img(:,n)', img(m,n)];
expandImage = [headRowMat; img; tailRowMat];
expandImage = [headColumnMat; expandImage'; tailColumnMat];
expandImage = uint8(expandImage');
subplot(222);imshow(expandImage);title('expand image');

newImg = zeros(m, n);
for i =2: m+1
    for j =2: n+1
       imgRoi = [expandImage(i-1, j-1) expandImage(i-1, j) expandImage(i-1, j+1) ...
                 expandImage(i  , j-1) expandImage(i  , j) expandImage(i  , j+1) ...
                 expandImage(i+1, j-1) expandImage(i+1, j) expandImage(i+1, j+1)];
       orderedList = sort(imgRoi);
       sizeRoi = size(imgRoi);
       newImg(i-1, j-1) = orderedList((sizeRoi(2)+1)/2);
    end
end
newImg = uint8(newImg);
subplot(223);imshow(newImg);title('new image');
subplot(224);imshow(img-newImg);title('newImg-img');

