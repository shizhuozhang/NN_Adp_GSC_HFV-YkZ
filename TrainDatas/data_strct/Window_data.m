%������������������ϵͳ���ȶ�ԣ������
%author��ZYK 2019.11.07
%��Դ���ݵĵڶ�����������ϵͳ�Ĵ��ݺ���ģ�ͣ���ȡ��Ӧ�����㴦��ԣ�ȴ�С�����ļ��Ǳ��Ϊ 1.2
function [Input_x]=Window_data(W_Trace)
%��ڲ���: ��Ҫ����������ļ�����
%ʵ�ֹ��ܣ���ȡ�������ϵĴ������ݣ����Ϊ�µ������ļ���Ȼ��Դ���������ͳ��ѧ���㣬�õ�������Ŀ�ѡ�������ݣ�����Ϊ�����ļ�
%���ز����� ��
%��ע��
%% �������������弰��ʼ�� 
%��ȡѡ�����������ϵ����ݣ��������Ϊ.mat�����ļ� (ʹ������ͨ�����ԭ�����������)
global Channelx;
global Fpt; %��ѡȡ��������
global Num; %������ĸ���
global window_size;
global step;
global N;  %�������ݵĸ���
global Dem_input;
global L_len;
global ctrl_flag;
global bias_case_flag;
global bias_mag_flag;
global Num_Act;  %��ǰ�ļ��а�����ʵ�����������


%%%��ʼ���������
Path_P2 ='.\2_Windowdata\'; %���������ݴ�ŵ��ļ���·��������
Path_P3 ='.\3_Inputdata\'; %���������ݴ�ŵ��ļ���·��������
D_inputName = 'InputDt'; %�����ļ���ͳһ����
D_windowName = 'WindowDt'; %�����ļ���ͳһ����

R_len = 1 - L_len;   %��ȡ��ʱ��Ƭ��Ϊ(t - T*L_left,t + T*L_left]ǰ����յ�����                              

%% ��ȡ�����ڵ�����
load(W_Trace,'CtrlData');

 T = CtrlData(:,1);  
ctrl_flag= CtrlData(1,2);   bias_mag_flag = CtrlData(1,3);    bias_case_flag= CtrlData(1,4) ;  

%%Fpt =[1,5,10,25,35,45]';  %����ͨ��ѡȡǰ50s
for i=1:1:Num    
    if T(end,1)>(Fpt(i)+2)
        Num_Act = i;
    else
        Num_Act = i-1;
        break;
    end
end

Windata = zeros(N,5,Num_Act);   %�ֿ������Ĵ������ݣ�**��23��7ҳ��һ�����ݾ���ǰ��ά����xx�����ݣ�ÿ��������23��Ԫ�أ����һά�������������
% FP_Windata_I = zeros(Num_Act,N*5);  %��������˳�����еļ��ɵĴ������ݣ������ݾ������ڱ���ѡ���Ĵ�������

for K_count = 1:1:Num_Act;
    t_bgn = Fpt(K_count) - window_size * L_len + step; %ʱ�䴰�ڵ���ʼʱ�� �����ȡǰ�����
    t_end = Fpt(K_count) + window_size * R_len; %ʱ�䴰�ڵ���ֹʱ��
    T_samp = (t_bgn : step : t_end)';
    ID_T = floor(T_samp/0.005); %ԭ���ݿ���Ƶ����0.005

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
X_Trace =strcat(Path_P2,D_windowName,num2str(ctrl_flag),'_',num2str(bias_mag_flag),'_',num2str(bias_case_flag),'.mat');%����·�����ļ����õ��������ļ�·��
save(X_Trace,'Windata');%������Ҫ������  

%% ���������ݣ����ش��������õ����������������
Input_Data = zeros(Num_Act,Dem_input); %��ÿ��������Ĵ�����������ͳ��ѧ����ó��ĵ�������ͨ����x����������
T_rec =zeros(Num_Act,1);

for k=1:1:Num_Act
    Input_Data(k,:) = Get_Indexes( Windata(:,:,k) ); %��������
    T_rec(k,1) = Fpt(k); 
end
label = (ctrl_flag*1000 + bias_mag_flag/5*100 + bias_case_flag)*ones(Num_Act,1); %%ʮ���Ʊ���

Input_x= [Input_Data, label, T_rec];%�������Ӧ��

X_Trace1=strcat(Path_P3,D_inputName,num2str(ctrl_flag),'_',num2str(bias_mag_flag),'_',num2str(bias_case_flag),'.mat');%����·�����ļ����õ��������ļ�·��
save(X_Trace1,'Input_x');%������Ҫ������
