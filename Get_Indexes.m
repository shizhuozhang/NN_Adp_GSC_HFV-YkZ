%神经网络在线评估控制系统的稳定裕度问题
%author：ZYK 2019.11.07
%对源数据的第二步处理，构建系统的传递函数模型，求取对应特征点处的裕度大小，该文件记标号为 1.2.1
function [In_Data]=Get_Indexes(win_data)
%% 数据赋值、初始化
global N;
global Rad2Deg;  %%弧度转换为度
global samp_step;  %%评估所用数据的采样步长

%俯仰通道
Cmd_ang = win_data(:,1); %指令角  % Afa = win_data(:,6); %实际角  
e_Ang = win_data(:,2); %角度跟踪控制误差
e_W = win_data(:,3); 
Dlt_eqt = win_data(:,4); %等效舵偏
Dlt_act = win_data(:,5); %实际舵偏

Vec_Buf= zeros(N-1,1); 
Sum_Buf= 0;
count_p = 0;
%% 处理俯仰控制通道的数据
%首先对数据做统计学处理，然后对数据进行限幅处理，减小坏数据对网络训练的影响，这一点很重要
limit(1) = 5;   limit(2) = 5; limit(5) = 10; limit(8) = 10; limit(11) = 10; 
limit(3) = 0.5; limit(4) = 0.2;   limit(6) = 0.6;    limit(7) = 0.09;
limit(9) = 20; limit(10)= 250;  

                %%% 关于角度指令的指标量，这也是一个很关键的量 %%%
for i =1:1:(N-1)          
   Vec_Buf(i,1)= (Cmd_ang(i+1)-Cmd_ang(i))/samp_step;
end
d_Afac_max = max( abs(Vec_Buf));   %1）指令的变化率绝对值的最大值 
d_Afac_min = min( abs(Vec_Buf));  
d_Afac_rang = d_Afac_max - d_Afac_min;%2）指令的变化率绝对值的极差

Vec_Buf= zeros(N-1,1);  %清除缓存

In_Data(1) = d_Afac_max *Rad2Deg;    In_Data(2) = d_Afac_rang *Rad2Deg;  %均为正值

                %%% 关于角误差的指标量 %%% 
e_a_max = max( abs(e_Ang)); %3）角误差最大值  %误差幅值的最大值，要取绝对值
e_a_min = min(abs(e_Ang));
e_a_rang = e_a_max - e_a_min;
% e_a_mean = abs(mean(e_Ang)); %4）考察角误差均值的绝对值均值
% e_a_var = std(e_Ang); %5）角误差离散程度:方差或标准差   

% for i =1:1:N          
%     Sum_Buf = Sum_Buf + (e_Ang(i)*Rad2Deg)^2;     
% end    
% e_squaInt = Sum_Buf;       %6）角误差的平方误差积分  
% Sum_Buf= 0; %用完清除缓存
e_squaInt = sum( abs(e_Ang));   %6）角误差的绝对误差积分  

V_peaks = findpeaks(e_Ang); %考察区间内数据的峰值 
e_oscill = length( V_peaks ); %峰值的个数 %7）角误差的震荡次数  

In_Data(3) = e_a_rang *Rad2Deg; % In_Data(4) = e_a_mean *Rad2Deg;  In_Data(5) = e_a_var *Rad2Deg ; 
In_Data(4) = e_squaInt;   In_Data(5) = e_oscill;   %均为正值

                %%% 关于角速度误差的指标量 %%%    
e_w_max = max( abs(e_W));   %8）角速度误差的最大值  %误差幅值的最大值，要取绝对值
e_w_min = min( abs(e_W));
e_w_rang = e_w_max - e_w_min;
% e_w_mean = abs(mean(e_W)); %9）考察角速度误差均值的绝对值均值
% e_w_var = std(e_W); %10）角速度误差的标准差 

eW_squaInt =  sum( abs(e_W));       %6）角速度误差的平方误差积分  

V_peaks = findpeaks(e_W); %考察区间内数据的峰值
eWz_oscill = length( V_peaks ); %峰值的个数  %11）角速度误差的震荡次数

In_Data(6) = e_w_rang *Rad2Deg; In_Data(7) = eW_squaInt; %In_Data(9) = e_w_mean *Rad2Deg ;   In_Data(10) = e_w_var *Rad2Deg;  
In_Data(8) = eWz_oscill; 

                 %%% 舵偏相关量 %%%
Dtp_max = max( abs(Dlt_eqt));  %12）舵偏最大值（执行器饱和约束）   
Dtp_min = min( abs(Dlt_eqt)); 
Dtp_rang = Dtp_max - Dtp_min;

for i =1:1:(N-1)         
   Vec_Buf(i,1)= (Dlt_eqt(i+1)-Dlt_eqt(i))/samp_step;
end
d_Dtp_max = max( abs(Vec_Buf));    %13）舵偏一阶导的最大值（执行器速率约束）

V_peaks = findpeaks(Dlt_eqt); %考察区间内数据的峰值
Dtp_oscill = length( V_peaks ); %峰值的个数 %14）舵偏的震荡次数

% for i =1:1:N  
%     if abs(Dlt_act(i)) >= 19.9
%         count_p = count_p+1;
%     end
% end
% Dtp_satu = count_p*step; %15)实际舵偏的饱和时长

In_Data(9) = Dtp_rang;	In_Data(10) = d_Dtp_max;	In_Data(11) = Dtp_oscill;  % In_Data(15) = Dtp_satu;

%% 对指标做限幅 
if In_Data(1) > limit(1)
    In_Data(1) = limit(1);  %对于该项目中已知的指令角，本可以不限幅
end     
if In_Data(2) > limit(2)
    In_Data(2) = limit(2);  %对于该项目中已知的指令角，本可以不限幅
end    
if In_Data(3) > limit(3)
    In_Data(3) = limit(3);  %对于该项目中已知的指令角，本可以不限幅
end     
if In_Data(4) > limit(4)
    In_Data(4) = limit(4);  %对于该项目中已知的指令角，本可以不限幅
end    
if In_Data(5) > limit(5)
    In_Data(5) = limit(5);  %对于该项目中已知的指令角，本可以不限幅
end     
if In_Data(6) > limit(6)
    In_Data(6) = limit(6);  %对于该项目中已知的指令角，本可以不限幅
end    
if In_Data(7) > limit(7)
    In_Data(7) = limit(7);  %对于该项目中已知的指令角，本可以不限幅
end     
if In_Data(8) > limit(8)
    In_Data(8) = limit(8);  %对于该项目中已知的指令角，本可以不限幅
end   
if In_Data(9) > limit(9)
    In_Data(9) = limit(9);  %对于该项目中已知的指令角，本可以不限幅
end     
if In_Data(10) > limit(10)
    In_Data(10) = limit(10);  %对于该项目中已知的指令角，本可以不限幅
end    
if In_Data(11) > limit(11)
    In_Data(11) = limit(11);  %对于该项目中已知的指令角，本可以不限幅
end     
% if In_Data(12) > limit(12)
%     In_Data(12) = limit(12);  %对于该项目中已知的指令角，本可以不限幅
% end    
% if In_Data(13) > limit(13)
%     In_Data(13) = limit(13);  %对于该项目中已知的指令角，本可以不限幅
% end     
% if In_Data(14) > limit(14)
%     In_Data(14) = limit(14);  %对于该项目中已知的指令角，本可以不限幅
% end    
% if In_Data(15) > limit(15)
%     In_Data(15) = limit(15);  %对于该项目中已知的指令角，本可以不限幅
% end     
