% Monte Carlo Integration and Variance Reduction Strategies

%function plot
n=1;
for x=0.8:0.0022:3
    f1(1,n)=1/(1+sinh(2*x)*log(x));
    f2(1,n)=5*(1/(0.7*sqrt(2*pi)))*exp(-((x-0.5).^2)/(2*(0.7.^2)));
    n=n+1;
end
figure(1);
plot(0.8:0.0022:3,f1,'r');
title('f(x) = 1/(1+sinh(2*x)*ln(x)) ')
m=1;
n=1;
for x=-pi:pi/18:pi
    n=1;
    for y=-pi:pi/18:pi
      f3(m,n)=exp(-(x.^4)-(y.^4));
      n=n+1;
    end
    m=m+1;
end
[X,Y]=meshgrid(-pi:pi/18:pi,-pi:pi/18:pi);
figure(2);
surf(X,Y,f3);
title('f(x,y) = exp( - x^4 - y^4 )') 
% 
m=1;
n=1;
for x=-5:0.1:5
    n=1;
    for y=-5:0.1:5
      f4(m,n)=20+(x.^2)+(y.^2)-10*(cos(2*pi*x)+cos(2*pi*y));
      n=n+1;
    end
    m=m+1;
end
[X,Y]=meshgrid(-5:0.1:5,-5:0.1:5);
figure(3);
surf(X,Y,f4);
title('f(x,y) = 20+ x^2 + y^2 -10*(cos(2*pi*x)+cos(2*pi*y))'); 


%integrall 

%without stratification and importance sampling

for j=1:50
N=1000;
x1=0.8.*ones(1,N)+(3-0.8).*rand(1,N);

x2=(-pi).*ones(1,N)+(2*pi).*rand(1,N);
y2=(-pi).*ones(1,N)+(2*pi).*rand(1,N);

x3=(-5).*ones(1,N)+(10).*rand(1,N);
y3=(-5).*ones(1,N)+(10).*rand(1,N);

integral1=0;
integral2=0;
integral3=0;
for i=1:N
   integral1=integral1+(1/(1+sinh(2*x1(1,i))*log(x1(1,i))));
   integral2=integral2+exp(-(x2(1,i).^4)-(y2(1,i).^4));
   integral3=integral3+(20+(x3(1,i).^2)+(y3(1,i).^2)-10*(cos(2*pi*x3(1,i))+cos(2*pi*y3(1,i))));
end
h1(1,j)=((3-0.8)*integral1)/N;
h2(1,j)=((2*pi)*(2*pi)*integral2)/N;
h3(1,j)=(10*10*integral3)/N;
end
figure(4);
hist(h1);

figure(5);
hist(h2);

figure(6);
hist(h3);

estimate1=mean(h1)
estimate2=mean(h2)
estimate3=mean(h3)

k=50;
var1=(1/k)*sum((h1-mean(h1)).^2)
var2=(1/k)*sum((h2-mean(h2)).^2)
var3=(1/k)*sum((h3-mean(h3)).^2)

%function1

%using stratification

for j=1:50
N=1000;
n1=500;
x1(1,1:n1)=0.8.*ones(1,n1)+(1.2-0.8).*rand(1,n1);
n2=350;
x1(1,n1+1:n1+n2)=1.2.*ones(1,n2)+(2.5-1.2).*rand(1,n2);
n3=150;
x1(1,n1+n2+1:n1+n2+n3)=2.5.*ones(1,n3)+(3-2.5).*rand(1,n3);
integral1=0;
integral2=0;
integral3=0;
for i=1:N
    if(i<=n1)
     integral1=integral1+(1/(1+sinh(2*x1(1,i))*log(x1(1,i))));
    elseif(i>n1 && i<=(n1+n2))
     integral2=integral2+(1/(1+sinh(2*x1(1,i))*log(x1(1,i))));
    else
     integral3=integral3+(1/(1+sinh(2*x1(1,i))*log(x1(1,i))));
    end
end
h1(1,j)=((1.2-0.8)*(integral1/n1)+(2.5-1.2)*(integral2/n2)+(3-2.5)*(integral3/n3));
end
figure(7);
hist(h1);

estimate1=mean(h1)

k=50;
var1=(1/k)*sum((h1-mean(h1)).^2)


%using importance sampling - function 1
 
for j=1:50
N=1000;
integral1=0;
count=0;
while(count<1000)
    b=random('Normal',0.5,0.8);
    if(b>=0.8 && b<=3)
       x1(1,count+1)=b;   %a(1,i);       
       integral1=integral1+((1/(1+sinh(2*x1(1,count+1))*log(x1(1,count+1))))/(6.3*(1/(0.8*sqrt(2*pi)))*exp(-((x1(1,count+1)-0.5).^2)/(2*((0.8).^2)))));   
       count=count+1;
    end
end
 h1(1,j)=(3-0.8)*(integral1/(count-1));
end
figure(8);
hist(h1);

estimate1=mean(h1)

k=50;
var1=(1/k)*sum((h1-mean(h1)).^2)


% function 2

%stratification

for j=1:50
N=1000;
n1=800;
x(1,1:n1)=-1.*ones(1,n1)+(2).*rand(1,n1);
y(1,1:n1)=-1.*ones(1,n1)+(2).*rand(1,n1);

n2=50;
x(1,n1+1:n1+n2)=-pi.*ones(1,n2)+(2*pi).*rand(1,n2);
y(1,n1+1:n1+n2)=pi.*ones(1,n2)+(1-pi).*rand(1,n2);

n3=50;
x(1,n1+n2+1:n1+n2+n3)=-pi.*ones(1,n3)+(2*pi).*rand(1,n3);
y(1,n1+n2+1:n1+n2+n3)=-pi.*ones(1,n3)+(-1+pi).*rand(1,n3);

