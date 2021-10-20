%������������������ϵͳ���ȶ�ԣ������
clear all;
close all;
% ����Ԥ����:������������ݣ��ٶ����ݽ��й�һ����Ȼ�����ֱ��˳��ѡȡѵ�����ݺͲ�������
% Trace = strcat('TrainData',num2str(k),'.mat');%����·�����ļ����õ��������ļ�·��
% save(Trace,'In','Out','Inc','Inc_all','Outc_n','Outc_n_all','Outc_r','Outc_r_all'); 
case_flag = 3;%����ѡ������ѵ�������ݿ�
if case_flag==1
    load TrainData1.mat;  %����ԭ����1���������ݿ�
elseif case_flag==2
    load TrainData2.mat;  %����ԭ����1���������ݿ�
elseif case_flag==3
    load TrainData3.mat;  %����ԭ����1���������ݿ�
else
    load TrainData3.mat;  %����ԭ����1���������ݿ�
end
% % % 'In','Out',%%��������ѵ���������������
% % % 'Inc','Outc5','Outc1',%%����������Ե�����������ݣ��������5ά�����1ά���
% % % 'Inc_all','Outc5_all','Outc1_all'%%��ȫ����������������Ե�����������ݣ��������5ά�����1ά���
%% BP����ṹ��������ʼ��
 % BP����ṹΪ 15-25-5
 Hid_num = 25;
 
[R,Q]= size(In);
[S,~]= size(Out);
%% ʹ�ò�ͬ����������Ŀѵ������  
net = newff(In,Out,Hid_num,{'tansig','tansig'});  %����BP������ ,'trainlm''purelin''logsig'
net. trainFcn = 'trainlm';
net.trainParam.epochs = 2000;  %����ѵ������
net.trainParam.max_fail = 30;
net.trainParam.goal = 0.005;  %����mean square error�� �������,
net.trainParam.lr = 0.1; %����ѧϰ����

net.iw{1,1}=rands(Hid_num,R);  %��������Ԫ�ĳ�ʼȨֵ
net.lw{2,1}=rands(S,Hid_num);  %�������Ԫ�ĳ�ʼȨֵ
net.b{1}=rands(Hid_num,1);  %��������Ԫ�ĳ�ʼƫ��
net.b{2}=rands(S,1);  %�������Ԫ�ĳ�ʼƫ��

[net,tr_gd] = train(net,In,Out);  %ѵ������

% %% ����Ȩֵ
Hw = net.iw{1,1};
Hb = net.b{1};
Ow = net.lw{2,1};
Ob= net.b{2};
save('NetWeight33.mat','Hw','Hb','Ow','Ob');   %%25��������Ԫ�ȽϺã�5������
save('Net33.mat','net');

%%%% data0 %01 ��ȷ�� 0.9739/0.9975�� %02 ��ȷ�� 0.9756/0.9983�� %03 ��ȷ�� 0.9782/0.9966
%%%% data1 %11 ��ȷ�� 0.9563/0.9882�� %12 ��ȷ�� 0.9655/0.9916�� %13 ��ȷ�� 0.9588/0.9916
%%%% data2 %21 ��ȷ�� 0.9605/0.9975�� %22 ��ȷ�� 0.9697/0.9992�� %23 ��ȷ�� 0.9588/0.9958
%%%% data3 %31 ��ȷ�� 0.9546/0.9903�� %32 ��ȷ�� 0.9405/0.9903�� %33 ��ȷ�� 0.9382/0.9881
%%%% data4 %41 ��ȷ�� 0.9412/0.9911�� %42 ��ȷ�� 0.814/0.9561�� %43 ��ȷ�� 0.9368/0.9829
%% ��ȫ�����ݽ��в���
[Sc1,Qc1]= size(Outc5);
Res1 = zeros(1,Qc1);
One1 = ones(1,Qc1);

A1 = sim( net,Inc);  %��������

[~,Res1]= max(A1);

E2 = floor( Outc1) - Res1;
I1=find(E2(:)==0);  %ʶ����ȷ������
I1_1=find(E2(:)==1);  %ʶ���1������
I1_2=find(E2(:)==-1);  %ʶ���1������
I1_3=find( abs(E2(:))>1);  %ʶ����������
correct_rate1 = length(I1)/Qc1  %��ȷ��
correct_rate1_1 = (length(I1)+length(I1_1)+length(I1_2))/Qc1    %��ȷ��

Assess_Test(net);
