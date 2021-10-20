%%控制性能评估函数

function [ CP_RankS,CP_RankD ] = Perfm_Assess(Wndw_Data)

%% 可以通过文件读取，但为了加快运行速度，参数全部直接赋值
global Time;
global wData_max;
global wData_min;
global Bpnet;

if Time < 2.1  %%两秒的时候才开始评估，首次评估加载数据信息
    load('data_limit.mat','Data_max','Data_min');  %%改网络的时候对应的数据约束也要改变
    wData_max = Data_max;
    wData_min = Data_min;
    load('Net_14.mat','net') ;  %%比较好的网络：01；33；34；46
    Bpnet = net; %%直接加载建好的网络
end

%% 窗口数据处理 In_Data
Org_Data = Get_Indexes(Wndw_Data);%指标量计算,返回值为1*15的向量 
Nordata = Normalize(Org_Data', wData_min, wData_max);%归一化处理

%% 网络评估结果输出
Output = sim( Bpnet,Nordata);  %测试网络

[~,CP_RankD]= max(Output);
CP_RankS = defuzzify(Output,0);%模糊逻辑输出连续化性能
% % CP_Rank = defuzzify(Output,1);%逻辑判断输出性能等级

end