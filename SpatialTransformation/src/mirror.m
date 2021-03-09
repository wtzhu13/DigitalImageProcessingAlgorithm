%% --------------------------------
%% author:wtzhu
%% date: 20210203
%% fuction: ����任
%% --------------------------------

clc,clear,close all;
% ��ȡͼƬ
orgImage = imread('lena.bmp');
[height, width] = size(orgImage);
figure;imshow(orgImage);title('org image');
newImage = zeros(height, width);

% ���徵����
% 1��ˮƽ����  2����ֱ����  3.ˮƽ�Ӵ��þ���
% ��ĳ�߾���ʱ���ǽ����������������С�����ֵ�Ի�����һ����ߵ�ֵ����
% MATLAB�е�ͼ������ϵheight*width��Ҫע��
% MATLAB�������Ǵ�1��ʼ���������ֵ��1�ټ�
direction = 1;
switch direction
    case 1
        display('ˮƽ')
        for i = 1: width
            for j = 1: height
                newImage(i, j) = orgImage(i, width + 1 - j);
            end
        end
    case 2
        for i = 1: width
            for j = 1: height
                newImage(i, j) = orgImage(height + 1 - i, j);
            end
        end 
    case 3
        for i = 1: width
            for j = 1: height
                newImage(i, j) = orgImage(height + 1 - i, width + 1 - j);
            end
        end  
end
figure;
subplot(121);imshow(uint8(orgImage));title('org image');
subplot(122);imshow(uint8(newImage));title('new image');
