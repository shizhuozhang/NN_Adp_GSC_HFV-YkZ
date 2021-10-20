function [out]=defuzzify(In, flag)

[~,m] = size(In);%�ж�������
buf = (In+1)./2;%��[-1,1]ӳ�䵽[0,1]
BL_sum = buf(1,:) + buf(2,:) + buf(3,:) + buf(4,:) + buf(5,:);
xx = 1.*buf(1,:) + 2.*buf(2,:) + 3.*buf(3,:) + 4.*buf(4,:) + 5.*buf(5,:);
out = xx./BL_sum;
%% �Ƿ�Ҫ���ֵȼ�
if flag == 1
    for i=1:1:m   
        if out(i) > 4.5
           out(i) = 5;
        elseif out(i)>3.8
            out(i) =4;
        elseif out(i)>2.8
            out(i) =3;
        elseif out(i)>1.8
            out(i) =2;
        else
            out(i) =1;
        end
    end
end
end