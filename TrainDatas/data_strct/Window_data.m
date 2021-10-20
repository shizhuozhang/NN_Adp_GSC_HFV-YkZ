%神经网络在线评估控制系统的稳定裕度问题
%author：ZYK 2019.11.07
%对源数据的第二步处理，构建系统的传递函数模型，求取对应特征点处的裕度大小，该文件记标号为 1.2
function [Input_x]=Window_data(W_Trace)
%入口参数: 所要处理的数据文件名称
%实现功能：截取特征点上的窗口数据，另存为新的数据文件，然后对窗口数据做统计学计算，得到神经网络的可选输入数据，保存为数据文件
%返回参数： 无
%备注：
%% 变量声明、定义及初始化 
%提取选定的特征点上的数据，将其另存为.mat数据文件 (使用类似通配符的原理处理多组数据)
global Channelx;
global Fpt; %所选取的特征点
global Num; %特征点的个数
global window_size;
global step;
global N;  %窗口数据的个数
global Dem_input;
global L_len;
global ctrl_flag;
global bias_case_flag;
global bias_mag_flag;
global Num_Act;  %当前文件中包含的实际特征点个数


%%%初始化所需变量
Path_P2 ='.\2_Windowdata\'; %处理后的数据存放的文件夹路径，包括
Path_P3 ='.\3_Inputdata\'; %处理后的数据存放的文件夹路径，包括
D_inputName = 'InputDt'; %保存文件的统一命名
D_windowName = 'WindowDt'; %保存文件的统一命名

R_len = 1 - L_len;   %截取的时间片段为(t - T*L_left,t + T*L_left]前开后闭的区间                              

%% 读取窗口内的数据
load(W_Trace,'CtrlData');

 T = CtrlData(:,1);  
ctrl_flag= CtrlData(1,2);   bias_mag_flag = CtrlData(1,3);    bias_case_flag= CtrlData(1,4) ;  

%%Fpt =[1,5,10,25,35,45]';  %俯仰通道选取前50s
for i=1:1:Num    
    if T(end,1)>(Fpt(i)+2)
        Num_Act = i;
    else
        Num_Act = i-1;
        break;
    end
end

Windata = zeros(N,5,Num_Act);   %分开独立的窗口数据，**行23列7页的一个数据矩阵，前两维代表xx组数据，每组数据有23个元素，最后一维代表特征点个数
% FP_Windata_I = zeros(Num_Act,N*5);  %按特征点顺序排列的集成的窗口数据，该数据矩阵用于保存选出的窗口数据

for K_count = 1:1:Num_Act;
    t_bgn = Fpt(K_count) - window_size * L_len + step; %时间窗口的起始时间 区间采取前开后闭
    t_end = Fpt(K_count) + window_size * R_len; %时间窗口的终止时间
    T_samp = (t_bgn : step : t_end)';
    ID_T = floor(T_samp/0.005); %原数据控制频率是0.005

    if Channelx==1
    	Windata(:,1,K_count) = CtrlData(ID_T, 8); % Cmd_alp = CtrlData(:,8);
        Windata(:,2,K_count) = CtrlData(ID_T, 14); % Ero_alp = CtrlData(:,14);
        Windata(:,3,K_count) = CtrlData(ID_T, 17); % Ero_qw = CtrlData(:,17);
        Windata(:,4,K_count) = CtrlData(ID_T, 23); % Dlt_alp = CtrlData(:,23);
        Windata(:,5,K_count) = CtrlData(ID_T, 11); % Dlt_e = CtrlData(:,11);
    else 
        Windata(:,1,K_count) = CtrlData(ID_T, 10); % Cmd_mu = CtrlData(:,10);
        Windata(:,2,K_count) = CtrlData(ID_T, 16); %  Ero_mu = CtrlData(:,16);
        Windata(:,3,K_count) = CtrlData(ID_T, 19); % Ero_pw = CtrlData(:,19); 
        Windata(:,4,K_count) = CtrlData(ID_T, 25); %  Dlt_mu = CtrlData(:,25);
        Windata(:,5,K_count) = CtrlData(ID_T, 11); % Dlt_e = CtrlData(:,11);
    end
    
end
X_Trace =strcat(Path_P2,D_windowName,num2str(ctrl_flag),'_',num2str(bias_mag_flag),'_',num2str(bias_case_flag),'.mat');%连接路径和文件名得到完整的文件路径
save(X_Trace,'Windata');%保存需要的数据  

%% 处理窗口数据，返回处理结果，得到神经网络的输入数据
Input_Data = zeros(Num_Act,Dem_input); %从每个特征点的窗口数据中做统计学处理得出的单个控制通道的x个特征数据
T_rec =zeros(Num_Act,1);

for k=1:1:Num_Act
    Input_Data(k,:) = Get_Indexes( Windata(:,:,k) ); %处理数据
    T_rec(k,1) = Fpt(k); 
end
label = (ctrl_flag*1000 + bias_mag_flag/5*100 + bias_case_flag)*ones(Num_Act,1); %%十进制编码

Input_x= [Input_Data, label, T_rec];%正常情况应该

X_Trace1=strcat(Path_P3,D_inputName,num2str(ctrl_flag),'_',num2str(bias_mag_flag),'_',num2str(bias_case_flag),'.mat');%连接路径和文件名得到完整的文件路径
save(X_Trace1,'Input_x');%保存需要的数据
