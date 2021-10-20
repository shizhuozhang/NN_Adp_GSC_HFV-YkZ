%������������������ϵͳ���ȶ�ԣ������
%author��ZYK 2019.11.07
%�����������ļ��Ǳ��Ϊ 1.0
clear all;
close all;

%% �ļ�
%����ȫ�ֵĳ���
global Channelx;
global Fpt; %��ѡȡ��������
global Num; %������ĸ���
global Num_Act;  %��ǰ�ļ��а�����ʵ�����������
global window_size;
global N;
global step;
global Dem_input;
global L_len;
global ctrl_flag;
global bias_case_flag;
global bias_mag_flag;
global limit_alp;
global limit_mu;

limit_alp(1) = 5;   limit_alp(2) = 5;
limit_alp(3) = 0.8;   limit_alp(4) = 0.7;    limit_alp(5) = 0.3;   limit_alp(6) = 12;   limit_alp(7) = 10;
limit_alp(8) = 3;   limit_alp(9) = 0.5;    limit_alp(10) = 0.4;  limit_alp(11) = 10;
limit_alp(12) = 80;  limit_alp(13)= 500;    limit_alp(14) = 10;  limit_alp(15) = 1.5;

limit_mu(1) = 1;   limit_mu(2) = 1;
limit_mu(3) = 1;   limit_mu(4) = 1;    limit_mu(5) = 1;   limit_mu(6) = 1;   limit_mu(7) = 1;
limit_mu(8) = 1;   limit_mu(9) = 1;    limit_mu(10) = 1;  limit_mu(11) = 1;
limit_mu(12) = 1;  limit_mu(13)= 1;    limit_mu(14) = 1;  limit_mu(15) = 1;

Channelx = 1;  %���ڸ�ͨ���Ĵ�����ʽ���ƣ����ͳһ��ֵ��ʹ�ñ�ʾ�����֣�1Ϊ����ͨ����2Ϊƫ��ͨ����3Ϊ��תͨ������ʱֻ������ͨ��
if Channelx==1
    Fpt =1:0.5:50;  %����ͨ��ѡȡǰ50s
%     Fpt =[1,5,10,25,35,45]';  %����ͨ��ѡȡǰ50s
else 
    Fpt =[50,64,70,80,85,90]';  %��תͨ��ѡȡ��50s
end
Num = length(Fpt);

window_size = 1.5; %���ڴ�С��ͨ����Ծ���ԣ�ϵͳ��Ӧʱ����1.5s���ң�����ʱѡ��Ϊ1.5s����Ч�����ÿ�������2s��
step = 0.05;    %�������ݵĲ�������0.05s
N = window_size/step; %�������ݵĸ���
L_len = 0.6; % L_lenȡֵ��Ϊ���������0.2,0.4,0.6����Ӧͬһ���������ԣ�ȣ��������������������ݵ�����������������
Dem_input = 15; %�������������ݵ�ά��

ctrl_flag =1; %��Сԣ�ȿ������ı�־λ��0-4��ʾ�Ŀ�����ԣ�ȵݼ���������� 
bias_case_flag =0; %��ƫ�����־λ��0-7��ʾ8�ֲ�ͬ�ļ�����ƫ
bias_mag_flag=0; %��ƫ����ֵ��־λ��0��������ƫ��1-6����5%~30%����ƫ

%�ȶ�ȡ�ض���ʽ�ļ��������ļ���
Path_O1 ='.\LnrData0\'; %Сƫ�����ݴ�ŵ��ļ���·��
File_O1 = dir(fullfile(Path_O1,'*.mat'));%��ʾ�ļ��������з��Ϻ�׺�����ļ���������Ϣ
FileNamesO1 = {File_O1.name}';%��ȡ��Ӧ�ļ����ļ�����תΪN��1��
Length_NamesO1 = size(FileNamesO1,1); %��ȡ����ȡ�ļ��ĸ���

Path_O2 ='.\CtrlData0\'; %�����Է���״̬�����ݴ�ŵ��ļ���·��
FileO2 = dir(fullfile(Path_O2,'*.mat'));%��ʾ�ļ��������з��Ϻ�׺�����ļ���������Ϣ
FileNamesO2 = {FileO2.name}';%��ȡ��Ӧ�ļ����ļ�����תΪN��1��
Length_NamesO2 = size(FileNamesO2,1); %��ȡ����ȡ�ļ��ĸ���

