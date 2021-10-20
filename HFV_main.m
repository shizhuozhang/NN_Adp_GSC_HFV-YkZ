%%ͨ�ø߳����ٷ���wing-cone�����ɶȷ���ƽ̨
%by ��ҫ��
%��������������£�
%6������·����״̬Flight_State_s��:λ�ã�X_loc,Y_loc,Height��;�ٶȣ�������Ǻͺ���ƫ�ǣ�Veloc��gamma,chi��
%9�����·����״̬Flight_State_f�У���ͨ��(������ƫ������ת)��ŷ����̬��(theta,psi,phi)��������̬��(alpha,beta,mu)����̬���ٶ�(q,r,p)
%11����ȷ��������:����m0������ת������Jx,Jy,Jz�������ܶ�Rho��������ϵ��CL,CY,CD����������ϵ��Cl,Cm,Cn
%6�������Ŀ���״̬������ָ��ǣ�Cmd_alp��Cmd_bet��Cmd_mu������ʵ�ʶ�ƫ��Dlt_e,Dlt_a,Dlt_r
%12������Ŀ���״̬����ͨ���Ƕȿ�����Ero_pit,Ero_yaw,Ero_rol����ͨ�����ٶȿ�����Ero_qw,Ero_rw,Ero_pw��
%             ��ͨ���Ǽ��ٶȣ�Acc_pit,Acc_yaw,Acc_rol��������Ч��ƫ��Dlt_alp,Dlt_bet,Dlt_mu
%5�����������������������ٶ�g�������ܶ�Rho��������Ma���¶�Tmprt������Vs
% g = Env_para(1);  Rho = Env_para(2);  Ma = Env_para(3);   Tmprt = Env_para(4); Vs = Env_para(5);                
%��������������Ӧ�Ŀ���������ļ��С�
%������Ӧ��ϵ���£�
% xm  =Uncertn(1); xJx =Uncertn(2); xJy =Uncertn(3); xJz =Uncertn(4); xRho = Uncertn(5); 
% xCD = Uncertn(6);  xCY = Uncertn(7);  xCL = Uncertn(8); xCl = Uncertn(9);  xCm = Uncertn(10); xCn = Uncertn(11); 

% X_loc = FltSdt_S(1);   Y_loc = FltSdt_S(2) ;   Height = FltSdt_S(3); %����λ��ʸ�� Locat = [X_loc, Y_loc, Height];
% Veloc = FltSdt_S(4);   gamma = FltSdt_S(5);   chi = FltSdt_S(6); %���ɺ���ʸ�� Trajct = [Veloc, gamma, chi];

% theta = FltSdt_F(1);   psi = FltSdt_F(2);   phi = FltSdt_F(3); %����ŷ����ʸ�� EulerAng = [theta ,psi, phi];
% alpha = FltSdt_F(4);   beta = FltSdt_F(5);   mu = FltSdt_F(6); %����������ʸ�� AeroAng = [alpha, beta, mu];
% q = FltSdt_F(7);   r = FltSdt_F(8);   p = FltSdt_F(9); %���ɽ�����ʸ�� Omega = [q ,r, p];

%Cmd_alp = CtrlSdt_B(1);  Cmd_bet = CtrlSdt_B(2);    Cmd_mu = CtrlSdt_B(3); %����ָ��ʸ�� CmdAng = [Cmd_alp ,Cmd_bet, Cmd_mu];
%Dlt_e = CtrlSdt_B(4);  Dlt_a = CtrlSdt_B(5);    Dlt_r = CtrlSdt_B(6); %����ʵ�ʶ�ƫʸ�� DeltaA = [Dlt_e ,Dlt_a, Dlt_r];
  
