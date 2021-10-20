%%����������������

function [ CP_RankS,CP_RankD ] = Perfm_Assess(Wndw_Data)

%% ����ͨ���ļ���ȡ����Ϊ�˼ӿ������ٶȣ�����ȫ��ֱ�Ӹ�ֵ
global Time;
global wData_max;
global wData_min;
global Bpnet;

if Time < 2.1  %%�����ʱ��ſ�ʼ�������״���������������Ϣ
    load('data_limit.mat','Data_max','Data_min');  %%�������ʱ���Ӧ������Լ��ҲҪ�ı�
    wData_max = Data_max;
    wData_min = Data_min;
    load('Net_14.mat','net') ;  %%�ȽϺõ����磺01��33��34��46
    Bpnet = net; %%ֱ�Ӽ��ؽ��õ�����
end

%% �������ݴ��� In_Data
Org_Data = Get_Indexes(Wndw_Data);%ָ��������,����ֵΪ1*15������ 
Nordata = Normalize(Org_Data', wData_min, wData_max);%��һ������

%% ��������������
Output = sim( Bpnet,Nordata);  %��������

[~,CP_RankD]= max(Output);
CP_RankS = defuzzify(Output,0);%ģ���߼��������������
% % CP_Rank = defuzzify(Output,1);%�߼��ж�������ܵȼ�

end