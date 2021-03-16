%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210316
%% fuction: Prewitt ½»²æÌÝ¶ÈËã×Ó
%% --------------------------------

clear;
clc;
close all;
f = imread('./images/house.tif');
figure();
subplot(121);imshow(f);title('org');
I = im2double(f);
[m, n] = size(f);
B=zeros(size(f));
for x=2:m-2
    for y=2:n-2
        B(x,y)=abs(I(x+1, y-1)+I(x+1, y)+I(x+1, y+1)-I(x-1, y-1)-I(x-1, y)-I(x-1, y+1)) ...
              +abs(I(x-1, y+1)+I(x, y+1)+I(x+1, y+1)-I(x-1, y-1)-I(x, y-1)-I(x+1, y-1));
    end
end
B_max = max(max(B));
B_min = min(min(B));
thresh = 20/255;
for x=1:m
    for y=1:n
        if B(x, y) > ((B_max-B_min) * thresh)
            B(x,y)=255;
        else
            B(x,y)=0;
        end
    end
end
subplot(122);imshow(B);title('new img');

