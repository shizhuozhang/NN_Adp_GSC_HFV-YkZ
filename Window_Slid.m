%%����ʱ�䴰�������ռ�
%��ȡ��������win_data
function [Wndw_Data, PA_Flag] = Window_Slid(CtrlSdt_B, CtrlSdt_P)

global Time;   %%ʵ�ʷ���ʱ��
global N; %%�������ݵĸ���
global Buffer0;  %%���ݻ�����1
global Buffer1;  %%���ݻ�����1
global Buffer2;  %%���ݻ�����2
global Buffer3;  %%���ݻ�����3
global count; %%����ִ�д����ļ�����

%% ��������
if Time==0
    Buffer0 = zeros(N/3,5);
    Buffer1 = zeros(N/3,5);
    Buffer2 = zeros(N/3,5);
    Buffer3 = zeros(N/3,5);
    count = 0 ;
end

%% �����ȳ��Ļ������
%����ͨ��
Cmd_alp = CtrlSdt_B(1); Ero_pit = CtrlSdt_P(1); Ero_qw = CtrlSdt_P(4); Dlt_alp = CtrlSdt_P(10); Dlt_e = CtrlSdt_B(4);  

count = count+1; %%ÿ�ν��뺯����1

Buffer0(count,1) = Cmd_alp;  Buffer0(count,2) = Ero_pit;  Buffer0(count,3) = Ero_qw;
Buffer0(count,4) = Dlt_alp;  Buffer0(count,5) = Dlt_e; 

if count == N/3  %%������������������
    count = 0;
    
    Buffer1 = Buffer2;  %%�������ݣ�1�д���������ϣ���2ˢ��
    Buffer2 = Buffer3;  %%�������ݣ�2�д�����ݽ��ϣ���3ˢ��
    Buffer3 = Buffer0;  %%�������ݣ�3�д������Ϊ��һ�ĵģ��õ�ǰ�����ݸ���
       
    if Time>=1.5  %����Ӧ��2�뿪ʼ��������  ��Ϊ�˶Աȴ�5�뿪ʼ��������
        PA_Flag = 1; %%��������ִ�б�־λ
        Wndw_Data = [Buffer1; Buffer2; Buffer3]; %% 30*5ά����  ʱ���������
    else
        PA_Flag = 0;
        Wndw_Data = zeros(30,5);
    end
else
    PA_Flag = 0;
    Wndw_Data = zeros(30,5);
end

end