%Ero_pit = CtrlSdt_P(1);  Ero_yaw = CtrlSdt_P(2);    Ero_rol = CtrlSdt_P(3); %���ɿ������ʸ�� Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
%Ero_qw = CtrlSdt_P(4);  Ero_rw = CtrlSdt_P(5);    Ero_pw = CtrlSdt_P(6); %���ɽ��ٶȿ������ʸ�� Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
%Acc_pit = CtrlSdt_P(7);  Acc_yaw = CtrlSdt_P(8);    Acc_rol = CtrlSdt_P(9); %���ɽǼ��ٶ�ʸ�� Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
%Dlt_alp = CtrlSdt_P(10);  Dlt_bet = CtrlSdt_P(11);    Dlt_mu = CtrlSdt_P(12); %���ɵ�Ч��ƫʸ�� DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];
%�������ݱ����30ά������ı���˳����Ϊ��
% FltData = [FltSdt_S,FltSdt_F,CtrlSdt_B,CtrlSdt_P];
% FltData = [Locat, Trajct, EulerAng, AeroAng, Omega, CmdAng, Eror_ang, Eror_omg, Accelrt, Delta];
%'_1'��ʾ��һʱ�̵ı���ֵ��������һ������C++�ı��ϰ���е㲻һ��
clear all
close all
%% ���������������ʼ��
%�ṹ����
global m0;   %%�����������
global Jx;   %%��X��ת������ 
global Jy;   %%��X��ת������ 
global Jz;   %%��X��ת������ 
global Xcg;  %%���ĵ��ο��������ľ���
global S;    %%��չ�ο����
global b;    %%��չ
global c;    %%ƽ�������ҳ�
global Delta_lim; %%��ƫ�޷�Լ��

m0 = 63500;    %%��λ kg 
Jx = 637234;  %%��λ kg*m2  
Jy = 6101181; %%��λ kg*m2 
Jz = 6101181; %%��λ kg*m2 
Xcg = 4.4668; %%��λ m 
S = 334.73;   %%��λ m2
b = 18.288;   %%��λ m
c = 24.384;   %%��λ m
Delta_lim = 20;%%��λ deg

%�������
global h_step;   %%���沽��
global step;     %%��¼���沽��
global Time;   %%ʵ�ʷ���ʱ��
global sim_case; %%ѡ��������Σ���Ϊ�����ɶȷ���������ɶȷ���
global ctrl_case; %%ѡ��������Σ���Ϊȫ�������ƺ͵������
global ctrler_type; %%����������ѡ���־λ��1ΪУ������
global ctrler_level;  %����������1-4�ȶ��Խ���
global Ft_point; %%ѡ���������
global My_PI;    %%�Զ��徫�ȵ�PIֵ
global Rad2Deg;  %%����ת��Ϊ��
global Coef_aero;  %%����ģ�ͼ����ת��ϵ�� %��Ӧ���û��ȵ��ȵ�ת��ϵ���������������⣬��ʱ���������
global Distb_flag; %�Ƿ������ⲿ����ţ�������ţ�
global Distb_para;
global Uncertn_flag; %�Ƿ������ⲿ����ţ�������ţ�
global Uncertn_para;
global Bias_case; %ѡȡҪ�о�����ƫ���
global Bias_amp;  %��ƫ���޷�ֵ%��ƫ�����趨�����0.3

global N; %%�������ݵĸ���
global samp_step;  %%�����������ݵĲ�������
N = 30;%%�������ݵĸ���
samp_step = 0.05;  %%�����������ݵĲ�������
global Kpout; %�仯������

step=0;  %��ʼֵΪ0
Ft_point = [1,10,20,30,45,60,80,99];%%�ݶ�Ϊÿ��ʮ��ȡһ��������
My_PI = 3.14159;
Rad2Deg = 180 / My_PI; 
Coef_aero =5; %%����ģ�ͼ����ת��ϵ�� %��Ӧ���û��ȵ��ȵ�ת��ϵ���������������⣬��ʱ���������
Distb_para = zeros(1,6);    %��ʼֵ����Ϊ0
Uncertn_para = zeros(1,11); %��ʼֵ����Ϊ0

%�����������õı�־λ
sim_case = 1; %%1Ϊ�����ɶȷ��棬2Ϊ�����ɶȷ��棨���Ƶ����̣�������ȡ��׼������ 
if sim_case == 2 
    h_step = 0.1; %%��λ s
