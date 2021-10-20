% load('NetWeight14-20_-1.mat'); % 'Hw','Hb','Ow','Ob'
clear all;
load('NetWeight.mat');
% load('NetWeight20-28-9898.mat');
% load('NetCau.mat'); %'Inc_org','Inc','A1','E2'
load('Inputs_N.mat');


% In0 = Inputs_N(1:157,4:23)';
% In1 = Inputs_N(158:314,4:23)';
% In2 = Inputs_N(315:471,4:23)';
% In3 = Inputs_N(472:628,4:23)';
% In4 = Inputs_N(629:785,4:23)';
% IN = In0;
% [~,m]=size(IN);
% 
% Hid= zeros(28,m);
% out= zeros(5,m);
% Res = zeros(5,m);
% for k=1:5
%     switch k
%     case 1
%        IN = In0;
%     case 2
%        IN = In1;
%     case 3
%        IN = In2;
%      case 4
%        IN = In3;  
%      case 5
%        IN = In4;
%     end
%     
%     for i=1:m
%         Hid(:,i) = tansig(Hw*IN(:,i)+Hb);   
%         out(:,i)= tansig(Ow*Hid(:,i)+Ob);   
%     end
%      [~,Res(k,:)]= max(out); %以能够识别出最大值的趋势，作为正确识别的标准
%      Trace_O1 =strcat('performance_',num2str(k),'.fig');
%     figure(k)
%     plot(64:1.5:298,Res(k,:),'r*');
%     axis([64,284,0.5,5.5]);
%     set(gca,'XTick',64:20:284);
%     grid on;
%     saveas(gcf,Trace_O1);
% end


[Hid_num,R] = size(Hw);
[S,~] = size(Ow);

fid=fopen('NetWeights.txt','wt');

fprintf(fid,'Hw=\n'); 
for i=1:1:Hid_num
    for j=1:1:R
        if j==1
            fprintf(fid,'{%.4f, ',Hw(i,j));
        elseif j==R
            fprintf(fid,'%.4f},\n',Hw(i,j));
        else
            fprintf(fid,'%.4f,\t',Hw(i,j));
        end
    end
end
fprintf(fid,'Hb=\n'); 
for i=1:1:Hid_num
    if i==1
        fprintf(fid,'{%.4f, ',Hb(i,1));
    elseif i==Hid_num
        fprintf(fid,'%.4f},\n',Hb(i,1));
    else
        fprintf(fid,'%.4f,\t',Hb(i,1));
    end
end
fprintf(fid,'Ow=\n'); 
for i=1:1:S
    for j=1:1:Hid_num
        if j==1
            fprintf(fid,'{%.4f, ',Ow(i,j));
        elseif j==Hid_num
            fprintf(fid,'%.4f},\n',Ow(i,j));
        else
            fprintf(fid,'%.4f,\t',Ow(i,j));
        end
    end
end
fprintf(fid,'Hb=\n'); 
for i=1:1:S
    if i==1
        fprintf(fid,'{%.4f, ',Ob(i,1));
    elseif i==S
        fprintf(fid,'%.4f},\n',Ob(i,1));
    else
        fprintf(fid,'%.4f,\t',Ob(i,1));
    end
end

fprintf(fid,'end\n');
fclose(fid);


[p,q] = size(Inc);

% fid=fopen('NetCau.txt','wt');
% 
% fprintf(fid,'Inc=\n'); 
% for i=1:1:20
%     for j=1:1:p
%         if j==1
%             fprintf(fid,'{%.4f, ',Inc(j,i));
%         elseif j==R
%             fprintf(fid,'%.4f},\n',Inc(j,i));
%         else
%             fprintf(fid,'%.4f,\t',Inc(j,i));
%         end
%     end
% end
% fprintf(fid,'end\n');
% fclose(fid);
