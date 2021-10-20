%% 数据归一化处理，并整理出用于网络训练的输入输出数据
function []=DataProcess(Buffer1,k)

[~,Data_size] = size(Buffer1); %每一列是一个样本，列数为数据库中的总样本数

%%%%对神经网络的输入数据的每一维做归一化处理，归一化到0~1
Buffer2 = Buffer1(1:15,:);  %取出输入的特征向量 

[Buffer3,PS] = mapminmax(Buffer2); % 对整个矩阵的数据进行归一化，到[0,1]之间
Data_max = PS.xmax;     Data_min = PS.xmin;
save('data_limit','Data_max','Data_min');%该极限值要保存下来，网络的新的输入数据应该按此范围做归一化

Num_test = round(Data_size*0.8);
In = Buffer3(:,1:Num_test); %前4/5个数据全部作为训练数据，
Inc = Buffer3(:,(Num_test+1):Data_size); %后1/5个数据作为测试数据
Inc_all = Buffer3; %全部数据做测试
Inc_org = Buffer1(:,(Num_test+1):Data_size);

%%%%%%输出数据处理
%定义输出向量 分别为[1 0 0 0 0];[0 1 0 0 0];[0 0 1 0 0];[0 0 0 1 0];[0 0 0 0 1];[0 0 0 0 0]
Out_org = Buffer1(16,:);%取出一行维数据为输出
Buffer4 = zeros(5, Data_size);                                                          
for i=1:1:Data_size
    switch floor( Out_org(i)) 
       case 1
            Buffer4(:,i)=[1 -1 -1 -1 -1];%1级//应该用1，-1，而不是0,1
        case 2
            Buffer4(:,i)=[-1 1 -1 -1 -1];%2级
        case 3
            Buffer4(:,i)=[-1 -1 1 -1 -1]; %3级 
        case 4
            Buffer4(:,i)=[-1 -1 -1 1 -1];%4级
        case 5
            Buffer4(:,i)=[-1 -1 -1 -1 1]; %5级 
%         case 0
%             Buffer4(:,i)=[1 0 0 0 0];%1级
%         case 1
%             Buffer4(:,i)=[0 1 0 0 0];%2级
%         case 2
%             Buffer4(:,i)=[0 0 1 0 0]; %3级 
%         case 3
%             Buffer4(:,i)=[0 0 0 1 0];%4级
%         case 4
%             Buffer4(:,i)=[0 0 0 0 1]; %5级 
     end
end
Out = Buffer4(:,1:Num_test);  %前4/5个数据全部作为训练数据，
Outc5 = Buffer4(:,(Num_test+1):Data_size); %后1/5个数据作为测试数据 网络输出
Outc5_all = Buffer4; %后1/5个数据作为测试数据
Outc1 = Out_org(:,(Num_test+1):Data_size); %测试数据对应的实际输出数据
Outc1_all= Out_org;

Trace = strcat('TrainData',num2str(k),'.mat');%连接路径和文件名得到完整的文件路径
save(Trace,'In','Out','Inc','Inc_all','Outc5','Outc5_all','Outc1','Outc1_all'); 

end