else 
    h_step = 0.005; %%��λ s ���Ʋ���Ҫ�㹻С
end

ctrl_case = 1; %%1Ϊȫ�������棬2Ϊ�������
if ctrl_case == 1 
    T_term = 50 - h_step;  %%����ʱ��  %ǰ50����Ҫ�Ǹ���ͨ��ָ��仯����50����Ҫ��ƫ��ͨ��ָ��仯
else 
    T_term = 10 - h_step;  %%����ʱ��
end
ctrler_type = 3; %%����������ѡ���־λ��1ΪУ������,2Ϊ��ͨ������ģ����,3Ϊ�������������

ctrler_level = 0 ;  %�������ȼ���1-5
Bias_amp = 13;  %��ƫ�����趨,10-30%
Bias_case = 16 ; %1-16
 
Uncertn_flag = 1;   %%0Ϊ�����벻ȷ����1Ϊ���벻ȷ��
Distb_flag = 0;     %%0Ϊ��������ţ�1Ϊ�������
% net_id = 03;

%%�����õ��ı�������
% Trace_1 =strcat('CtrlData_',num2str(ctrler_level),'_',num2str(Bias_amp),'_',num2str(Bias_case),'.mat');%����·�����ļ����õ��������ļ�·��
% Trace_2 =strcat('LnrPara_',num2str(ctrler_level),'_',num2str(Bias_amp),'_',num2str(Bias_case),'.mat');%����·�����ļ����õ��������ļ�·��
Trace_1 =strcat('CtrlData_',num2str(ctrler_level),'_',num2str(Distb_flag),'_',num2str(Uncertn_flag),'.mat');%����·�����ļ����õ��������ļ�·��
Trace_2 =strcat('LnrPara_',num2str(ctrler_level),'_',num2str(Distb_flag),'_',num2str(Uncertn_flag),'.mat');%����·�����ļ����õ��������ļ�·��
count =0;
Kpout = 3;
PA_Flag = 0;
CP_RankS = 1;
CP_RankD = 1;
GS_flag = 0;  %%������ȵı�׼λ����֤�����������ҲΪ0.5S
%% �����ʼ��
[FltSdt_S, FltSdt_F] = Parameter_Init(1); %���г�ʼ״̬��ֵ,�����жԲ�ȷ���Ժ͸��ŵĸ�ֵ

%%���ճ�ʼ�Ĳ��������ʼ��ƽ��ƫ
CmdAng = LoadCommand(0);%�����Ƶ�ָ�� ���ڵ������������������Ծ�źţ�����ȫ�����������趨��ĳ���������� 
TrimDelta = calTrimDelta(CmdAng,FltSdt_S);%���������ƽ��ƫ��С,�൱�ڿ�����ģ��
DeltaA = TrimDelta; %����ʵ�ʶ�ƫ��  %%��ƫ˳�� e,a,r ��λ deg
DeltaE = zeros(1,3); %��λdeg
%% �����Է���   
if sim_case == 1  
 %%%%%%%% ���������ɶȷ��棬��ƿ�������������̬���� %%%%       
%     FltBuf2 = zeros(1,35); %���ڼ�¼�������ݵĴ�����
%     FltData2 = zeros((T_term + h_step)/h_step,35);%���ڼ�¼�������ݵĶ�ά������
    CtrlBuf = zeros(1,28); %���ڼ�¼�������ݵĴ�����
    CtrlData = zeros((T_term + h_step)/h_step,28);%���ڼ�¼�������ݵĶ�ά������
    Buf3 = zeros(1,25); %���ڼ�¼�������ݵĴ�����
    SMCDataRec2 = zeros((T_term + h_step)/h_step,25);%���ڼ�¼�������ݵĶ�ά������
    LnrParaBufs = zeros(1,19);
    LnrPara_std = zeros((T_term + h_step),19); %���Ի�ϵ������9*6�ľ���
    
    for Time = 0: h_step: T_term %%��ʼʱ�̼�Ϊ0������ʱ��100��
        step = step + 1;%��¼���沽��
        if(rem(Time,5)==0)
            disp(Time);
        end
        
