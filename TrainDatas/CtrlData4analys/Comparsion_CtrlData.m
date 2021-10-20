clear all;
close all;

My_PI = 3.14159;
Rad2Deg = 180 / My_PI; 

load CtrlData_1_0_1.mat;
T = CtrlData(:,1);  
Dlt_e1 = CtrlData(:,11); 
Ero_alp1 = CtrlData(:,14);   Ero_mu1 = CtrlData(:,16);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
Ero_qw1 = CtrlData(:,17);    Ero_pw1 = CtrlData(:,19);  %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
Acc_pit1 = CtrlData(:,20);   Acc_rol1 = CtrlData(:,22);  %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];

load CtrlData_3_0_1.mat;
Dlt_e3 = CtrlData(:,11); 
Ero_alp3 = CtrlData(:,14);   Ero_mu3 = CtrlData(:,16);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
Ero_qw3 = CtrlData(:,17);    Ero_pw3 = CtrlData(:,19);  %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
Acc_pit3 = CtrlData(:,20);   Acc_rol3 = CtrlData(:,22);  %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];

load CtrlData_5_0_1.mat;
Dlt_e5 = CtrlData(:,11); 
Ero_alp5 = CtrlData(:,14);   Ero_mu5 = CtrlData(:,16);   %构成控制误差矢量 Eror_ang = [Ero_pit ,Ero_yaw, Ero_rol];
Ero_qw5 = CtrlData(:,17);    Ero_pw5 = CtrlData(:,19);  %构成角速度控制误差矢量 Eror_omg = [Ero_qw ,Ero_rw, Ero_pw];
Acc_pit5 = CtrlData(:,20);   Acc_rol5 = CtrlData(:,22);  %构成角加速度矢量 Accelrt = [Acc_pit ,Acc_yaw, Acc_rol];

% 角误差
figure(1);
set(gcf,'windowstyle','normal');
set(gcf,'position',[550,100,900,600]);

