%������������������ϵͳ���ȶ�ԣ������
%author��ZYK 2019.11.07
%��Դ���ݵĵڶ�����������ϵͳ�Ĵ��ݺ���ģ�ͣ���ȡ��Ӧ�����㴦��ԣ�ȴ�С�����ļ��Ǳ��Ϊ 1.1
function [GmPmWc_x]=Stable_margin(K_Trace)
%��ڲ���: ��Ҫ����������ļ�����
%ʵ�ֹ��ܣ�
%���ز����� ��
%��ע��
%% �������������弰��ʼ�� 
%��ȡѡ�����������ϵ����ݣ��������Ϊ.mat�����ļ� (ʹ������ͨ�����ԭ�����������)
global Channelx;
global Fpt; %��ѡȡ��������
global Num_Act;  %��ǰ�ļ��а�����ʵ�����������
global Num; %������ĸ���
global ctrl_flag;
global bias_case_flag;
global bias_mag_flag;

%���ڿ���������������ĳ��������ѡ����������ƺõģ�����ֱ��д.
Kin_p = -1500*[5, 4.95, 4.9, 5.5, 6.2, 7]; %%Fpt =[1,5,10,25,35,45]';  %����ͨ��ѡȡǰ50s
Kin_r = -1000*[4.233, 4.1, 3.9, 3.5, 3.2, 2.9];%% Fpt =[50,64,70,80,85,90]';  %��תͨ��ѡȡ��50s
Kpout_p = [3,7,11,15,20]; %��ͬԣ�ȵĿ�����ʹ����ͬ���⻷����
Kpout_r = [3,7,13,19,25]; %��ͬԣ�ȵĿ�����ʹ����ͬ���⻷����

Path_P1 ='.\1_GmPmWc\'; %���������ݴ�ŵ��ļ���·��������
S_GPWName = 'GmPmWc'; %�����ļ���ͳһ����

Pmo=zeros(Num_Act,1);   Wco=zeros(Num_Act,1);Levels= zeros(Num_Act,1);
T_rec =zeros(Num_Act,1); 

%% ��ȡ�ļ��ڵ����ݲ�����
load(K_Trace,'LnrPara_std');

% T = LnrPara_std(:,1);  %�ò������ʱ��
% c1p = LnrPara_std(:,2); c3p = LnrPara_std(:,4);  c2p = 1;%c2p = LnrPara_std(:,3); 
% b2p = LnrPara_std(:,5); b1p = LnrPara_std(:,6); b3p = LnrPara_std(:,7); 
% c1y = LnrPara_std(:,8); c2y = LnrPara_std(:,9); c3y = LnrPara_std(:,10);
% b2y = LnrPara_std(:,11); b1y = LnrPara_std(:,12); b3y = LnrPara_std(:,13);
% c1r = LnrPara_std(:,14); c2r = LnrPara_std(:,15); c3r =0; % c3r = LnrPara_std(:,16);
% b1r = LnrPara_std(:,18); b3r = LnrPara_std(:,19); b2r =0; % b2r = LnrPara_std(:,17);
for k=1:1:Num_Act   
    FP_k = Fpt(k)+1;
    if Channelx ==1  %����ͨ��
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
    
    [Pmo(k,1),Wco(k,1),Levels(k,1)] = dyna_model(Para);%������ѡ�����㴦��ԣ�ȺͿ������� 
    T_rec(k,1) = Fpt(k);
end

%% �ļ��������

%һ���ļ��е�����������Ի��ܳ�һ���ܵľ���
label = (ctrl_flag*1000 + bias_mag_flag/5*100 + bias_case_flag)*ones(Num_Act,1); %%ʮ���Ʊ���
GmPmWc_x= [Levels, Pmo, Wco, label, T_rec];

S_Trace1 =strcat(Path_P1,S_GPWName,num2str(ctrl_flag),'_',num2str(bias_mag_flag),'_',num2str(bias_case_flag),'.mat');%����·�����ļ����õ��������ļ�·��
save(S_Trace1,'GmPmWc_x');%������Ҫ������

