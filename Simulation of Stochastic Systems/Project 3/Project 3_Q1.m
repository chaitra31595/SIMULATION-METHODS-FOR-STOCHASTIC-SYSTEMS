clear all;

% Area - Estimation (i),(ii),(iii)
N=500;
 for j=1:50
x=rand(1,N);
y=rand(1,N);
count=0;
% ind=zeros(1,N);
for i=1:N
    a=x(1,i);
    b=y(1,i);
   if((((x(1,i)^2)+(y(1,i)^2))<=1)&& ((((x(1,i)-1)^2)+((y(1,i)-1)^2))<=1))
      D(1,i)=1;
      ind(1,count+1)=i;
      count=count+1;
   end
end
h(1,j)=count/N;
end
figure(1);
plot(x(1,:),y(1,:),'*r');
hold on;
plot(x(1,ind(1:count)),y(1,ind(1:count)),'*b');
title('Area Estimation');

figure(2);
hist(h);
k=50;
var=(1/k)*sum((h-mean(h)).^2);

% Area - Estimation (iv)
l=1;
for n=500:100:15000
for j=1:50
x=rand(1,n);
y=rand(1,n);
count=0;
% ind=zeros(1,N);
for i=1:n
    a=x(1,i);
    b=y(1,i);
   if((((x(1,i)^2)+(y(1,i)^2))<=1)&& ((((x(1,i)-1)^2)+((y(1,i)-1)^2))<=1))
      D(1,i)=1;
      ind(1,count+1)=i;
      count=count+1;
   else
      D(1,i)=0;
   end
end
h(1,j)=count/n;
end
temp(1,l)=mean(h);
k=50;
var(1,l)=(1/k)*sum((h-mean(h)).^2);
l=l+1;
end

figure(3);
stem(500:100:15000,var,'*r');

