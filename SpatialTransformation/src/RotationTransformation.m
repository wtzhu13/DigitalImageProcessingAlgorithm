%% --------------------------------
%% author:wtzhu
%% date: 20210208
%% fuction: ��ת
%% --------------------------------

clear;
clc;
close all;
img = imread('../images/smallLuffy.bmp');
imshow(img);
title('original image');

%% ���������ת�Ƕȣ��Ƿ����
degree = 30;
theta = degree / 180 * pi;
% ���б�־
cropFlag = 0;

[height, width] = size(img);

%% ��ת�任�������������Ĺ�ϵ
%% newWidth = oldWidth * |cos(theta)| + oldHeight * |sin(theta)|
%% newHeight = oldWidth * |sin(theta)| + oldHeight * |cos(theta)|
%% ʵ�ʼ����ʱ������С����������Ҫ����ȡ������֤����ʧ
if cropFlag == 1
    newWidth = ceil(width * abs(cos(theta)) + height * abs(sin(theta)));
    newHeight = ceil(height * abs(cos(theta)) + width * abs(sin(theta))); 
else
    newWidth = width;
    newHeight = height;
end

new_img_forward = zeros(newHeight, newWidth);
new_img_back = zeros(newHeight, newWidth);


%% ��ת�任�������������Ĺ�ϵ
%% newX = oldX * cos(theta) - oldY * sin(theta)
%% newY = oldY * sin(theta) + oldY * cos(theta)

%% ǰ��ӳ��
%% �ѵ�ǰͼƬ�����ص��Ӧ�µ�ͼ��Ķ�Ӧ��λ��
%% �����������ڣ���ת���ͼ��һ���С�ᷢ���仯����ô�ض���ͼ���л���λ����ԭʼͼ����û�ж�Ӧ�ĵ㣬��ɡ���Ѩ��
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


%% ����ӳ��
%% ����ͼ������ص��Ӧ��ԭʼͼ���У����ڲ��������ϵĵ㣬ͨ����ֵ����
%% ͨ�������ֵ�����Ѩ
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







