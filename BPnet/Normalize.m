%%��һ����������ԭ���ݰ��ո��������ݷ�Χ��һ������-1,1������
%����ʹ���������㣬Orgdata��һ����������������ά��ͬData_min
function Newdata = Normalize(Orgdata, Data_min, Data_max)

down = -1;%��һ�����½�
up = 1; %��һ�����Ͻ�
%����ӳ��ϵ��k
k = (up - down)./(Data_max - Data_min);
Newdata = down + k.*(Orgdata - Data_min);

end