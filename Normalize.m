%%��һ����������ԭ���ݰ��ո��������ݷ�Χ��һ������-1,1������
%����ʹ���������㣬Orgdata��һ����������������ά��ͬData_min
function Newdata = Normalize(Orgdata, Data_min, Data_max)

down = -1;%��һ�����½�
up = 1; %��һ�����Ͻ�
%% ��֤���ݵķ�Χ
m = length(Orgdata);  
for i=1:m
   if Orgdata(i) > Data_max(i)      
       Orgdata(i) = Data_max(i);
   elseif Orgdata(i) < Data_min(i) 
       Orgdata(i) = Data_min(i) ;
   end
end

%% ����ӳ���ϵ
k = (up - down)./(Data_max - Data_min);
Newdata = down + k.*(Orgdata - Data_min);

end