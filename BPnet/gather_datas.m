%神经网络在线评估控制系统
clear all;
close all;

%% 把各种拉偏情况下的数据合成为一个总的数据集用于网络训练
load('Data_In_Out_L2.mat');
L2 = Data_In_Out;
clearvars  Data_In_Out;

load('Data_In_Out_L4.mat');
L4 = Data_In_Out;
clearvars  Data_In_Out;

load('Data_In_Out_L6.mat');
L6 = Data_In_Out;
clearvars  Data_In_Out;

%% 小的数据集
TrainData_s = L2;
save('TrainData_s.mat','TrainData_s');
%随机打乱数据的排列顺序
rowrank = randperm(size(TrainData_s, 1)); % 随机打乱的数字，从1~行数打乱
Train_Data_sx = TrainData_s(rowrank, :);%%按照rowrank打乱矩阵的行数
Data_sx = Train_Data_sx';
save('Data_sx.mat','Data_sx');

DataProcess(Data_sx,1);%%数据进一步预处理

%% 中的数据集
TrainData_m = [L2;L4];
save('TrainData_m.mat','TrainData_m');
%随机打乱数据的排列顺序
rowrank = randperm(size(TrainData_m, 1)); % 随机打乱的数字，从1~行数打乱
Train_Data_mx = TrainData_m(rowrank, :);%%按照rowrank打乱矩阵的行数
Data_mx = Train_Data_mx';
save('Data_mx.mat','Data_mx');

DataProcess(Data_mx,2);%%数据进一步预处理

%% 大的数据集
TrainData_b = [L2;L4;L6];
save('TrainData_b.mat','TrainData_b');
%随机打乱数据的排列顺序
rowrank = randperm(size(TrainData_b, 1)); % 随机打乱的数字，从1~行数打乱
Train_Data_bx = TrainData_b(rowrank, :);%%按照rowrank打乱矩阵的行数
Data_bx = Train_Data_bx';
save('Data_bx.mat','Data_bx');

DataProcess(Data_bx,3);%%数据进一步预处理

