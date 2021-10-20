%神经网络在线评估控制系统的稳定裕度问题
%author：ZYK 2019.11.07
%主函数，该文件记标号为 1.0
clear all;
close all;

%% 文件
%定义全局的常量
global Channelx;
global Fpt; %所选取的特征点
global Num; %特征点的个数
global Num_Act;  %当前文件中包含的实际特征点个数
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

Channelx = 1;  %由于各通道的传函形式类似，因此统一赋值，使用标示符区分，1为俯仰通道；2为偏航通道，3为滚转通道，暂时只处理俯仰通道
if Channelx==1
    Fpt =1:0.5:50;  %俯仰通道选取前50s
%     Fpt =[1,5,10,25,35,45]';  %俯仰通道选取前50s
else 
    Fpt =[50,64,70,80,85,90]';  %滚转通道选取后50s
end
Num = length(Fpt);

window_size = 1.5; %窗口大小，通过阶跃测试，系统响应时间在1.5s左右，故暂时选定为1.5s，若效果不好可增大至2s。
step = 0.05;    %所用数据的采样步长0.05s
N = window_size/step; %窗口数据的个数
L_len = 0.6; % L_len取值分为三种情况：0.2,0.4,0.6，对应同一个特征点的裕度，这样处理大大增加了数据的样本（增加两倍）
Dem_input = 15; %神经网络输入数据的维数

ctrl_flag =1; %大小裕度控制器的标志位，0-4表示的控制器裕度递减，带宽递增 
bias_case_flag =0; %拉偏情况标志位，0-7表示8种不同的极限拉偏
bias_mag_flag=0; %拉偏最大幅值标志位，0代表无拉偏，1-6代表5%~30%的拉偏

%先读取特定格式文件的所有文件名
Path_O1 ='.\LnrData0\'; %小偏差数据存放的文件夹路径
File_O1 = dir(fullfile(Path_O1,'*.mat'));%显示文件夹下所有符合后缀名的文件的完整信息
FileNamesO1 = {File_O1.name}';%提取相应文件的文件名，转为N行1列
Length_NamesO1 = size(FileNamesO1,1); %获取所提取文件的个数

Path_O2 ='.\CtrlData0\'; %非线性仿真状态量数据存放的文件夹路径
FileO2 = dir(fullfile(Path_O2,'*.mat'));%显示文件夹下所有符合后缀名的文件的完整信息
FileNamesO2 = {FileO2.name}';%提取相应文件的文件名，转为N行1列
Length_NamesO2 = size(FileNamesO2,1); %获取所提取文件的个数

% Path_P1 ='.\1_GmPmWc\'; %处理后的数据存放的文件夹路径
% Path_P2 ='.\2_Windowdata\'; %处理后的数据存放的文件夹路径
% Path_P3 ='.\3_Inputdata\'; %处理后的数据存放的文件夹路径

GmPmWc =zeros(Length_NamesO1*Num, 3+2);%定义该拉偏情况下的总的数据保存矩阵
Inputs =zeros(Length_NamesO2*Num, (Dem_input+2));%定义该拉偏情况下的总的数据保存矩阵

%% 步骤1：处理特征点处的稳定裕度
%%对每个数据文件里所选的特征点（7个）进行相应的初步的处理
%40个文件，每个文件中有7个特征点，每个特征点属性是10维向量，因此汇合后的文件最多是280*7的矩阵
Num_line2 = 0;%记录每个数据文件返回的行数
Num_count2= 1;%记录矩阵数据的行位置
Num_line1 = 0;%记录每个数据文件返回的行数
Num_count1= 1;%记录矩阵数据的行位置

for i=1:1:Length_NamesO1 
    W_Tracex = strcat(Path_O2,FileNamesO2(i));%连接路径和文件名得到完整的文件路径 
    W_Trace = W_Tracex{1,1}; %由于K_Trace是元胞数组格式，需要加{1,1}才能得到字符串
    Buffer_O2 = Window_data(W_Trace);%传入参数是处理的数据文件的位置和名字，在函数里读取各个文件内的数据并处理

    Inputs(Num_count2:(Num_count2 + Num_Act-1),:) =Buffer_O2;%往后存数据
    Num_count2 = Num_count2 + Num_Act;%更新记录值   
    
%     K_Tracex = strcat(Path_O1,FileNamesO1(i));%连接路径和文件名得到完整的文件路径 
%     K_Trace = K_Tracex{1,1}; %由于K_Trace是元胞数组格式，需要加{1,1}才能得到字符串
%     Buffer_O1 = Stable_margin( K_Trace);%传入参数是处理的数据文件的位置和名字，在函数里读取各个文件内的数据并处理
%    
%     GmPmWc(Num_count1:(Num_count1 + Num_Act-1),:) =Buffer_O1;%往后存数据
%     Num_count1 = Num_count1 + Num_Act;%更新记录值
end

% Trace_O1 = strcat('GmPmWc_L',num2str(L_len*10),'.mat');%连接路径和文件名得到完整的文件路径
Trace_O2 = strcat('Inputs_N','.mat');%连接路径和文件名得到完整的文件路径
% Trace_O3 = strcat('Data_In_Out_L',num2str(L_len*10),'.mat');%连接路径和文件名得到完整的文件路径

if(Num_count2 < Length_NamesO2*Num) %删除没有数据的0值的行
    Inputs(Num_count2:Length_NamesO2*Num,:)=[];
end
save(Trace_O2,'Inputs'); %保存总数据
fprintf('Task2 is Done!!!\n');

% if(Num_count1 < Length_NamesO1*Num) %删除没有数据的0值的行
%     GmPmWc(Num_count1:Length_NamesO1*Num,:)=[];
% end
% save(Trace_O1,'GmPmWc'); %保存总数据
% fprintf('Task1 is Done!!!\n');

% %% 步骤3：进一步整合，得到该种拉偏等级下的最终数据库文件
% % load(Trace_O1);
% % load(Trace_O2);
% % [m1,~] = size(Inputs);
% Data_In_Out = [Inputs(:,1:15),GmPmWc];
% save(Trace_O3,'Data_In_Out'); %保存总数据
% fprintf('Task3 is Done!!!\n'); 
