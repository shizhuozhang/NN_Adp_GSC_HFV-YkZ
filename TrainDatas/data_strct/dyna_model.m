%神经网络在线评估控制系统的稳定裕度问题
%author：ZYK 2019.11.07
%对源数据的第二步处理，构建系统的传递函数模型，求取对应特征点处的裕度大小，该文件记标号为 1.1.1
function [Pm_out, Wcp_out, Level]=dyna_model(Para)
%入口参数: 所要处理的数据文件名称
%实现功能：
%返回参数： 无
%备注：
%% 变量声明、定义及初始化
global Channelx;
Level=0;
    
c1 = Para(1);    c2 = Para(2);    c3 = Para(3);
b1 = Para(4);    b2 = Para(5);    b3 = Para(6); 
Kin = Para(7);    Kout = Para(8);    

%% 飞行器本体模型,即控制框图中各独立组件的模型
if(Channelx==1)  %俯仰通道
    %%俯仰通道的校正网络  滞后网络
    nump = [0.0289,1];  %[0.0577,0.6928],[0.1924,0.231]这组参数也可以用
    denp = [0.3464,1];  %
    Gp = tf(nump,denp); 
elseif(Channel==3)  %滚转通道
    %%滚转通道的校正网络  滞后网络
    nump = [0.1763,1];%这组参数也可以用
    denp = [5.686,1];%
    Gp = tf(nump,denp);  
end

%角度对舵的传递函数
num = [c3, (b3*c2 - b1*c3)];
den = [1, -(b1+c1), (c1*b1 -c2*b2)];
Gad = tf(num,den);

%角速度对舵的传递函数        
num = [b3, (b2*c3 - c1*b3)];
den = [1, -(b1+c1), (c1*b1 -c2*b2)];
Gwd = tf(num,den);

%角度对角速度的传递函数
num = [c3, (b3*c2 - b1*c3)];
den= [b3, (b2*c3 - c1*b3)];
Gaw = tf(num,den);

Ga = Kin*Gp*Gwd;    % 内环角速度本体的开环传递函数
Gin = feedback(Ga,1);  % 内环闭环传递函数
Gb = Kout*Gin*Gaw;  %外环开环传递函数
 %四个参数分别为：幅值裕度（单位不是dB,要取20log）；相角裕度（单位：度）；-180度穿越频率和剪切（截止）频率（单位rad/s）
   %注意开环截止频率和闭环带宽正相关，但大小并不相同
 [Gm_out,Pm_out,Wcg_out,Wcp_out]=margin(Gb);

%% 对各特征点的稳定裕度进行标定，一共分为5级，Data_calibration()

if  Wcp_out > 22   %稳定性 不及格  截止频率>22rad/s
    Level =5; 
elseif Wcp_out > 16 %等级4 %稳定性 及格  截止频率<22rad/s；
    Level =4;
elseif Wcp_out > 10 %等级3   %稳定性 中等  截止频率<16rad/s；
    Level =3;
elseif Wcp_out > 5 %等级2   %稳定性 良好  截止频率<10rad/s；
    Level =2;    
elseif Wcp_out > 0.5 %等级1  %稳定性 优秀  截止频率<5rad/s；
    Level =1;    
else  %等级0
    Level =0;                    
end


end



