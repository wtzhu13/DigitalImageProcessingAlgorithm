%% --------------------------------
%% author:wtzhu
%% date: 20210208
%% fuction: 旋转
%% --------------------------------

clear;
clc;
close all;
img = imread('../images/smallLuffy.bmp');
imshow(img);
title('original image');

%% 输入参数旋转角度，是否裁切
degree = 30;
theta = degree / 180 * pi;
% 裁切标志
cropFlag = 0;

[height, width] = size(img);

%% 旋转变换后新坐标旧坐标的关系
%% newWidth = oldWidth * |cos(theta)| + oldHeight * |sin(theta)|
%% newHeight = oldWidth * |sin(theta)| + oldHeight * |cos(theta)|
%% 实际计算的时候会出现小数，所以需要向上取整，保证不丢失
if cropFlag == 1
    newWidth = ceil(width * abs(cos(theta)) + height * abs(sin(theta)));
    newHeight = ceil(height * abs(cos(theta)) + width * abs(sin(theta))); 
else
    newWidth = width;
    newHeight = height;
end

new_img_forward = zeros(newHeight, newWidth);
new_img_back = zeros(newHeight, newWidth);


%% 旋转变换后新坐标旧坐标的关系
%% newX = oldX * cos(theta) - oldY * sin(theta)
%% newY = oldY * sin(theta) + oldY * cos(theta)

%% 前向映射
%% 把当前图片的像素点对应新的图像的对应的位置
%% 这种问题在于，旋转后的图像一般大小会发生变化，那么必定新图像中会有位置在原始图像中没有对应的点，造成“空穴”
m1 = [-1 0 0; 0 1 0; 0.5*height -0.5*width 1];
m2 = [cosd(degree) -sind(degree) 0; sind(degree) cosd(degree) 0; 0 0 1];
m3 = [-1 0 0; 0 1 0; 0.5*newHeight 0.5*newWidth 1];

for i = 1:height
       for j = 1:width
          new_coordinate = [i j 1] *m1 *m2 *m3;
          row = round(new_coordinate(1));
          col = round(new_coordinate(2));
          if cropFlag == 1
              if row >= 1 && row <= newHeight && col >= 1 && col <= newWidth
                  new_img_forward(row, col) = img(i, j);
              end
          else
              if row >= 1 && row <= height && col >= 1 && col <= width
                  new_img_forward(row, col) = img(i, j);
              end
          end
       end
end
figure, imshow(new_img_forward/255), title('forward mapping');


%% 反向映射
%% 把心图像的像素点对应到原始图像中，对于不在像素上的点，通过插值补充
%% 通过邻域插值计算空穴
newWidth = ceil(width * abs(cos(theta)) + height * abs(sin(theta)));
newHeight = ceil(height * abs(cos(theta)) + width * abs(sin(theta)));
rm1 = [-1 0 0; 0 1 0; 0.5*newHeight -0.5*newWidth 1];
rm2 = [cosd(degree) sind(degree) 0; -sind(degree) cosd(degree) 0; 0 0 1];
rm3 = [-1 0 0; 0 1 0; 0.5*height 0.5*width 1];

for i = 1:newHeight
   for j = 1:newWidth
      new_coordinate = [i j 1]*rm1*rm2*rm3;
      row = round(new_coordinate(1));
      col = round(new_coordinate(2));
      if (row >= 1) && (row <= height) && (col >= 1) && (col <= width)
          new_img_back(i, j) = img(row, col);
      end  
   end
end
figure, 
subplot(121);imshow(img), title('back mapping');
subplot(122);imshow(new_img_back/255), title('back mapping');







