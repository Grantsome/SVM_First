function [] = svm_first()
%UNTITLED 此处显示有关此函数的摘要
%   清空环境变量，读入数据
clc
clear all
X0=xlsread('G:\MATLAB\Function\svm_data.xlsx','B2:E19'); 
%   和PCA主成分分析第一步相同的处理方法
for i = 1:3
    X(:,i)=(X0(:,i)-mean(X0(:,i)))/std(X0(:,i)); %数据标准化处理
end

%   数据预处理
[m,n]=size(X);
m
n
e=ones(m,1);
D=[X0(:,4)];
B=zeros(m,m);
C=zeros(m,m);
for i=1:m
    B(i,i)=1;
    C(i,i)=D(i,1);
end
%   转化为线性规划模型
A=[-X(:,1).*D,-X(:,2).*D,-X(:,3).*D,D,-B];
b=-e;
f=[0,0,0,0,ones(1,m)];
lb=[-Inf,-Inf,-Inf,-Inf,zeros(1,m)]';
x=linprog(f,A,b,[],[],lb);
%  模型的验证和结果显示
W=[x(1,1),x(2,1),x(3,1)]; %提取系数
CC=x(4,1);
X1=[X(:,1),X(:,2),X(:,3)];
R1=X1*W'-CC;
R2=sign(R1);
disp('程序输出结果：');
disp('超平面方程：');
disp('X1');
disp(num2str(x(1,1)));
disp('X2');
disp(num2str(x(2,1)));
disp('X3');
disp(num2str(x(3,1)));
disp('intercept:');
disp(num2str(x(4,1)));
disp('超平面分类结果');
R=[R1,R2]
end

