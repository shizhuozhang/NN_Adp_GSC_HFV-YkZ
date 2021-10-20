%%归一化函数，将原数据按照给定的数据范围归一化到【-1,1】区间
%可以使用向量运算，Orgdata是一个数据样本向量，维数同Data_min
function Newdata = Normalize(Orgdata, Data_min, Data_max)

down = -1;%归一化的下界
up = 1; %归一化的上界
%计算映射系数k
k = (up - down)./(Data_max - Data_min);
Newdata = down + k.*(Orgdata - Data_min);

end