%        Height = FltSdt_S(3); Veloc = FltSdt_S(4); 
        Env_para = calEnv_para(FltSdt_S(3), FltSdt_S(4));%���㵱ǰ�Ĵ�����������        
        [Force_t, Force_a, Moment] = cal_F_M( DeltaA, Env_para, FltSdt_S, FltSdt_F); %���㵱ǰʱ���������      
      
            %%����Сƫ��ϵ������ 
%          if(rem(Time,1)==0)
%               count = count+1;
% %               disp(Time);
%               LnrParaBufs = cal_LinearPara_S(DeltaA, Env_para, FltSdt_S, FltSdt_F);  
%               LnrPara_std(count,:) =[Time, LnrParaBufs]; 
%          end    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ��ֵ���������һʱ�̵ķ���״̬  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%�����ɶ��˶�ѧ΢�ַ�����
       %����ʸ��Trajct = [Veloc, gamma, chi];
       Trajct = [FltSdt_S(4), FltSdt_S(5), FltSdt_S(6)];   %��ǰ��������
       %λ��ʸ��Locat = [X_loc, Y_loc, Height];  %%���Բ����λ�÷���
       Locat = [FltSdt_S(1), FltSdt_S(2), FltSdt_S(3)];
       Trajct_1 = RK_Trajct(Trajct, Force_t, h_step); %��ֵ���������һʱ�̵ĺ�������     
       Locat_1 = RK_Locat(Locat, FltSdt_S,h_step);%����������λ��΢�ַ��� 
%        if ctrl_case==1  %%ֻ��ȫ��������ʱ�Ÿ���λ�ú��ٶȡ�����        
%             Trajct_1 = RK_Trajct(Trajct, Force_t, h_step); %��ֵ���������һʱ�̵ĺ�������     
%             Locat_1 = RK_Locat(Locat, FltSdt_S,h_step);%����������λ��΢�ַ��� 
%         else
%             Trajct_1 = Trajct; %%ֱ�Ӹ�ֵ��������
%             Locat_1 = Locat;
%         end 

        %%��̬�˶�������
        %���ٶ�ʸ�� Omega = [q ,r, p];
        Omega = [FltSdt_F(7), FltSdt_F(8), FltSdt_F(9)];   %��ǰ���ٶȲ���
        Omega_1 = RK_Omega(Omega, Moment, h_step); %��ֵ���������һʱ�̵Ľ��ٶ�        
        Accelrt = (Omega_1 - Omega)/h_step; %���Ǽ��ٶ�
        
        %������ʸ�� AeroAng = [alpha, beta, mu];
        AeroAng = [FltSdt_F(4), FltSdt_F(5), FltSdt_F(6)];   %��ǰ�����ǲ���
        AeroAng_1 = RK_AeroAng(AeroAng, Omega, Force_a, FltSdt_S(4), h_step); %��ֵ���������һʱ�̵�������  
        
        % ŷ����ʸ�� EulerAng = [theta ,psi, phi];
