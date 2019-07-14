clear all;
close all;

% Double Rejection - Question 1

accepted_sample=0;
rejection=1;
sample=1;
while(accepted_sample<1000)
    r=6*rand;     % Generating V~g(x) ~ U([0 6])
    u=1.5*rand;   % Generating U ~ U([0 max(c*g(x))])
    if(0<r && r<=1)      % Calculating f(V) 
       f=0.5*betapdf(r,8,5); 
    elseif(4<r && r<=5)
        f=0.5*(r-4);
    elseif(5<r && r<=6)
        f=-0.5*(r-6);
    else
        f=0;
    end
    if u<=f         % Condition for accepting a sample
        x(accepted_sample+1)=r;
        y(accepted_sample+1)=f;
        accepted_sample=accepted_sample+1;
    else
        rejection=rejection+1;  %Rejection count
    end
    sample=sample+1;   % Total sample count
end
figure(2);
histogram(x);
title('Histogram of random variable X'); 
xlabel('X ~ Random Variable ');
ylabel('Frequency');
Rejection_rate = rejection/sample


% Independence [Internally and Externally]  - Question 2

Yk=zeros(1,1000);
Yk(1,1:995)=y(1,6:1000);
C=cov(y,Yk);
covriance=C(1,2)

 % Contingency Table
X=betarnd(8,5,1,1000); 
Y=betarnd(4,7,1,1000);  
table=zeros(3,3);
for i=1:1000               % Creation of contingency table
   if(min(X)<=X(i) && X(i)<=mean([min(X) mean(X)]))
       if(min(Y)<=Y(i) && Y(i)<=mean([min(Y) mean(Y)]))
       table(1,1)=table(1,1)+1;
       elseif(mean([max(Y) mean(Y)])<=Y(i) && Y(i)<=max(Y))
        table(1,3)=table(1,3)+1;
       else
        table(1,2)=table(1,2)+1;
       end
   elseif(mean([max(X) mean(X)])<=X(i) && X(i)<=max(X))
       if(min(Y)<=Y(i) && Y(i)<=mean([min(Y) mean(Y)]))
       table(3,1)=table(3,1)+1;
       elseif(mean([max(Y) mean(Y)])<=Y(i) && Y(i)<=max(Y))
        table(3,3)=table(3,3)+1;
       else
        table(3,2)=table(3,2)+1;
       end
   else
       if(min(Y)<=Y(i) && Y(i)<=mean([min(Y) mean(Y)]))
       table(2,1)=table(2,1)+1;
       elseif(mean([max(Y) mean(Y)])<=Y(i) && Y(i)<=max(Y))
        table(2,3)=table(2,3)+1;
       else
        table(2,2)=table(2,2)+1;
       end
   end  
end

partial_sum_y(1,1)=sum(table(1,:));
partial_sum_y(2,1)=sum(table(2,:));
partial_sum_y(3,1)=sum(table(3,:))
partial_sum_x(1,1)=sum(table(:,1));
partial_sum_x(2,1)=sum(table(:,2));
partial_sum_x(3,1)=sum(table(:,3))

n=1000;
chi=0;
% Calculation of chi-square value
for i=1:3
    for j=1:3
        e=((partial_sum_y(i,1)*partial_sum_x(j,1))/n);
        chi=chi+((table(i,j)-e).^2)/e;
    end
end
