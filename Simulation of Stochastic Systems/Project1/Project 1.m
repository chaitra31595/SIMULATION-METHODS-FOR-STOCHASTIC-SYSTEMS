clear all;
close all;

% A Few Coins - Question 1

for i=1:100
   p=rand;
   if(p<0.5)
       X1(1,i)=0;
   else
       X1(1,i)=1;
   end
end
figure(1)
h=histogram(X1);
title(' Histogram for 100 simulated Bernoulli trials ');
ylabel('Frequency');
xlabel('Number of Heads');

for i=1:100
    count=0;
    for j=1:7
      p=rand;
      if(p<0.5)
       X2(1,j)=0;
      else
       X2(1,j)=1;
       count=count+1;
      end
    end
    success_count1(1,i)=count;
end
figure(2)
h=histogram(success_count1);
title(' Histogram for 100 samples of success counting random variable ');
ylabel('Frequency');
xlabel('Number of Heads');

count=0;
m=1;
for i=1:100
   p=rand;
   if(p<0.5)
       X3(1,i)=0;
       if(count~=0)
       m=m+1;
       end
       count=0;
   else
       X3(1,i)=1;
       count=count+1;
       longest_run_count(1,m)=count;      
   end
end
figure(3)
h=histogram(longest_run_count);
title(' Histogram for count of longest run of heads in 100 Bernoulli samples ');
ylabel('Count of Longest run of heads ');
xlabel('Number of Heads');

% Counting Successes - Question 2

for i=1:300
    count=0;
    for j=1:5
      p=rand;
      if(p<0.5)
       X4(1,j)=0;
      else
       X4(1,j)=1;
       count=count+1;
      end
    end
    success_count2(1,i)=count;
end
figure(4)
h=histogram(success_count2);
title('Histogram for 300 samples of success counting random variable (Binomial) : n=5 ');
ylabel('Frequency');
xlabel('Number of Heads');

for i=1:300
    count=0;
    for j=1:10
      p=rand;
      if(p<0.5)
       X5(1,j)=0;
      else
       X5(1,j)=1;
       count=count+1;
      end
    end
    success_count3(1,i)=count;
end
figure(5)
h=histogram(success_count3);
title('Histogram for 300 samples of success counting random variable (Binomial) : n=10 ');
ylabel('Frequency');
xlabel('Number of Heads');

for i=1:300
    count=0;
    for j=1:30
      p=rand;
      if(p<0.5)
       X6(1,j)=0;
      else
       X6(1,j)=1;
       count=count+1;
      end
    end
    success_count4(1,i)=count;
end
figure(6)
h=histogram(success_count4);
title('Histogram for 300 samples of success counting random variable (Binomial) : n=30');
ylabel('Frequency');
xlabel('Number of Heads');

for i=1:300
    count=0;
    for j=1:50
      p=rand;
      if(p<0.5)
       X7(1,j)=0;
      else
       X7(1,j)=1;
       count=count+1;
      end
    end
    success_count5(1,i)=count;
end
figure(7)
h=histogram(success_count5);
title('Histogram for 300 samples of success counting random variable (Binomial) : n=50');
ylabel('Frequency');
xlabel('Number of Heads');


% Continuous Distributions - Question 3

X=zeros(1,1000);
Y=zeros(1,1000);
for i=1:1000
    u=rand;
    X(i)=-5*log(1-u);
    Y(i)=2*tan(pi*(u-0.5));  
end
figure(8);
h=histogram(X);
title(' Histogram of X~exp(5) samples');
ylabel('Frequency');
xlabel('x');

figure(9);
h=histogram(Y);
title(' Histogram of Y~Cauchy(0,2) samples ');
ylabel('Frequency');
xlabel('y');
