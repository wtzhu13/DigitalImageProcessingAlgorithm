%% --------------------------------
%% author:wtzhu
%% date: 20210203
%% fuction: 镜像变换
%% --------------------------------

clc,clear,close all;
% 读取图片
orgImage = imread('lena.bmp');
[height, width] = size(orgImage);
figure;imshow(orgImage);title('org image');
newImage = zeros(height, width);

% 定义镜像方向
% 1：水平镜像  2：垂直镜像  3.水平加处置镜像
% 沿某边镜像时就是将这边上最大坐标和最小坐标的值对换，另一个左边的值不变
% MATLAB中的图像坐标系height*width需要注意
% MATLAB中坐标是从1开始，左移最大值加1再减
direction = 1;
switch direction
    case 1
        display('水平')
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
