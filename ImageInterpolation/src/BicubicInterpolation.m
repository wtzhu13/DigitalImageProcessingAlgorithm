%% --------------------------------
%% author:wtzhu
%% date: 20210202
%% fuction: ˫�����ڲ巨
%% --------------------------------
clc,clear,close all;
orgImage = imread('lena.bmp');
[width, height] = size(orgImage);%��ͼ����и��г�ȡԪ�أ��õ���С��ͼ��f
figure; imshow(orgImage); title('org image');%��ʾԭͼ��

m = width/2;
n = height/2;
smallImage = zeros(m, n);
for i = 1: m
    for j = 1: n
        smallImage(i, j) = orgImage(2*i, 2*j);
    end
end
figure;imshow(uint8(smallImage));title('small image');%��ʾ��С��ͼ��


magnification = 2;%���÷Ŵ���
a = smallImage(1,:);%ȡf�ĵ�1��
c = smallImage(m,:);%ȡf�ĵ�m��
%������ֵͼ�����ǰ�����չ��������,����չ�������е�f1
b = [smallImage(1,1), smallImage(1,1), smallImage(:,1)', smallImage(m,1), smallImage(m,1)];
d = [smallImage(1,n), smallImage(1,n), smallImage(:,n)', smallImage(m,n), smallImage(m,n)];
a1 = [a; a; smallImage; c; c];
b1 = [b; b; a1'; d; d];
expandImage = double(b1');

newImage = zeros(magnification*m,magnification*n);
for i = 1:magnification * m%����˫���β�ֵ��ʽ����ͼ���������ظ�ֵ
    u = rem(i, magnification)/magnification;
    i1 = floor(i/magnification) + 2;%floor()����ȡ����floor(1.3)=floor(1.7)=1
    A = [sw(1+u) sw(u) sw(1-u) sw(2-u)];
    for j = 1:magnification*n
        v = rem(j, magnification)/magnification; j1=floor(j/magnification)+2;
        C = [sw(1+v); sw(v);  sw(1-v); sw(2-v)];
        B = [expandImage(i1-1,j1-1) expandImage(i1-1,j1) expandImage(i1-1,j1+1) expandImage(i1-1,j1+2); 
             expandImage(i1,j1-1) expandImage(i1,j1) expandImage(i1,j1+1) expandImage(i1,j1+2);
             expandImage(i1+1,j1-1) expandImage(i1+1,j1) expandImage(i1+1,j1+1) expandImage(i1+1,j1+2);
             expandImage(i1+2,j1-1) expandImage(i1+2,j1) expandImage(i1+2,j1+1) expandImage(i1+2,j1+2)];
        newImage(i,j) = (A*B*C);
    end
end
%��ʾ��ֵ���ͼ��
figure,
subplot(121);imshow(uint8(smallImage));title('small image');%��ʾ��С��ͼ��
subplot(122);imshow(uint8(newImage));title('BicubicInterpolation');


