%% 非线性评估测试
% clear all;
% close all;
% 
% load('NetWeight-8.mat');

% load TrainData1.mat;
% [Sc1,Qc1]= size(Outc5);
% Res = zeros(1,Qc1);
% One1 = ones(1,Qc1);
% 
% A = sim( net,Inc);  %测试网络
% 
% [~,Res]= max(A);
% 
% E2 = floor( Outc1) - Res;
% I1=find(E2(:)==0);  %识别正确的数据
% I1_1=find(E2(:)==1);  %识别差1的数据
% I1_2=find(E2(:)==-1);  %识别差1的数据
% I1_3=find( abs(E2(:))>1);  %识别错误的数据
% correct_rate1 = length(I1)/Qc1  %正确率
% correct_rate1_1 = (length(I1)+length(I1_1)+length(I1_2))/Qc1    %正确率

% function []=Assess_Test(net)

 load('Net39.mat') ;
load('Inputs_N.mat');
load('data_limit3.mat','Data_max','Data_min');
Orgdata = Inputs(:,1:15)';
[m,n] = size(Orgdata);
Newdata = zeros(m,n);
for i=1:1:n
    Newdata(:,i) = Normalize(Orgdata(:,i), Data_min, Data_max);
end

n = 99;%1:0.5:50
Ctrl1 = Newdata(:,1:n);
Ctrl2 = Newdata(:,(n+1):(2*n));
Ctrl3 = Newdata(:,(2*n+1):(3*n));
Ctrl4 = Newdata(:,(3*n+1):(4*n));
Ctrl5 = Newdata(:,(4*n+1):(5*n));

% net = newff(In,Out,Hid_num,{'tansig','tansig'});  %建立BP神经网络 ,'trainlm''purelin''logsig'
A1 = sim( net,Ctrl1);  %测试
B1 = defuzzify(A1,0);
[~,Res1]= max(A1);

A2 = sim( net,Ctrl2);  %测试
B2 = defuzzify(A2,0);
[~,Res2]= max(A2);

A3 = sim( net,Ctrl3);  %测试
B3 = defuzzify(A3,0);
[~,Res3]= max(A3);

A4 = sim( net,Ctrl4);  %测试
B4 = defuzzify(A4,0);
[~,Res4]= max(A4);

A5 = sim( net,Ctrl5);  %测试
B5 = defuzzify(A5,0);
[~,Res5]= max(A5);

T = 1:0.5:50;

figure(1)
set(gcf,'windowstyle','normal');
set(gcf,'position',[550,100,900,600]);
subplot(2,3,1)
plot(T,Res1,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl1','FontSize',13);
set(gca,'FontSize',13);

subplot(2,3,2)
plot(T,Res2,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl2','FontSize',13);
set(gca,'FontSize',13);

subplot(2,3,3)
plot(T,Res3,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl3','FontSize',13);
set(gca,'FontSize',13);

subplot(2,3,4)
plot(T,Res4,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl4','FontSize',13);
set(gca,'FontSize',13);

subplot(2,3,5)
plot(T,Res5,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl5','FontSize',13);
set(gca,'FontSize',13);

saveas(gcf,'perfmD-39')

figure(2)
set(gcf,'windowstyle','normal');
set(gcf,'position',[550,100,900,600]);
subplot(2,3,1)
plot(T,B1,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl1','FontSize',13);
set(gca,'FontSize',13);

subplot(2,3,2)
plot(T,B2,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl2','FontSize',13);
set(gca,'FontSize',13);

subplot(2,3,3)
plot(T,B3,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl3','FontSize',13);
set(gca,'FontSize',13);

subplot(2,3,4)
plot(T,B4,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl4','FontSize',13);
set(gca,'FontSize',13);

subplot(2,3,5)
plot(T,B5,'*r');
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank ','FontSize',13);
title('Ctrl5','FontSize',13);
set(gca,'FontSize',13);

saveas(gcf,'perfmS-39')
% end