subplot(3,3,1)
plot(T,Ero_alp1*Rad2Deg,'-r','LineWidth',2); 
axis([4 5 0 0.7]);
ylabel('e (deg)','FontSize',13);
title('Ctrller1','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,2)
plot(T,Ero_alp3*Rad2Deg,'-r','LineWidth',2); 
axis([4 5 0 0.3]);
title('Ctrller3','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,3)
plot(T,Ero_alp5*Rad2Deg,'-r','LineWidth',2); 
axis([4 5 0 0.2]);
title('Ctrller5','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,4)
plot(T,Ero_alp1*Rad2Deg,'-r','LineWidth',2); 
axis([40.5 41.5 -0.5 0.7]);
ylabel('e (deg)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,5)
plot(T,Ero_alp3*Rad2Deg,'-r','LineWidth',2); 
axis([40.5 41.5 -0.5 0.2]);%9.8 10.5
set(gca,'FontSize',12);

subplot(3,3,6)
plot(T,Ero_alp5*Rad2Deg,'-r','LineWidth',2); 
axis([40.5 41.5 -0.1 0.2]);
set(gca,'FontSize',12);

subplot(3,3,7)
plot(T,Ero_alp1*Rad2Deg,'-r','LineWidth',2); 
axis([14.5 15.5 -0.5 0.002]);
xlabel('Time (s)','FontSize',13);
ylabel('e (deg)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,8)
plot(T,Ero_alp3*Rad2Deg,'-r','LineWidth',2); 
axis([14.5 15.5 0 0.0005]);
xlabel('Time (s)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,9)
plot(T,Ero_alp5*Rad2Deg,'-r','LineWidth',2); 
axis([14.5 15.5 0 0.0002]);
xlabel('Time (s)','FontSize',13);
set(gca,'FontSize',12);

%% 角速度误差
figure(2);
set(gcf,'windowstyle','normal');
set(gcf,'position',[550,100,900,600]);

subplot(3,3,1)
plot(T,Ero_qw1*Rad2Deg,'-r','LineWidth',2); 
axis([4 5 -0.1 0]);
ylabel('e_q (deg/s)','FontSize',13);
title('Ctrller1','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,2)
plot(T,Ero_qw3*Rad2Deg,'-r','LineWidth',2); 
axis([4 5 -0.1 0]);
title('Ctrller3','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,3)
plot(T,Ero_qw5*Rad2Deg,'-r','LineWidth',2); 
axis([4 5 -0.1 0]);
title('Ctrller5','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,4)
plot(T,Ero_qw1*Rad2Deg,'-r','LineWidth',2); 
axis([40.5 41.5 -0.3 0]);
ylabel('e_q (deg/s)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,5)
plot(T,Ero_qw3*Rad2Deg,'-r','LineWidth',2); 
axis([40.5 41.5 -0.5 0.2]);
set(gca,'FontSize',12);

subplot(3,3,6)
plot(T,Ero_qw5*Rad2Deg,'-r','LineWidth',2); 
axis([40.5 41.5 -1 1.2]);
set(gca,'FontSize',12);

subplot(3,3,7)
plot(T,Ero_qw1*Rad2Deg,'-r','LineWidth',2); 
axis([14.5 15.5 -0.2 0]);
xlabel('Time (s)','FontSize',13);
ylabel('e_q (deg/s)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,8)
plot(T,Ero_qw3*Rad2Deg,'-r','LineWidth',2); 
axis([14.5 15.5 -0.2 0]);
xlabel('Time (s)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,9)
plot(T,Ero_qw5*Rad2Deg,'-r','LineWidth',2); 
axis([14.5 15.5 -0.2 0]);
xlabel('Time (s)','FontSize',13);
set(gca,'FontSize',12);

%% 舵偏
figure(3);
set(gcf,'windowstyle','normal');
set(gcf,'position',[550,100,900,600]);

subplot(3,3,1)
plot(T,Dlt_e1,'-r','LineWidth',2); 
axis([4 5 -6 -3]);
ylabel('Delta (deg)','FontSize',13);
title('Ctrller1','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,2)
plot(T,Dlt_e3,'-r','LineWidth',2); 
axis([4 5 -6 -3]);
title('Ctrller3','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,3)
plot(T,Dlt_e5,'-r','LineWidth',2); 
axis([4 5 -6 -3]);
title('Ctrller5','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,4)
plot(T,Dlt_e1,'-r','LineWidth',2); 
axis([40.5 41.5 -16 -10]);
ylabel('Delta (deg)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,5)
plot(T,Dlt_e3,'-r','LineWidth',2); 
axis([40.5 41.5 -20 -10]);
set(gca,'FontSize',12);

subplot(3,3,6)
plot(T,Dlt_e5,'-r','LineWidth',2); 
axis([40.5 41.5 -20 0]);
set(gca,'FontSize',12);

subplot(3,3,7)
plot(T,Dlt_e1,'-r','LineWidth',2); 
axis([14.5 15.5 -14 -13.5]);
xlabel('Time (s)','FontSize',13);
ylabel('Delta (deg)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,8)
plot(T,Dlt_e3,'-r','LineWidth',2); 
axis([14.5 15.5 -14 -13.5]);
xlabel('Time (s)','FontSize',13);
set(gca,'FontSize',12);

subplot(3,3,9)
plot(T,Dlt_e5,'-r','LineWidth',2); 
axis([14.5 15.5 -14 -13.5]);
xlabel('Time (s)','FontSize',13);
set(gca,'FontSize',12);
 %% 角加速度
% figure(4);
% set(gcf,'windowstyle','normal');
% set(gcf,'position',[550,100,900,600]);
% 
% subplot(3,3,1)
% plot(T,Acc_pit1*Rad2Deg,'-r','LineWidth',2); 
% axis([4 5 0 0.05]);
% ylabel('Acce (deg/s/s)','FontSize',13);
% title('Ctrller1','FontSize',13);
% set(gca,'FontSize',12);
% 
% subplot(3,3,2)
% plot(T,Acc_pit3*Rad2Deg,'-r','LineWidth',2); 
% axis([4 5 0 0.05]);
% title('Ctrller3','FontSize',13);
% set(gca,'FontSize',12);
% 
% subplot(3,3,3)
% plot(T,Acc_pit5*Rad2Deg,'-r','LineWidth',2); 
% axis([4 5 0 0.05]);
% title('Ctrller5','FontSize',13);
% set(gca,'FontSize',12);
% 
% subplot(3,3,4)
% plot(T,Acc_pit1*Rad2Deg,'-r','LineWidth',2); 
% axis([9.8 11.5 -8 0.1]);
% ylabel('Acce (deg/s/s)','FontSize',13);
% set(gca,'FontSize',12);
% 
% subplot(3,3,5)
% plot(T,Acc_pit3*Rad2Deg,'-r','LineWidth',2); 
% axis([9.8 11.5 -25 5]);
% set(gca,'FontSize',12);
% 
% subplot(3,3,6)
% plot(T,Acc_pit5*Rad2Deg,'-r','LineWidth',2); 
% axis([9.8 11.5 -30 40]);
% set(gca,'FontSize',12);
% 
% subplot(3,3,7)
% plot(T,Acc_pit1*Rad2Deg,'-r','LineWidth',2); 
% axis([14.5 15.5 -0.004 0.004]);
% xlabel('Time (s)','FontSize',13);
% ylabel('Acce (deg/s/s)','FontSize',13);
% set(gca,'FontSize',12);
% 
% subplot(3,3,8)
% plot(T,Acc_pit3*Rad2Deg,'-r','LineWidth',2); 
% axis([14.5 15.5 -0.004 0.004]);
% xlabel('Time (s)','FontSize',13);
% set(gca,'FontSize',12);
% 
% subplot(3,3,9)
% plot(T,Acc_pit5*Rad2Deg,'-r','LineWidth',2); 
% axis([14.5 15.5 -0.004 0.004]);
% xlabel('Time (s)','FontSize',13);
% set(gca,'FontSize',12);