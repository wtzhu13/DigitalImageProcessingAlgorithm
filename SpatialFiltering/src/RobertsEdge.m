%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210316
%% fuction: Roberts ½»²æÌÝ¶ÈËã×Ó
%% --------------------------------

clear;
clc;
close all;
f = imread('./images/house.tif');
figure();
subplot(131);imshow(f);title('org');
% f = [0 0 0 255 255 255;
%      0 0 0 255 255 255;
%      0 0 0 255 255 255;
%      0 0 0 255 255 255;
%      0 0 0 255 255 255;
%      0 0 0 255 255 255;];
I = im2double(f);
[m, n] = size(f);
B=zeros(size(f));
for x=1:m-1
    for y=1:n-1
        B(x,y)=abs(I(x, y)+I(x, y+1)-I(x+1, y)-I(x+1, y+1))+abs(I(x, y)+I(x+1, y)-I(x, y+1)-I(x+1, y+1));
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
subplot(132);imshow(B);title('new img');

C=zeros(size(f));
for x=1:m-1
    for y=1:n-1
        C(x,y)=abs(I(x, y)-I(x+1, y+1))+abs(I(x, y+1)-I(x+1, y));
    end
end
C_max = max(max(C));
C_min = min(min(C));
thresh = 20/255;
for x=1:m
    for y=1:n
        if C(x, y) > ((C_max-C_min) * thresh)
            C(x,y)=255;
        else
            C(x,y)=0;
        end
    end
end
subplot(133);imshow(C);title('new img');
