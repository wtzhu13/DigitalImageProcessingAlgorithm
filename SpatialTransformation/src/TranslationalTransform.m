%% --------------------------------
%% author:wtzhu
%% date: 20210203
%% fuction: ƽ�Ʊ任
%% --------------------------------

clc,clear,close all;
% ��ȡͼƬ
orgImage = imread('lena.bmp');
[height, width] = size(orgImage);
figure;imshow(orgImage);title('org image');
newImage = zeros(height, width);

% ����ƽ�Ƶķ���;���
detaX = -50;
detaY = -50;
for i = 1:width
    for j = 1: height
        % ƽ��֮���ͼ��֤�ڻ�����
        if ((i + detaX >= 1) && (i + detaX <= width) && (j + detaY >= 1) && (j + detaY <= height ))
            newImage(i + detaX, j + detaY) = orgImage(i, j);
            newImage = uint8(newImage);
        end
    end
end
figure;
subplot(121);imshow(orgImage);title('org image');
subplot(122);imshow(newImage);title('new image');

