clear all;
close all;
My_PI = 3.14159;
Rad2Deg = 180 / My_PI; 

%% 无干扰
% load CtrlData_0_0_0-1.mat;
% T = CtrlData(:,1);   Cmd_alp = CtrlData(:,8);  
% q0 = CtrlData(:,5);  Dlt_e0 = CtrlData(:,11);  
% Ero_alp0 = CtrlData(:,14);  Ero_qw0 = CtrlData(:,17);  Dlt_alp0 = CtrlData(:,23);
% rankS0 = CtrlData(:,26);  rankD0 = CtrlData(:,27);Koutp0 = CtrlData(:,28);
% 
% load CtrlData_1_0_0.mat;
% q10 = CtrlData(1:10000,5);  Dlt_e10 = CtrlData(1:10000,11);  
% Ero_alp10 = CtrlData(1:10000,14);  Ero_qw10 = CtrlData(1:10000,17);  Dlt_alp10 = CtrlData(1:10000,23);
% 
% load CtrlData_3_0_0.mat;
% q30 = CtrlData(1:10000,5);  Dlt_e30 = CtrlData(1:10000,11);  
% Ero_alp30 = CtrlData(1:10000,14);  Ero_qw30 = CtrlData(1:10000,17);  Dlt_alp30 = CtrlData(1:10000,23);
% 
% load CtrlData_5_0_0.mat;
% q50 = CtrlData(1:10000,5);  Dlt_e50 = CtrlData(1:10000,11);  
% Ero_alp50 = CtrlData(1:10000,14);  Ero_qw50 = CtrlData(1:10000,17);  Dlt_alp50 = CtrlData(1:10000,23);

% figure(1);
% plot(T,Ero_alp0*Rad2Deg,'-r','LineWidth',2); 
% hold on
% grid on
% plot(T,Ero_alp10*Rad2Deg,'-.k','LineWidth',2); 
% plot(T,Ero_alp30*Rad2Deg,'--b','LineWidth',2); 
% plot(T,Ero_alp50*Rad2Deg,':m','LineWidth',2); 
% xlabel('Time (s)','FontSize',13);
% ylabel('Error_{\alpha} (deg)','FontSize',13);
% axis([0 50 -0.5 0.9])
% h1=legend('CPA-AGS','Ctrller1','Ctrller3','Ctrller5','Location','NorthEast');
% set(h1,'box','off');
% set(gcf,'windowstyle','normal');
% set(gcf,'position',[550,100,700,400]);
% set(gca,'FontSize',13);
% 
% figure(2);
% set(gcf,'windowstyle','normal');
% set(gcf,'position',[550,100,600,400]);
% set(gca,'FontSize',13);
% plot(T,Dlt_e0,'-r','LineWidth',2);
% grid on
% xlabel('Time (s)','FontSize',13);
% ylabel('Delta-e (deg)','FontSize',13);
% axis([0 50 -20 5]);
% magnify   %%局部放大镜
% 
% figure(3);
% set(gcf,'windowstyle','normal');
% set(gcf,'position',[550,100,800,400]);
% 
% subplot(1,2,1)
% plot(T,rankS0,'*r','LineWidth',2); 
% axis([0 50 0.5 5.5])
% xlabel('Time (s)','FontSize',13);
% ylabel('Rank','FontSize',13);
% set(gca,'FontSize',13);
% 
% subplot(1,2,2)
% plot(T,Koutp0,'-r','LineWidth',2); 
% axis([0 50 2 16])
% xlabel('Time (s)','FontSize',13);
% ylabel('Gain','FontSize',13);
% set(gca,'FontSize',13);

%% 有偏差
%load CtrlData_0_0_1.mat;
 load CtrlData_0_0_1-13.mat;
T = CtrlData(:,1); 
q1 = CtrlData(:,5);  Dlt_e1 = CtrlData(:,11);  
Ero_alp1 = CtrlData(:,14);  Ero_qw1 = CtrlData(:,17);  Dlt_alp1 = CtrlData(:,23);
rankS1 = CtrlData(:,26); rankD1 = CtrlData(:,27);Koutp1 = CtrlData(:,28);

load CtrlData_1_15_16.mat;
Ero_alp2 = CtrlData(1:10000,14); 
% q2 = CtrlData(:,5);  Dlt_e2 = CtrlData(:,11);  Ero_qw2 = CtrlData(:,17);  Dlt_alp2 = CtrlData(:,23);

%load CtrlData_3_10_16.mat;
 load CtrlData_3_15_16.mat;
T3 = CtrlData(:,1);
Ero_alp3 = CtrlData(:,14); 
% q3 = CtrlData(:,5);  Dlt_e3 = CtrlData(:,11);  Ero_qw3 = CtrlData(:,17);  Dlt_alp3 = CtrlData(:,23);

load CtrlData_5_15_16.mat;
T5 = CtrlData(:,1);
Ero_alp5 = CtrlData(:,14); 
% q5 = CtrlData(:,5);  Dlt_e5 = CtrlData(:,11);  Ero_qw5 = CtrlData(:,17);  Dlt_alp5 = CtrlData(:,23);

