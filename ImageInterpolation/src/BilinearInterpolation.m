%% --------------------------------
%% author:wtzhu
%% date: 20210202
%% fuction: ˫���Բ�ֵ
%% f(x,y) = [f(1,0)-f(0,0)]*x+[f(0,1)-f(0,0)]*y+[f(1,1)+f(0,0)-f(1,0)-f(0,1)]*xy+f(0,0)
%% x,y���ǹ�һ����ֵ
%% --------------------------------

clc,clear,close all;
% ��ȡͼƬ
orgImage = imread('lena.bmp');
figure;imshow(orgImage);title('org image');

% ��ȡ����
[width, height] = size(orgImage);
m = width / 2;
n =  height / 2;
smallImage = zeros(m,n);
% ����������ԭͼ����Ϊԭ����1/2
for i=1:m
    for j=1:n
        smallImage(i,j) = orgImage(2*i,2*j);
    end
end
figure;imshow(uint8(smallImage));title('small image');

% ��ֵʱ��Ҫ���⴦����������Ȧ���к��У����㷨�н���������չһȦ��������Ȧ��ֵ���
headRowMat = smallImage(1,:);%ȡf�ĵ�1��
tailRowMat = smallImage(m,:);%ȡf�ĵ�m��
% ����չ������չʱ��Ҫע���ĸ�����Ҫ������չ��ȥ����Ȼ�ͳ���ʮ�ּ��ε�
headColumnMat = [smallImage(1,1), smallImage(:,1)', smallImage(m,1)];
tailColumnMat = [smallImage(1,n), smallImage(:,n)', smallImage(m,n)];
expandImage = [headRowMat; smallImage; tailRowMat];
expandImage = [headColumnMat; expandImage'; tailColumnMat];
expandImage = uint8(expandImage');
figure;imshow(expandImage);title('expand image');

% �������Ŵ�
[smallWidth, smallHeight] = size(smallImage);
% ���÷Ŵ�ϵ��
magnification = 2;
newWidth = magnification * smallWidth;
newHeight = magnification * smallHeight;
% ����һ���µľ������ڳнӱ任���ͼ��
newImage = zeros(newWidth, newHeight);

% f(x,y) = [f(1,0)-f(0,0)]*x+[f(0,1)-f(0,0)]*y+[f(1,1)+f(0,0)-f(1,0)-f(0,1)]*xy+f(0,0)
for i = 1 : newWidth
   for j = 1: newHeight
       detaX = rem(i, magnification) / magnification;
       floorX = floor(i / magnification) + 1;
       detaY = rem(j, magnification) / magnification;
       floorY = floor(j / magnification) + 1;
       newImage(i, j) = (expandImage(floorX + 1,floorY) - expandImage(floorX,floorY)) * detaX + ... 
                        (expandImage(floorX, floorY + 1) - expandImage(floorX, floorY)) * detaY + ...
                        (expandImage(floorX+1, floorY+1) + expandImage(floorX, floorY) - ...
                            expandImage(floorX+1, floorY) - expandImage(floorX, floorY+1)) * detaX * detaY + ...
                        expandImage(floorX, floorY);
   end
end
figure;
subplot(121);imshow(uint8(smallImage));title('small image');
subplot(122);imshow(uint8(newImage));title('BilinearInterpolation');

