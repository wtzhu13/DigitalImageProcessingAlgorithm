%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210303
%% fuction: ֱ���涨��SML
%% --------------------------------
clear;
clc;
close all;
img = imread('../images/lena.bmp');
[height, width] = size(img);
figure
subplot(231);imshow(img);title('original image');
subplot(232);

%% �涨��
[orgDistribution,x] = imhist(img, 256);
orgDistribution = orgDistribution/height/width;
stem(x,orgDistribution, 'Marker', 'none');
title('org hist image');

% ͨ�������ܶȺ�������ԭʼ�ۼƷֲ�
sizeOrg = size(orgDistribution);
orgCumulative = zeros(1, sizeOrg(1));
for i=1:sizeOrg
    if i == 1
        orgCumulative(i) = orgDistribution(i);
    else
        orgCumulative(i) = orgCumulative(i-1) + orgDistribution(i);
    end
end
    

% �涨ֱ��ͼ�ĻҶȸ��ʷֲ�
destDistribution=[zeros(1,50),0.1,zeros(1,50),0.2,zeros(1,50),0.2,zeros(1,50),0.2,zeros(1,20),0.2,zeros(1,30),0.1];
destDistribution = destDistribution.';
subplot(233);
stem(x,destDistribution, 'Marker', 'none');
title('dest hist image');

% ����ģ����ۼƷֲ�
sizeDest = size(destDistribution);
destCumulative = zeros(1, sizeDest(1));
for i=1:sizeDest
    if i == 1
        destCumulative(i) = destDistribution(i);
    else
        destCumulative(i) = destCumulative(i-1) + destDistribution(i);
    end
end

% ����SMLӳ���ϵ
SML_LUT = zeros(1, sizeOrg(1));
min = 1;
for i = 1: sizeOrg(1)
    for j = 1: sizeDest(1)
        if abs(orgCumulative(i) - destCumulative(j)) < min
            min = abs(orgCumulative(i) - destCumulative(j));
            minFlag = j;
        end
    end
    SML_LUT(i) = minFlag;
    min = 1;
end

% ����ӳ���ϵ�����µ�ͼ��
newImage = zeros(height, width);
for i = 1: height
    for j = 1: width
        newImage(i, j) = SML_LUT(1, img(i, j) + 1);
    end
end

subplot(234);imshow(uint8(newImage));title('new image');
subplot(235);imhist(uint8(newImage));title('new hist');


        
        
        
        
        
        
        

