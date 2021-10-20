%% ���ݹ�һ���������������������ѵ���������������
function []=DataProcess(Buffer1,k)

[~,Data_size] = size(Buffer1); %ÿһ����һ������������Ϊ���ݿ��е���������

%%%%����������������ݵ�ÿһά����һ��������һ����0~1
Buffer2 = Buffer1(1:15,:);  %ȡ��������������� 

[Buffer3,PS] = mapminmax(Buffer2); % ��������������ݽ��й�һ������[0,1]֮��
Data_max = PS.xmax;     Data_min = PS.xmin;
save('data_limit','Data_max','Data_min');%�ü���ֵҪ����������������µ���������Ӧ�ð��˷�Χ����һ��

Num_test = round(Data_size*0.8);
In = Buffer3(:,1:Num_test); %ǰ4/5������ȫ����Ϊѵ�����ݣ�
Inc = Buffer3(:,(Num_test+1):Data_size); %��1/5��������Ϊ��������
Inc_all = Buffer3; %ȫ������������
Inc_org = Buffer1(:,(Num_test+1):Data_size);

%%%%%%������ݴ���
%����������� �ֱ�Ϊ[1 0 0 0 0];[0 1 0 0 0];[0 0 1 0 0];[0 0 0 1 0];[0 0 0 0 1];[0 0 0 0 0]
Out_org = Buffer1(16,:);%ȡ��һ��ά����Ϊ���
Buffer4 = zeros(5, Data_size);                                                          
for i=1:1:Data_size
    switch floor( Out_org(i)) 
       case 1
            Buffer4(:,i)=[1 -1 -1 -1 -1];%1��//Ӧ����1��-1��������0,1
        case 2
            Buffer4(:,i)=[-1 1 -1 -1 -1];%2��
        case 3
            Buffer4(:,i)=[-1 -1 1 -1 -1]; %3�� 
        case 4
            Buffer4(:,i)=[-1 -1 -1 1 -1];%4��
        case 5
            Buffer4(:,i)=[-1 -1 -1 -1 1]; %5�� 
%         case 0
%             Buffer4(:,i)=[1 0 0 0 0];%1��
%         case 1
%             Buffer4(:,i)=[0 1 0 0 0];%2��
%         case 2
%             Buffer4(:,i)=[0 0 1 0 0]; %3�� 
%         case 3
%             Buffer4(:,i)=[0 0 0 1 0];%4��
%         case 4
%             Buffer4(:,i)=[0 0 0 0 1]; %5�� 
     end
end
Out = Buffer4(:,1:Num_test);  %ǰ4/5������ȫ����Ϊѵ�����ݣ�
Outc5 = Buffer4(:,(Num_test+1):Data_size); %��1/5��������Ϊ�������� �������
Outc5_all = Buffer4; %��1/5��������Ϊ��������
Outc1 = Out_org(:,(Num_test+1):Data_size); %�������ݶ�Ӧ��ʵ���������
Outc1_all= Out_org;

Trace = strcat('TrainData',num2str(k),'.mat');%����·�����ļ����õ��������ļ�·��
save(Trace,'In','Out','Inc','Inc_all','Outc5','Outc5_all','Outc1','Outc1_all'); 

end