%������������������ϵͳ���ȶ�ԣ������
%author��ZYK 2019.11.07
%��Դ���ݵĵڶ�����������ϵͳ�Ĵ��ݺ���ģ�ͣ���ȡ��Ӧ�����㴦��ԣ�ȴ�С�����ļ��Ǳ��Ϊ 1.2.1
function [In_Data]=Get_Indexes(win_data)
%% ���ݸ�ֵ����ʼ��
global Channelx;
global N;
global step;
global limit_alp;
global limit_mu;

Rad2Deg = 57.296; 
% % win_data ��N*23�����ݾ���N��23ά��������ά�ĺ������£�
%����ͨ��
Cmd_ang = win_data(:,1); %ָ���  % Afa = win_data(:,6); %ʵ�ʽ�  
e_Ang = win_data(:,2); %�Ƕȸ��ٿ������
e_W = win_data(:,3); 
Dlt_eqt = win_data(:,4); %��Ч��ƫ
Dlt_act = win_data(:,5); %ʵ�ʶ�ƫ

Vec_Buf= zeros(N-1,1); 
Sum_Buf= 0;
count_p = 0;
%% ����������ͨ��������
%���ȶ�������ͳ��ѧ����Ȼ������ݽ����޷�������С�����ݶ�����ѵ����Ӱ�죬��һ�����Ҫ
if Channelx==1  %������ͨ�������޷�ֵ
   limit = limit_alp;
else  %�����תͨ�������޷�ֵ
   limit = limit_mu;
end

                %%% ���ڽǶ�ָ���ָ��������Ҳ��һ���ܹؼ����� %%%
for i =1:1:(N-1)          
   Vec_Buf(i,1)= (Cmd_ang(i+1)-Cmd_ang(i))/step;
end
d_Afac_max = max( abs(Vec_Buf));   %1��ָ��ı仯�ʾ���ֵ�����ֵ 
d_Afac_min = min( abs(Vec_Buf));  
d_Afac_rang = d_Afac_max - d_Afac_min;%2��ָ��ı仯�ʾ���ֵ�ļ���

Vec_Buf= zeros(N-1,1);  %�������

In_Data(1) = d_Afac_max *Rad2Deg;    In_Data(2) = d_Afac_rang *Rad2Deg;  %��Ϊ��ֵ

                %%% ���ڽ�����ָ���� %%% 
e_a_max = max( abs(e_Ang)); %3����������ֵ  %����ֵ�����ֵ��Ҫȡ����ֵ
e_a_mean = abs(mean(e_Ang)); %4�����������ֵ�ľ���ֵ��ֵ
e_a_var = std(e_Ang); %5���������ɢ�̶�:������׼��   

for i =1:1:N          
    Sum_Buf = Sum_Buf + (e_Ang(i)*Rad2Deg)^2;     
end    
e_squaInt = Sum_Buf;       %6��������ƽ��������  
Sum_Buf= 0; %�����������

V_peaks = findpeaks(e_Ang); %�������������ݵķ�ֵ 
e_oscill = length( V_peaks ); %��ֵ�ĸ��� %7���������𵴴���  

In_Data(3) = e_a_max *Rad2Deg;  In_Data(4) = e_a_mean *Rad2Deg;  In_Data(5) = e_a_var *Rad2Deg ; 
In_Data(6) = e_squaInt;   In_Data(7) = e_oscill;   %��Ϊ��ֵ

                %%% ���ڽ��ٶ�����ָ���� %%%    
e_w_max = max( abs(e_W));   %8�����ٶ��������ֵ  %����ֵ�����ֵ��Ҫȡ����ֵ
e_w_mean = abs(mean(e_W)); %9��������ٶ�����ֵ�ľ���ֵ��ֵ
e_w_var = std(e_W); %10�����ٶ����ı�׼�� 

V_peaks = findpeaks(e_W); %�������������ݵķ�ֵ
eWz_oscill = length( V_peaks ); %��ֵ�ĸ���  %11�����ٶ������𵴴���

In_Data(8) = e_w_max *Rad2Deg;  In_Data(9) = e_w_mean *Rad2Deg ;   In_Data(10) = e_w_var *Rad2Deg;  
In_Data(11) = eWz_oscill;

                 %%% ��ƫ����� %%%
Dtp_max = max( abs(Dlt_eqt));  %12����ƫ���ֵ��ִ��������Լ����   

for i =1:1:(N-1)         
   Vec_Buf(i,1)= (Dlt_eqt(i+1)-Dlt_eqt(i))/step;
end
d_Dtp_max = max( abs(Vec_Buf));    %13����ƫһ�׵������ֵ��ִ��������Լ����

V_peaks = findpeaks(Dlt_eqt); %�������������ݵķ�ֵ
Dtp_oscill = length( V_peaks ); %��ֵ�ĸ��� %14����ƫ���𵴴���

for i =1:1:N  
    if abs(Dlt_act(i)) >= 19.9
        count_p = count_p+1;
    end
end
Dtp_satu = count_p*step; %15)ʵ�ʶ�ƫ�ı���ʱ��

In_Data(12) = Dtp_max;	In_Data(13) = d_Dtp_max;	In_Data(14) = Dtp_oscill;   In_Data(15) = Dtp_satu;

%% ��ָ�����޷� 
if In_Data(1) > limit(1)
    In_Data(1) = limit(1);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end     
if In_Data(2) > limit(2)
    In_Data(2) = limit(2);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end    
if In_Data(3) > limit(3)
    In_Data(3) = limit(3);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end     
if In_Data(4) > limit(4)
    In_Data(4) = limit(4);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end    
if In_Data(5) > limit(5)
    In_Data(5) = limit(5);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end     
if In_Data(6) > limit(6)
    In_Data(6) = limit(6);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end    
if In_Data(7) > limit(7)
    In_Data(7) = limit(7);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end     
if In_Data(8) > limit(8)
    In_Data(8) = limit(8);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end   
if In_Data(9) > limit(9)
    In_Data(9) = limit(9);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end     
if In_Data(10) > limit(10)
    In_Data(10) = limit(10);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end    
if In_Data(11) > limit(11)
    In_Data(11) = limit(11);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end     
if In_Data(12) > limit(12)
    In_Data(12) = limit(12);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end    
if In_Data(13) > limit(13)
    In_Data(13) = limit(13);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end     
if In_Data(14) > limit(14)
    In_Data(14) = limit(14);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end    
if In_Data(15) > limit(15)
    In_Data(15) = limit(15);  %���ڸ���Ŀ����֪��ָ��ǣ������Բ��޷�
end     