%         EulerAng = [FltSdt_F(1), FltSdt_F(2), FltSdt_F(3)];   %��ǰŷ���ǲ���
%         EulerAng_1 = RK_EulrAng(EulerAng, Omega, h_step); %��ֵ���������һʱ�̵�ŷ����      
        %%���ü��ι�ϵ�������ŷ���� (�������ŷ���ǵķ�����ѡ��һ)
         EulerAng_1 = GometrRelat(1, AeroAng_1 ,Trajct_1);%�����һʱ�̵�ŷ����
         
        FltSdt_S(1) = Locat_1(1);   FltSdt_S(2) = Locat_1(2);  FltSdt_S(3) = Locat_1(3);   %������һʱ�̵�λ�ò���  
        FltSdt_S(4) = Trajct_1(1);  FltSdt_S(5) = Trajct_1(2); FltSdt_S(6) = Trajct_1(3);   %������һʱ�̵ĺ�������    
        FltSdt_F(1) = EulerAng_1(1); FltSdt_F(2) = EulerAng_1(2); FltSdt_F(3) = EulerAng_1(3); %%������һʱ�̵�ŷ���ǲ���  
        FltSdt_F(4) = AeroAng_1(1);  FltSdt_F(5) = AeroAng_1(2);  FltSdt_F(6) = AeroAng_1(3);  %%������һʱ�̵������ǲ��� 
        FltSdt_F(7) = Omega_1(1);    FltSdt_F(8) = Omega_1(2);    FltSdt_F(9) = Omega_1(3); %%������һʱ�̵Ľ����ʲ���                                    
        
        CmdAng_1 = LoadCommand(Time + h_step);  %��һʱ�̵��Ƶ�ָ��
        CtrlSdt_B(1) = CmdAng_1(1); CtrlSdt_B(2) = CmdAng_1(2); CtrlSdt_B(3) = CmdAng_1(3);
       
        %������������������,������һ���Ķ�ƫ
        if ctrler_type==1
            [Eror_ang_1, Eror_omg_1, DeltaE_1] = Ctrller_CNC(CmdAng_1, AeroAng_1, Omega_1); %%ʹ��У�����������
            [DeltaA_1] = Servor_sys(DeltaE_1,DeltaA); %%������Ŀ���ָ����䵽ʵ�ʶ�  %�������ŷ�ϵͳ
        elseif ctrler_type==2
            AfnPara = AfnNonlnrPara(DeltaA, Env_para, FltSdt_S, FltSdt_F); 
            [Eror_ang_1, DeltaA_1,SMCData2] = Ctrller_SMC_Sg(AfnPara, CmdAng_1, AeroAng_1, Omega_1); %%ʹ��sliding mode ��ģ������
            Eror_omg_1 =[0,0,0];
            Buf3 = [(Time + h_step),SMCData2];      SMCDataRec2(step,:)= Buf3;%���ڼ�¼�������ݵĶ�ά������   
        elseif ctrler_type==3
            [Eror_ang_1, Eror_omg_1, DeltaE_1] = Ctrller_AGSC(CmdAng_1, AeroAng_1, Omega_1,CP_RankS,GS_flag); %%ʹ��У�����������
            [DeltaA_1] = Servor_sys(DeltaE_1,DeltaA); %%������Ŀ���ָ����䵽ʵ�ʶ�  %�������ŷ�ϵͳ
        else
           Eror_ang_1 = [0,0,0];   Eror_omg_1 = [0,0,0];   Accelrt_1 = [0,0,0];  DeltaE_1 = [0,0,0];            
        end
        
        %�������ʸ�� Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
        CtrlSdt_P(1) = Eror_ang_1(1);  CtrlSdt_P(2) = Eror_ang_1(2);  CtrlSdt_P(3) = Eror_ang_1(3);
        %���ɽ��ٶȿ������ʸ�� Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
        CtrlSdt_P(4) = Eror_omg_1(1);  CtrlSdt_P(5) = Eror_omg_1(2);  CtrlSdt_P(6) = Eror_omg_1(3);
        %���ɽǼ��ٶ�ʸ�� Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];
        CtrlSdt_P(7) = Accelrt(1);   CtrlSdt_P(8) = Accelrt(2);   CtrlSdt_P(9) = Accelrt(3);
        %���ɵ�Ч��ƫʸ�� DeltaE = [Dlt_alp ,Dlt_bet, Dlt_mu];
          CtrlSdt_P(10)= DeltaE_1(1);   CtrlSdt_P(11)= DeltaE_1(2);     CtrlSdt_P(12)= DeltaE_1(3);
