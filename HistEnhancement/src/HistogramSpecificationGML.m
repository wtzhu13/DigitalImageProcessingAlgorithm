%% --------------------------------
%% author:wtzhu
%% email:wtzhu_13@163.com
%% date: 20210303
%% fuction: ֱ���涨��GML
%% --------------------------------
clc ,clear all
A = [0.19 0.25 0.21 0.16 0.08 0.06 0.03 0.02];  %ԭֱ��ͼ����
C = [0    0    0    0.2  0    0.6  0    0.2];  %�涨ֱ��ͼ����
F=zeros(1,size(A,2));  %�涨����ֱ��ͼ����
for i = 1:size(A,2)    %BΪA���ۼ�ֱ��ͼ����
    if i == 1    
        B(i) = A (i);    
    else    
        B(i) = B(i-1) + A(i);    
    end
end
for i = 1:size(C,2)
    if i == 1    
        D(i) = C (i);    
    else     
        D(i) = D(i-1) + C(i);    
    end
end
min=1;
flag2 = 1;
for i = 1:size(D,2)
    if C(i)~=0    
        for j = flag2:size(B,2)      
              t=abs(D(i)-B(j));            
              if(t<min)            
                  min=t;   %minΪ�����С����ֵ                
                  flag=j;  %flagΪ�������С����ֵ�±�            
               end        
         end        
     for k = flag2:flag        
         E(k) = i;  %EΪGMLӳ��������        
     end        
     flag2 = flag+1;        
     min=1;    
     end
end
for i = 1:size(E,2)
    F(E(i))=F(E(i))+A(i);
end 
j=1:size(A,2);
subplot(1,2,1),stem(j-1,A(j),'fill','black'),title('ԭʼֱ��ͼ'),xlabel('r_{k}'),ylabel('p_{r}(r_{k})');
subplot(1,2,2),stem(j-1,F(j),'fill','black'),title('GMLӳ�����'),xlabel('s_{k}'),ylabel('p_{s}(s_{k})'); 