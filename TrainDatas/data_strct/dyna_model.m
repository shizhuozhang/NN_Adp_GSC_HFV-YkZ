%������������������ϵͳ���ȶ�ԣ������
%author��ZYK 2019.11.07
%��Դ���ݵĵڶ�����������ϵͳ�Ĵ��ݺ���ģ�ͣ���ȡ��Ӧ�����㴦��ԣ�ȴ�С�����ļ��Ǳ��Ϊ 1.1.1
function [Pm_out, Wcp_out, Level]=dyna_model(Para)
%��ڲ���: ��Ҫ����������ļ�����
%ʵ�ֹ��ܣ�
%���ز����� ��
%��ע��
%% �������������弰��ʼ��
global Channelx;
Level=0;
    
c1 = Para(1);    c2 = Para(2);    c3 = Para(3);
b1 = Para(4);    b2 = Para(5);    b3 = Para(6); 
Kin = Para(7);    Kout = Para(8);    

%% ����������ģ��,�����ƿ�ͼ�и����������ģ��
if(Channelx==1)  %����ͨ��
    %%����ͨ����У������  �ͺ�����
    nump = [0.0289,1];  %[0.0577,0.6928],[0.1924,0.231]�������Ҳ������
    denp = [0.3464,1];  %
    Gp = tf(nump,denp); 
elseif(Channel==3)  %��תͨ��
    %%��תͨ����У������  �ͺ�����
    nump = [0.1763,1];%�������Ҳ������
    denp = [5.686,1];%
    Gp = tf(nump,denp);  
end

%�ǶȶԶ�Ĵ��ݺ���
num = [c3, (b3*c2 - b1*c3)];
den = [1, -(b1+c1), (c1*b1 -c2*b2)];
Gad = tf(num,den);

%���ٶȶԶ�Ĵ��ݺ���        
num = [b3, (b2*c3 - c1*b3)];
den = [1, -(b1+c1), (c1*b1 -c2*b2)];
Gwd = tf(num,den);

%�ǶȶԽ��ٶȵĴ��ݺ���
num = [c3, (b3*c2 - b1*c3)];
den= [b3, (b2*c3 - c1*b3)];
Gaw = tf(num,den);

Ga = Kin*Gp*Gwd;    % �ڻ����ٶȱ���Ŀ������ݺ���
Gin = feedback(Ga,1);  % �ڻ��ջ����ݺ���
Gb = Kout*Gin*Gaw;  %�⻷�������ݺ���
 %�ĸ������ֱ�Ϊ����ֵԣ�ȣ���λ����dB,Ҫȡ20log�������ԣ�ȣ���λ���ȣ���-180�ȴ�ԽƵ�ʺͼ��У���ֹ��Ƶ�ʣ���λrad/s��
   %ע�⿪����ֹƵ�ʺͱջ���������أ�����С������ͬ
 [Gm_out,Pm_out,Wcg_out,Wcp_out]=margin(Gb);

%% �Ը���������ȶ�ԣ�Ƚ��б궨��һ����Ϊ5����Data_calibration()

if  Wcp_out > 22   %�ȶ��� ������  ��ֹƵ��>22rad/s
    Level =5; 
elseif Wcp_out > 16 %�ȼ�4 %�ȶ��� ����  ��ֹƵ��<22rad/s��
    Level =4;
elseif Wcp_out > 10 %�ȼ�3   %�ȶ��� �е�  ��ֹƵ��<16rad/s��
    Level =3;
elseif Wcp_out > 5 %�ȼ�2   %�ȶ��� ����  ��ֹƵ��<10rad/s��
    Level =2;    
elseif Wcp_out > 0.5 %�ȼ�1  %�ȶ��� ����  ��ֹƵ��<5rad/s��
    Level =1;    
else  %�ȼ�0
    Level =0;                    
end


end