n4=50;
x(1,n1+n2+n3+1:n1+n2+n3+n4)=pi.*ones(1,n4)+(1-pi).*rand(1,n4);
y(1,n1+n2+n3+1:n1+n2+n3+n4)=-1.*ones(1,n4)+(2).*rand(1,n4);

n5=50;
x(1,n1+n2+n3+n4+1:n1+n2+n3+n4+n5)=-pi.*ones(1,n5)+(-1+pi).*rand(1,n5);
y(1,n1+n2+n3+n4+1:n1+n2+n3+n4+n5)=-1.*ones(1,n5)+(2).*rand(1,n5);
integral1=0;
integral2=0;
integral3=0;
integral4=0;
integral5=0;
for i=1:N
    if(i<=n1)
     integral1=integral1+exp(-(x(1,i).^4)-(y(1,i).^4));
    elseif(i>n1 && i<=(n1+n2))
     integral2=integral2+exp(-(x(1,i).^4)-(y(1,i).^4));
    elseif(i>(n1+n2) && i<=(n1+n2+n3))
     integral3=integral3+exp(-(x(1,i).^4)-(y(1,i).^4));
    elseif(i>(n1+n2+n3) && i<=(n1+n2+n3+n4))
     integral4=integral4+exp(-(x(1,i).^4)-(y(1,i).^4));
    else
     integral5=integral5+exp(-(x(1,i).^4)-(y(1,i).^4));
    end
end
h1(1,j)=(4)*(integral1/n1)+(12)*(integral2/n2)+(12)*(integral3/n3)+(4)*(integral4/n4)+(4)*(integral5/n5);
end
figure(9);
hist(h1);

estimate1=mean(h1)

k=50;
var1=(1/k)*sum((h1-mean(h1)).^2)

%function 2

% importance sampling

for j=1:50
N=1000;
integral1=0;
count=0;
while(count<1000)
    b=random('Normal',0,0.7);
    c=random('Normal',0,0.7);
    if(b>=-pi && b<=pi && c>=-pi && c<=pi)
       x1(1,count+1)=b;   %a(1,i);
       y1(1,count+1)=c;
       integral1=integral1+((exp(-(x1(1,count+1).^4)-(y1(1,count+1).^4)))/(24.25*(1/(0.7*0.7*(2*pi)))*exp(-((x1(1,count+1)).^2 - ((y1(1,count+1)).^2))/(2*((0.7).^2)))));   
       count=count+1;
    end
end
 h1(1,j)=(2*pi*2*pi)*(integral1/(count-1));
end
figure(10);
hist(h1);

estimate1=mean(h1)

k=50;
var1=(1/k)*sum((h1-mean(h1)).^2)

%function3

%stratification

for j=1:50
% N=1000;
n1=1000;
x(1,1:n1)=-2.*ones(1,n1)+(4).*rand(1,n1);
y(1,1:n1)=-2.*ones(1,n1)+(4).*rand(1,n1);

n2=3000;
x(1,n1+1:n1+n2)=-5.*ones(1,n2)+(2*5).*rand(1,n2);
y(1,n1+1:n1+n2)=5.*ones(1,n2)+(2-5).*rand(1,n2);

n3=3000;
x(1,n1+n2+1:n1+n2+n3)=-5.*ones(1,n3)+(2*5).*rand(1,n3);
y(1,n1+n2+1:n1+n2+n3)=-5.*ones(1,n3)+(-2+5).*rand(1,n3);

n4=1000;
x(1,n1+n2+n3+1:n1+n2+n3+n4)=5.*ones(1,n4)+(2-5).*rand(1,n4);
y(1,n1+n2+n3+1:n1+n2+n3+n4)=-2.*ones(1,n4)+(4).*rand(1,n4);

n5=1000;
x(1,n1+n2+n3+n4+1:n1+n2+n3+n4+n5)=-5.*ones(1,n5)+(-2+5).*rand(1,n5);
y(1,n1+n2+n3+n4+1:n1+n2+n3+n4+n5)=-2.*ones(1,n5)+(4).*rand(1,n5);
integral1=0;
integral2=0;
integral3=0;
integral4=0;
integral5=0;
for i=1:n1+n2+n3+n4+n5
    if(i<=n1)
     integral1=integral1+(20+(x(1,i).^2)+(y(1,i).^2)-10*(cos(2*pi*x(1,i))+cos(2*pi*y(1,i))));
    elseif(i>n1 && i<=(n1+n2))
     integral2=integral2+(20+(x(1,i).^2)+(y(1,i).^2)-10*(cos(2*pi*x(1,i))+cos(2*pi*y(1,i))));
    elseif(i>(n1+n2) && i<=(n1+n2+n3))
     integral3=integral3+(20+(x(1,i).^2)+(y(1,i).^2)-10*(cos(2*pi*x(1,i))+cos(2*pi*y(1,i))));
    elseif(i>(n1+n2+n3) && i<=(n1+n2+n3+n4))
     integral4=integral4+(20+(x(1,i).^2)+(y(1,i).^2)-10*(cos(2*pi*x(1,i))+cos(2*pi*y(1,i))));
    else
     integral5=integral5+(20+(x(1,i).^2)+(y(1,i).^2)-10*(cos(2*pi*x(1,i))+cos(2*pi*y(1,i))));
    end
end
h1(1,j)=(16)*(integral1/n1)+(30)*(integral2/n2)+(30)*(integral3/n3)+(9)*(integral4/n4)+(9)*(integral5/n5);
end
figure(11);
hist(h1);

estimate1=mean(h1)

k=50;
var1=(1/k)*sum((h1-mean(h1)).^2)