%        CtrlSdt_P(10)= 0;   CtrlSdt_P(11)= 0;     CtrlSdt_P(12)= 0;
        CtrlSdt_B(4) = DeltaA_1(1); CtrlSdt_B(5) = DeltaA_1(2);  CtrlSdt_B(6) = DeltaA_1(3); 
       
        DeltaA = DeltaA_1; %%��¼��һ�εĵ�ǰ��ƫֵ�����μ��������������һ�������ļ���
        
        if ctrler_type==3
             if(rem(Time,0.05)==0) %%ϵͳ�ڻ���Ӧʱ����0.5s���ң������������趨Ϊ0.5s
                [Wndw_Data, PA_Flag] = Window_Slid(CtrlSdt_B, CtrlSdt_P);%%����������������ʱֻ������ͨ��
            end  
            if(PA_Flag==1) %%ϵͳ�ڻ���Ӧʱ����0.5s���ң������������趨Ϊ0.5s
                [CP_RankS,CP_RankD ] = Perfm_Assess(Wndw_Data);%%����������������ʱֻ������ͨ��
                GS_flag = 1;  %%������ȵı�׼λ����֤�����������ҲΪ0.5S
                PA_Flag = 0; %%�����굱ǰ���ܣ�����־λ����
            else
                GS_flag = 0;  %%������ȵı�׼λ����֤�����������ҲΪ0.5S
                PA_Flag = 0; %%�����굱ǰ���ܣ�����־λ����                
            end          
        end
         %%%��¼������
%          FltBuf2 = [(Time + h_step), Env_para(3), FltSdt_S, FltSdt_F, CtrlSdt_B, CtrlSdt_P];%%ȫ����״̬��1+1+6+9+6+12=35
%          FltData2(step,:) = FltBuf2;
         CtrlBuf = [(Time + h_step), ctrler_level, Bias_amp, Bias_case, Omega_1, CtrlSdt_B, CtrlSdt_P,CP_RankS,CP_RankD,Kpout];%%ȫ����״̬��1+1+1+1+3+6+12=25
         CtrlData(step,:) = CtrlBuf;        
         
        if ( abs(CtrlSdt_P(1)*Rad2Deg) > 10)||( abs(CtrlSdt_P(2)*Rad2Deg) > 10)||( abs(CtrlSdt_P(3)*Rad2Deg) > 10)
            disp('ERROR!!!');%%��������Ϊ�Ƿ�ɢ��
            T_rec = Time;  %��¼��ǰʱ��
            break
        else
            T_rec = T_term;  %��¼��ǰʱ��
        end 
        
    end
     %���鴦����ɾ��Ϊ�����
    if( T_rec < T_term - h_step)
        CtrlData(((T_rec)/h_step) :end,:) = [];
        LnrPara_std((floor(T_rec + h_step)) :end,:) = [];
    end
    save(Trace_1,'CtrlData'); %����������
%     save(Trace_2,'LnrPara_std'); %����������
%      save('FltData2_6DOF.mat','FltData2');  
%      save('SMCData2.mat','SMCDataRec2');

    %%% ���������ɶȷ��棬û�п���������ƣ�Ŀ����Ϊ����ȡ��Ƶ������� %%%%
else
        FltBuf1 =zeros(1,22); %���ڼ�¼�������ݵĴ�����
    FltData1 = zeros((T_term + h_step)/h_step,22);%���ڼ�¼�������ݵĶ�ά������  
    LnrPara_std = zeros((T_term + h_step)/h_step/5,55); %���Ի�ϵ������9*6�ľ���
    AfnPara_std = zeros((T_term + h_step)/h_step/10,3,16); %���Ի�ϵ������15*3�ľ���
    T4store = zeros(3,1);%ʱ������
%   LnrPara_std = zeros((T_term + h_step)/h_step/5,19); %���Ի�ϵ������3*6�ľ���
    for Time = 0 : h_step: T_term  %%��ʼʱ�̼�Ϊ0������ʱ��100��
        step = step + 1;%��¼���沽��  
        if(rem(Time,1)==0)
            disp(Time);
        end
%        Height = FltSdt_S(3); Veloc = FltSdt_S(4); 
        Env_para = calEnv_para(FltSdt_S(3), FltSdt_S(4));%���㵱ǰ�Ĵ�����������        
        [Force_t, Force_a, Moment] = cal_F_M( DeltaA, Env_para, FltSdt_S, FltSdt_F); %���㵱ǰʱ���������
       
