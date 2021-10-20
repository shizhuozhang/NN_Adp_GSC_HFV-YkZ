%神经网络在线评估控制系统的稳定裕度问题
clear all;
close all;
% 数据预处理:先随机打乱数据，再对数据进行归一化，然后可以直接顺序选取训练数据和测试数据
% Trace = strcat('TrainData',num2str(k),'.mat');%连接路径和文件名得到完整的文件路径
% save(Trace,'In','Out','Inc','Inc_all','Outc_n','Outc_n_all','Outc_r','Outc_r_all'); 
case_flag = 3;%用来选择网络训练的数据库
if case_flag==1
    load TrainData1.mat;  %加载原数据1，基本数据库
elseif case_flag==2
    load TrainData2.mat;  %加载原数据1，基本数据库
elseif case_flag==3
    load TrainData3.mat;  %加载原数据1，基本数据库
else
    load TrainData3.mat;  %加载原数据1，基本数据库
end
% % % 'In','Out',%%用于网络训练的输入输出数据
% % % 'Inc','Outc5','Outc1',%%用于网络测试的输入输出数据，输出包括5维输出和1维输出
% % % 'Inc_all','Outc5_all','Outc1_all'%%将全部数据用于网络测试的输入输出数据，输出包括5维输出和1维输出
%% BP网络结构及参数初始化
 % BP网络结构为 15-25-5
 Hid_num = 25;
 
[R,Q]= size(In);
[S,~]= size(Out);
%% 使用不同的隐含层数目训练网络  
net = newff(In,Out,Hid_num,{'tansig','tansig'});  %建立BP神经网络 ,'trainlm''purelin''logsig'
net. trainFcn = 'trainlm';
net.trainParam.epochs = 2000;  %设置训练次数
net.trainParam.max_fail = 30;
net.trainParam.goal = 0.005;  %设置mean square error， 均方误差,
net.trainParam.lr = 0.1; %设置学习速率

net.iw{1,1}=rands(Hid_num,R);  %隐含层神经元的初始权值
net.lw{2,1}=rands(S,Hid_num);  %输出层神经元的初始权值
net.b{1}=rands(Hid_num,1);  %隐含层神经元的初始偏置
net.b{2}=rands(S,1);  %输出层神经元的初始偏置

[net,tr_gd] = train(net,In,Out);  %训练网络

% %% 保存权值
Hw = net.iw{1,1};
Hb = net.b{1};
Ow = net.lw{2,1};
Ob= net.b{2};
save('NetWeight33.mat','Hw','Hb','Ow','Ob');   %%25个隐含层元比较好，5还不错
save('Net33.mat','net');

%%%% data0 %01 正确率 0.9739/0.9975； %02 正确率 0.9756/0.9983； %03 正确率 0.9782/0.9966
%%%% data1 %11 正确率 0.9563/0.9882； %12 正确率 0.9655/0.9916； %13 正确率 0.9588/0.9916
%%%% data2 %21 正确率 0.9605/0.9975； %22 正确率 0.9697/0.9992； %23 正确率 0.9588/0.9958
%%%% data3 %31 正确率 0.9546/0.9903； %32 正确率 0.9405/0.9903； %33 正确率 0.9382/0.9881
%%%% data4 %41 正确率 0.9412/0.9911； %42 正确率 0.814/0.9561； %43 正确率 0.9368/0.9829
%% 用全新数据进行测试
[Sc1,Qc1]= size(Outc5);
Res1 = zeros(1,Qc1);
One1 = ones(1,Qc1);

A1 = sim( net,Inc);  %测试网络

[~,Res1]= max(A1);

E2 = floor( Outc1) - Res1;
I1=find(E2(:)==0);  %识别正确的数据
I1_1=find(E2(:)==1);  %识别差1的数据
I1_2=find(E2(:)==-1);  %识别差1的数据
I1_3=find( abs(E2(:))>1);  %识别错误的数据
correct_rate1 = length(I1)/Qc1  %正确率
correct_rate1_1 = (length(I1)+length(I1_1)+length(I1_2))/Qc1    %正确率

Assess_Test(net);
