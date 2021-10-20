%������������������ϵͳ
clear all;
close all;

%% �Ѹ�����ƫ����µ����ݺϳ�Ϊһ���ܵ����ݼ���������ѵ��
load('Data_In_Out_L2.mat');
L2 = Data_In_Out;
clearvars  Data_In_Out;

load('Data_In_Out_L4.mat');
L4 = Data_In_Out;
clearvars  Data_In_Out;

load('Data_In_Out_L6.mat');
L6 = Data_In_Out;
clearvars  Data_In_Out;

%% С�����ݼ�
TrainData_s = L2;
save('TrainData_s.mat','TrainData_s');
%����������ݵ�����˳��
rowrank = randperm(size(TrainData_s, 1)); % ������ҵ����֣���1~��������
Train_Data_sx = TrainData_s(rowrank, :);%%����rowrank���Ҿ��������
Data_sx = Train_Data_sx';
save('Data_sx.mat','Data_sx');

DataProcess(Data_sx,1);%%���ݽ�һ��Ԥ����

%% �е����ݼ�
TrainData_m = [L2;L4];
save('TrainData_m.mat','TrainData_m');
%����������ݵ�����˳��
rowrank = randperm(size(TrainData_m, 1)); % ������ҵ����֣���1~��������
Train_Data_mx = TrainData_m(rowrank, :);%%����rowrank���Ҿ��������
Data_mx = Train_Data_mx';
save('Data_mx.mat','Data_mx');

DataProcess(Data_mx,2);%%���ݽ�һ��Ԥ����

%% ������ݼ�
TrainData_b = [L2;L4;L6];
save('TrainData_b.mat','TrainData_b');
%����������ݵ�����˳��
rowrank = randperm(size(TrainData_b, 1)); % ������ҵ����֣���1~��������
Train_Data_bx = TrainData_b(rowrank, :);%%����rowrank���Ҿ��������
Data_bx = Train_Data_bx';
save('Data_bx.mat','Data_bx');

DataProcess(Data_bx,3);%%���ݽ�һ��Ԥ����

