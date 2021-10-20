%%滑动时间窗口数据收集
%获取窗口数据win_data
function [Wndw_Data, PA_Flag] = Window_Slid(CtrlSdt_B, CtrlSdt_P)

global Time;   %%实际仿真时间
global N; %%窗口数据的个数
global Buffer0;  %%数据缓冲区1
global Buffer1;  %%数据缓冲区1
global Buffer2;  %%数据缓冲区2
global Buffer3;  %%数据缓冲区3
global count; %%函数执行次数的计数器

%% 变量定义
if Time==0
    Buffer0 = zeros(N/3,5);
    Buffer1 = zeros(N/3,5);
    Buffer2 = zeros(N/3,5);
    Buffer3 = zeros(N/3,5);
    count = 0 ;
end

%% 先入先出的缓冲机制
%俯仰通道
Cmd_alp = CtrlSdt_B(1); Ero_pit = CtrlSdt_P(1); Ero_qw = CtrlSdt_P(4); Dlt_alp = CtrlSdt_P(10); Dlt_e = CtrlSdt_B(4);  

count = count+1; %%每次进入函数加1

Buffer0(count,1) = Cmd_alp;  Buffer0(count,2) = Ero_pit;  Buffer0(count,3) = Ero_qw;
Buffer0(count,4) = Dlt_alp;  Buffer0(count,5) = Dlt_e; 

if count == N/3  %%表明缓冲区存满数据
    count = 0;
    
    Buffer1 = Buffer2;  %%更新数据，1中存的数据最老，用2刷掉
    Buffer2 = Buffer3;  %%更新数据，2中存的数据较老，用3刷掉
    Buffer3 = Buffer0;  %%更新数据，3中存的数据为上一拍的，用当前的数据更新
       
    if Time>=1.5  %正常应从2秒开始评估调整  ，为了对比从5秒开始评估调整
        PA_Flag = 1; %%评估函数执行标志位
        Wndw_Data = [Buffer1; Buffer2; Buffer3]; %% 30*5维数据  时间是正向的
    else
        PA_Flag = 0;
        Wndw_Data = zeros(30,5);
    end
else
    PA_Flag = 0;
    Wndw_Data = zeros(30,5);
end

end