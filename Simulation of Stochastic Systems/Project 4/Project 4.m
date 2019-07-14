% DTFC MC Simulation 

P=[0 1;1 0];
% P=[0.75 0.25;0.1 0.9];
initial_state=[1 0];
for k=1:75
    temp_next_state=initial_state;
for i=1:500
    u=rand;
    if u<temp_next_state(1,1)
     path(k,i)=1;
    else
     path(k,i)=2;
    end
    temp_next_state=temp_next_state*P;
    count1=0;
    count2=0;
    n=i;
    for m=1:n
        if(path(k,m)==1)
            count1=count1+1;
        else
            count2=count2+1;
        end
    end
    time_average1(k,n)=(1/n)*count1;
    time_average2(k,n)=(1/n)*count2;
end
end


figure(1);
plot(time_average1(1,:),'b');
hold on;
plot(time_average2(1,:),'r');
legend('State1','State2');
title('Convergence of states (transition matrix) to a stationary probability density function'); 

figure(2);
a=histogram(path(:,500));
title('Ensemble average Histogram across 75 sample paths at time instance 500');

figure(3);
b=histogram(path(1,426:500));
title('Time average Histogram for a sample path');

expected_distribution=[P(2,1)/(P(1,2)+P(2,1)) P(1,2)/(P(1,2)+P(2,1))]
time_average=[time_average1(:,500) time_average2(:,500)];
for i=1:75
chi(i,1)=0;
for j=1:2
chi(i,1)=chi(i,1)+((time_average(i,j)-expected_distribution(1,j)).^2)/expected_distribution(1,j);
end
end

P=[ 0.48 0.48 0.04 ; 0.22 0.7 0.08 ;0 0 1];

initial_state=[1 0 0];
for k=1:75
    temp_next_state=initial_state;
for i=1:500
    u=rand;
    if u<temp_next_state(1,1)
     path(k,i)=1;
    elseif (u>=temp_next_state(1,1) && u<(temp_next_state(1,1)+temp_next_state(1,2)))
     path(k,i)=2;
    else
     path(k,i)=3;   
    end
    temp_next_state=temp_next_state*P;
    count1=0;
    count2=0;
    count3=0;
    n=i;
    for m=1:n
        if(path(k,m)==1)
            count1=count1+1;
        elseif(path(k,m)==2)
            count2=count2+1;
        else
            count3=count3+1;
        end
    end
    time_average1(k,n)=(1/n)*count1;
    time_average2(k,n)=(1/n)*count2;
    time_average3(k,n)=(1/n)*count3;
end
end
figure(4);
plot(time_average1(1,:),'b');
hold on;
plot(time_average2(1,:),'r');
hold on;
plot(time_average3(1,:),'g');
legend('State1','State2','State3');
title('Convergence of states (transition matrix) to a stationary probability density function');

figure(5);
c=histogram(path(:,500));
title('Ensemble average Histogram across 75 sample paths at time instance 500');

figure(6);
d=histogram(path(1,426:500));
title('Time average Histogram for a sample path');
time_average=[time_average1(:,500) time_average2(:,500) time_average3(:,500)];
