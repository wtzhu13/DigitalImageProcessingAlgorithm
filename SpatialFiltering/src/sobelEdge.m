%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210203
%% fuction: 直方图均衡化
%% --------------------------------
clear;
clc;
close all;

s = [0 0 0 0 0 100 100 100 100 100 255 255 255 255 255;
     0 0 0 0 0 100 100 100 100 100 255 255 255 255 255;
     0 0 0 0 0 100 100 100 100 100 255 255 255 255 255;
     0 0 0 0 0 100 100 100 100 100 255 255 255 255 255;
     0 0 0 0 0 100 100 100 100 100 255 255 255 255 255;];

f = imread('gray64.jpg');
[m,n] = size(f);
img = ones(m,n)*100;
img(:,101:200) = 0;
% img(:,200:300) = 150;
figure;imshow(uint8(img));title('org');
f = img;

% f_p=zeros(m,n);
% for i=2:m-1
%     for j=2:n-1
%         f_p(i,j)=abs(f(i-1,j-1)+f(i,j-1)+f(i+1,j-1)-f(i-1,j+1)-f(i,j+1)-f(i+1,j+1))/3+abs(f(i+1,j-1)+f(i+1,j)+f(i+1,j+1)-f(i-1,j-1)-f(i-1,j)-f(i-1,j+1))/3;
%         if f_p(i,j)<20
%             f_p(i,j)=0;
%         else
%             f_p(i,j)=255;
%         end
%     end
% end
% f_p = uint8(f_p);
% figure;imshow(f_p);title('Prewitt算子');

B=zeros(size(f));
for x=2:m-1
    for y=2:n-1
%         B(x,y)=abs(f(x+1,y)+f(x-1,y)+f(x,y+1)+f(x,y-1)-4*f(x,y));
        B(x,y)=f(x+1,y)+f(x-1,y)+f(x,y+1)+f(x,y-1)-4*f(x,y);
    end
end
B1=uint8(B);
figure;imshow(B1);title('拉普拉斯算子后的图');


