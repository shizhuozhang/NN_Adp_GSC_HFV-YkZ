%神经网络在线评估控制系统的稳定裕度问题
%author：ZYK 2019.11.07
%对源数据的第二步处理，构建系统的传递函数模型，求取对应特征点处的裕度大小，该文件记标号为 1.1
function [GmPmWc_x]=Stable_margin(K_Trace)
%入口参数: 所要处理的数据文件名称
%实现功能：
%返回参数： 无
%备注：
%% 变量声明、定义及初始化 
%提取选定的特征点上的数据，将其另存为.mat数据文件 (使用类似通配符的原理处理多组数据)
global Channelx;
global Fpt; %所选取的特征点
global Num_Act;  %当前文件中包含的实际特征点个数
global Num; %特征点的个数
global ctrl_flag;
global bias_case_flag;
global bias_mag_flag;

%由于控制器参数是另外的程序针对所选的特征点设计好的，这里直接写.
Kin_p = -1500*[5, 4.95, 4.9, 5.5, 6.2, 7]; %%Fpt =[1,5,10,25,35,45]';  %俯仰通道选取前50s
Kin_r = -1000*[4.233, 4.1, 3.9, 3.5, 3.2, 2.9];%% Fpt =[50,64,70,80,85,90]';  %滚转通道选取后50s
Kpout_p = [3,7,11,15,20]; %不同裕度的控制器使用相同的外环参数
Kpout_r = [3,7,13,19,25]; %不同裕度的控制器使用相同的外环参数

Path_P1 ='.\1_GmPmWc\'; %处理后的数据存放的文件夹路径，包括
S_GPWName = 'GmPmWc'; %保存文件的统一命名

Pmo=zeros(Num_Act,1);   Wco=zeros(Num_Act,1);Levels= zeros(Num_Act,1);
T_rec =zeros(Num_Act,1); 

%% 读取文件内的数据并处理
load(K_Trace,'LnrPara_std');

% T = LnrPara_std(:,1);  %用不到这个时间
% c1p = LnrPara_std(:,2); c3p = LnrPara_std(:,4);  c2p = 1;%c2p = LnrPara_std(:,3); 
% b2p = LnrPara_std(:,5); b1p = LnrPara_std(:,6); b3p = LnrPara_std(:,7); 
% c1y = LnrPara_std(:,8); c2y = LnrPara_std(:,9); c3y = LnrPara_std(:,10);
% b2y = LnrPara_std(:,11); b1y = LnrPara_std(:,12); b3y = LnrPara_std(:,13);
% c1r = LnrPara_std(:,14); c2r = LnrPara_std(:,15); c3r =0; % c3r = LnrPara_std(:,16);
% b1r = LnrPara_std(:,18); b3r = LnrPara_std(:,19); b2r =0; % b2r = LnrPara_std(:,17);
for k=1:1:Num_Act   
    FP_k = Fpt(k)+1;
    if Channelx ==1  %俯仰通道
        c1 = LnrPara_std(FP_k,2);    c2 = 1;    c3 = LnrPara_std(FP_k,4);
        b1 = LnrPara_std(FP_k,6);    b2 = LnrPara_std(FP_k,5);   b3 = LnrPara_std(FP_k,7); 
        Kout = Kpout_p(ctrl_flag);  
        Kin = Kin_p(k); 
    else
        c1 = LnrPara_std(FP_k,14);   c2 = LnrPara_std(FP_k,15);  c3 = 0;
        b1 = LnrPara_std(FP_k,18);   b2 = 0;    b3 = LnrPara_std(FP_k,19);       
        Kout = Kpout_r(ctrl_flag); 
        Kin = Kin_r(k); 
    end    
    Para = [c1,c2,c3,b1,b2,b3,Kin,Kout];
    
    [Pmo(k,1),Wco(k,1),Levels(k,1)] = dyna_model(Para);%计算所选特征点处的裕度和开环带宽 
    T_rec(k,1) = Fpt(k);
end

%% 文件里的数据

%一个文件中的特征点的属性汇总成一个总的矩阵
label = (ctrl_flag*1000 + bias_mag_flag/5*100 + bias_case_flag)*ones(Num_Act,1); %%十进制编码
GmPmWc_x= [Levels, Pmo, Wco, label, T_rec];

S_Trace1 =strcat(Path_P1,S_GPWName,num2str(ctrl_flag),'_',num2str(bias_mag_flag),'_',num2str(bias_case_flag),'.mat');%连接路径和文件名得到完整的文件路径
save(S_Trace1,'GmPmWc_x');%保存需要的数据

