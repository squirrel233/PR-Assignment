%--------------------------------------------------------------------------
% 16/11/4
% Batch Perception to classify given data (ʹ���ɳ��б�׼��)
% Input: 
%       class1: the data of class 1
%       class2: the data of class 2
%       eta   : the step of iteration
%       b     : margin
% Output:
%       w     : final weight vector
%       cnt   : times of iteration
%--------------------------------------------------------------------------

function [ w,cnt ] = BatchRelaxation( eta,b,class1,class2 )

    if size(class1,1)~=size(class2,1)
        disp('BatchRelaxation����������������');
        return;
    end
    class2 = -class2;  %�淶����������
    w = zeros(size(class1,1),1); %��ʼ��Ȩ����w
    w(1)=1;
    cnt = 0;
    
    while (1)
      update=zeros(size(class1,1),1);
      criterionFunc((cnt+1))=0;
      for i=1:size(class1,2)
        if w'*class1(:,i)<=b
            update = update + eta*((w'*class1(:,i)-b)/((norm(class1(:,i)))^2))*class1(:,i);
            criterionFunc((cnt+1))=criterionFunc((cnt+1))+0.5*((w'*class2(:,i)-b)^2)/((norm(class2(:,i)))^2);
        end
      end
      for i=1:size(class2,2)
        if w'*class2(:,i)<=b
            update = update + eta*( (w'*class2(:,i)-b)/((norm(class2(:,i)))^2) )*class2(:,i);
            criterionFunc((cnt+1))=criterionFunc((cnt+1))+0.5*((w'*class2(:,i)-b)^2)/((norm(class2(:,i)))^2);
        end
      end
      w = w-update;       %����w
      cnt = cnt+1;
      axisX=1:1:cnt;
      plot(axisX,criterionFunc);hold on
     % if abs(sum(update))<=eps  %��Ϊ�����д���/����
     if cnt==1000
          break;
     end

    end
   
end