% Path_P1 ='.\1_GmPmWc\'; %���������ݴ�ŵ��ļ���·��
% Path_P2 ='.\2_Windowdata\'; %���������ݴ�ŵ��ļ���·��
% Path_P3 ='.\3_Inputdata\'; %���������ݴ�ŵ��ļ���·��

GmPmWc =zeros(Length_NamesO1*Num, 3+2);%�������ƫ����µ��ܵ����ݱ������
Inputs =zeros(Length_NamesO2*Num, (Dem_input+2));%�������ƫ����µ��ܵ����ݱ������

%% ����1�����������㴦���ȶ�ԣ��
%%��ÿ�������ļ�����ѡ�������㣨7����������Ӧ�ĳ����Ĵ���
%40���ļ���ÿ���ļ�����7�������㣬ÿ��������������10ά��������˻�Ϻ���ļ������280*7�ľ���
Num_line2 = 0;%��¼ÿ�������ļ����ص�����
Num_count2= 1;%��¼�������ݵ���λ��
Num_line1 = 0;%��¼ÿ�������ļ����ص�����
Num_count1= 1;%��¼�������ݵ���λ��

for i=1:1:Length_NamesO1 
    W_Tracex = strcat(Path_O2,FileNamesO2(i));%����·�����ļ����õ��������ļ�·�� 
    W_Trace = W_Tracex{1,1}; %����K_Trace��Ԫ�������ʽ����Ҫ��{1,1}���ܵõ��ַ���
    Buffer_O2 = Window_data(W_Trace);%��������Ǵ���������ļ���λ�ú����֣��ں������ȡ�����ļ��ڵ����ݲ�����

    Inputs(Num_count2:(Num_count2 + Num_Act-1),:) =Buffer_O2;%���������
    Num_count2 = Num_count2 + Num_Act;%���¼�¼ֵ   
    
%     K_Tracex = strcat(Path_O1,FileNamesO1(i));%����·�����ļ����õ��������ļ�·�� 
%     K_Trace = K_Tracex{1,1}; %����K_Trace��Ԫ�������ʽ����Ҫ��{1,1}���ܵõ��ַ���
%     Buffer_O1 = Stable_margin( K_Trace);%��������Ǵ���������ļ���λ�ú����֣��ں������ȡ�����ļ��ڵ����ݲ�����
%    
%     GmPmWc(Num_count1:(Num_count1 + Num_Act-1),:) =Buffer_O1;%���������
%     Num_count1 = Num_count1 + Num_Act;%���¼�¼ֵ
end

% Trace_O1 = strcat('GmPmWc_L',num2str(L_len*10),'.mat');%����·�����ļ����õ��������ļ�·��
Trace_O2 = strcat('Inputs_N','.mat');%����·�����ļ����õ��������ļ�·��
% Trace_O3 = strcat('Data_In_Out_L',num2str(L_len*10),'.mat');%����·�����ļ����õ��������ļ�·��

if(Num_count2 < Length_NamesO2*Num) %ɾ��û�����ݵ�0ֵ����
    Inputs(Num_count2:Length_NamesO2*Num,:)=[];
end
save(Trace_O2,'Inputs'); %����������
fprintf('Task2 is Done!!!\n');

% if(Num_count1 < Length_NamesO1*Num) %ɾ��û�����ݵ�0ֵ����
%     GmPmWc(Num_count1:Length_NamesO1*Num,:)=[];
% end
% save(Trace_O1,'GmPmWc'); %����������
% fprintf('Task1 is Done!!!\n');

% %% ����3����һ�����ϣ��õ�������ƫ�ȼ��µ��������ݿ��ļ�
% % load(Trace_O1);
% % load(Trace_O2);
% % [m1,~] = size(Inputs);
% Data_In_Out = [Inputs(:,1:15),GmPmWc];
% save(Trace_O3,'Data_In_Out'); %����������
% fprintf('Task3 is Done!!!\n'); 