%         if(rem(Time,0.5)==0)
%             count = count+1;
%             disp(Time);
%             LnrParaBufb = cal_LinearPara(DeltaA, Env_para, FltSdt_S, FltSdt_F);  %%��ƹ켣�µ�Сƫ��ϵ������
%             LnrPara_std(count,:) =[Time, LnrParaBufb]; 
%         end    
        
%         if(rem(Time,1)==0)
%             count = count+1;
%             disp(Time);
%             AfnParaBuf = AfnNonlnrPara(DeltaA, Env_para, FltSdt_S, FltSdt_F);  %%��ƹ켣�µ�Сƫ��ϵ������
%             T4store = [Time;0;0];
%             AfnPara_std(count,:,:) =[T4store, AfnParaBuf]; 
%         end   
        
       %%��ֵ������������ɶ���̬����ѧ΢�ַ����飬�õ���һʱ�̵ķ���״̬
        %����ʸ��Trajct = [Veloc, gamma, chi];
        Trajct = [FltSdt_S(4), FltSdt_S(5), FltSdt_S(6)];   %��ǰ��������
        Trajct_1 = RK_Trajct(Trajct, Force_t, h_step); %��ֵ���������һʱ�̵ĺ�������     
        %λ��ʸ��Locat = [X_loc, Y_loc, Height];
        Locat = [FltSdt_S(1), FltSdt_S(2), FltSdt_S(3)];
        Locat_1 = RK_Locat(Locat, FltSdt_S,h_step);%����������λ��΢�ַ���
        
        FltSdt_S(4) = Trajct_1(1);  FltSdt_S(5) = Trajct_1(2); FltSdt_S(6) = Trajct_1(3);   %������һʱ�̵ĺ�������         
        FltSdt_S(1) = Locat_1(1);   FltSdt_S(2) = Locat_1(2);  FltSdt_S(3) = Locat_1(3);   %������һʱ�̵�λ�ò���
  
        CmdAng_1 = LoadCommand(Time + h_step);%��һʱ�̵��Ƶ�ָ��
        TrimDelta_1 = calTrimDelta(CmdAng_1, FltSdt_S);%��ⲽ��ƽ��ƫ��С,�൱�ڿ�����ģ�飬
        DeltaA_1= TrimDelta_1; %�õ���һʱ�̵�ʵ�ʶ�ƫ�� 
        CtrlSdt_B(1) = CmdAng_1(1); CtrlSdt_B(2) = CmdAng_1(2); CtrlSdt_B(3) = CmdAng_1(3); 
        CtrlSdt_B(4) = DeltaA_1(1); CtrlSdt_B(5) = DeltaA_1(2);  CtrlSdt_B(6) = DeltaA_1(3);   
        
        %%���ü��ι�ϵ������������״̬���� 
        AeroAng_1 = CmdAng_1;  %ָ��Ǽ���Ϊ�������� 
        EulerAng_1 = GometrRelat(1, AeroAng_1 ,Trajct_1);%�����һʱ�̵�ŷ����
        FltSdt_F(4) = AeroAng_1(1);   FltSdt_F(5) = AeroAng_1(2);   FltSdt_F(6) = AeroAng_1(3);  %%������һʱ�̵������ǲ���      
        FltSdt_F(1) = EulerAng_1(1);   FltSdt_F(2) = EulerAng_1(2);   FltSdt_F(3) = EulerAng_1(3); %%������һʱ�̵�ŷ���ǲ���         
        %���������ɶȷ������˲̬ƽ����裬������ת������˽����ʲ�����,��Ϊ0
        %FltSdt_F(7) = Omega(1);   FltSdt_F(8) = Omega(2);   FltSdt_F(9) = Omega(3); %%������һʱ�̵Ľ����ʲ���
  
         %%%��¼������
         FltBuf1 = [(Time + h_step),FltSdt_S,FltSdt_F,CtrlSdt_B];
         FltData1(step,:) = FltBuf1;
    end
    % save('Fltdata3dof.mat','FltData1');
end

%% ���ݷ��������߻���
% DataAnalys1();%���ݷ���
% my_plot1();%���߻���
% my_plot2();%���߻���
% my_plot3();%���߻���
% my_plot4();%���߻���










  