figure(11);
plot(T,Ero_alp1*Rad2Deg,'-r','LineWidth',2); 
hold on
grid on
plot(T,Ero_alp2*Rad2Deg,'-.k','LineWidth',2); 
plot(T3,Ero_alp3*Rad2Deg,'--b','LineWidth',2); 
plot(T5,Ero_alp5*Rad2Deg,':m','LineWidth',2); 
xlabel('Time (s)','FontSize',13);
ylabel('Error_{\alpha} (deg)','FontSize',13);
axis([0 50 -0.5 0.9])
h1=legend('CPA-AGS','Ctrller1','Ctrller3','Ctrller5','Location','NorthEast');
set(h1,'box','off');
set(gcf,'windowstyle','normal');
set(gcf,'position',[550,100,700,400]);
set(gca,'FontSize',13);
magnify   %%局部放大镜

figure(12);
set(gcf,'windowstyle','normal');
set(gcf,'position',[550,100,700,400]);
set(gca,'FontSize',13);
plot(T,Dlt_e1,'-r','LineWidth',2);
grid on
xlabel('Time (s)','FontSize',13);
ylabel('Delta-e (deg)','FontSize',13);
axis([0 50 -20 5]);
magnify   %%局部放大镜

figure(13);
set(gcf,'windowstyle','normal');
set(gcf,'position',[550,100,800,400]);

subplot(1,2,1)
plot(T,rankS1,'*r','LineWidth',2); 
axis([0 50 0.5 5.5])
xlabel('Time (s)','FontSize',13);
ylabel('Rank','FontSize',13);
set(gca,'FontSize',13);

subplot(1,2,2)
plot(T,Koutp1,'-r','LineWidth',2); 
axis([0 50 2 16])
xlabel('Time (s)','FontSize',13);
ylabel('Gain','FontSize',13);
set(gca,'FontSize',13);

%% 有干扰
% load CtrlData_0_1_0.mat;
% % % load CtrlData_0_1_1.mat;
% T = CtrlData(:,1); 
% q1 = CtrlData(:,5);  Dlt_e1 = CtrlData(:,11);  
% Ero_alp1 = CtrlData(:,14);  Ero_qw1 = CtrlData(:,17);  Dlt_alp1 = CtrlData(:,23);
% rankS1 = CtrlData(:,26); rankD1 = CtrlData(:,27);Koutp1 = CtrlData(:,28);
% 
% load CtrlData_1_1_0.mat;
% % % % load CtrlData_1_1_1.mat;
% q2 = CtrlData(:,5);  Dlt_e2 = CtrlData(:,11);  
% Ero_alp2 = CtrlData(:,14);  Ero_qw2 = CtrlData(:,17);  Dlt_alp2 = CtrlData(:,23);
% 
% load CtrlData_3_1_0.mat;
% % % load CtrlData_3_1_1.mat;
% q3 = CtrlData(:,5);  Dlt_e3 = CtrlData(:,11);  
% Ero_alp3 = CtrlData(:,14);  Ero_qw3 = CtrlData(:,17);  Dlt_alp3 = CtrlData(:,23);
% 
% load CtrlData_5_1_0.mat;
% T5 = CtrlData(:,1);
% q5 = CtrlData(:,5);  Dlt_e5 = CtrlData(:,11);  
% Ero_alp5 = CtrlData(:,14);  Ero_qw5 = CtrlData(:,17);  Dlt_alp5 = CtrlData(:,23);
% 
% figure(21);
% plot(T,Ero_alp1*Rad2Deg,'-r','LineWidth',2); 
% hold on
% grid on
% plot(T,Ero_alp2*Rad2Deg,'-.k','LineWidth',2); 
% plot(T,Ero_alp3*Rad2Deg,'--b','LineWidth',2); 
% plot(T5,Ero_alp5*Rad2Deg,':m','LineWidth',2); 
% xlabel('Time (s)','FontSize',13);
% ylabel('Error_{\alpha} (deg)','FontSize',13);
% axis([0 50 -0.5 0.9])
% h1=legend('CPA-AGS','Ctrller1','Ctrller3','Ctrller5','Location','NorthEast');
% set(h1,'box','off');
% set(gcf,'windowstyle','normal');
% set(gcf,'position',[550,100,700,400]);
% set(gca,'FontSize',13);
% magnify   %%局部放大镜
% 
% % figure(22);
% % set(gcf,'windowstyle','normal');
% % set(gcf,'position',[550,100,600,400]);
% % set(gca,'FontSize',13);
% % plot(T,Dlt_e1,'-r','LineWidth',2);
% % grid on
% % xlabel('Time (s)','FontSize',13);
% % ylabel('Delta-e (deg)','FontSize',13);
% % axis([0 50 -20 5]);
% % magnify   %%局部放大镜
% % 
% % figure(23);
% % set(gcf,'windowstyle','normal');
% % set(gcf,'position',[550,100,800,400]);
% % 
% % subplot(1,2,1)
% % plot(T,rankS1,'*r','LineWidth',2); 
% % axis([0 50 0.5 5.5])
% % xlabel('Time (s)','FontSize',13);
% % ylabel('Rank','FontSize',13);
% % set(gca,'FontSize',13);
% % 
% % subplot(1,2,2)
% % plot(T,Koutp1,'-r','LineWidth',2); 
% % axis([0 50 2 16])
% % xlabel('Time (s)','FontSize',13);
% % ylabel('Gain','FontSize',13);
% % set(gca,'FontSize',13);
% 

