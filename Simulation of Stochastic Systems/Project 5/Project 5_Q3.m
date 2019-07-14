clear all;
close all;

% Optimal Paths

N=1000;
x=1000*rand(1,N);
y=1000*rand(1,N);


initial_temp=20;
initial_path=randperm(N); 
accept_count=0;
j=1;
path=initial_path;
T=initial_temp;
while(j<5000)   
    temp=randperm(N,2);
    ind1=find(path(j,:)==temp(1,1));
    ind2=find(path(j,:)==temp(1,2));
    swapped_path(j,:)=path(j,:);
    swapped_path(j,ind1)=temp(1,2);
    swapped_path(j,ind2)=temp(1,1);
    sum1=0;
    for i=1:N-1
    sum1=sum1+sqrt((x(1,swapped_path(j,i+1))-x(1,swapped_path(j,i))).^2+(y(1,swapped_path(j,i+1))-y(1,swapped_path(j,i))).^2);
    end
    D_new_path(1,j)=sum1;
    sum2=0;
    for i=1:N-1
    sum2=sum2+sqrt((x(1,path(j,i+1))-x(1,path(j,i))).^2+(y(1,path(j,i+1))-y(1,path(j,i))).^2);
    end
    D_old_path(1,j)=sum2;
    alpha=exp(D_old_path(1,j)-D_new_path(1,j))/T;
    u=rand;
    if ( (u<=alpha) || (D_new_path(1,j) < D_old_path(1,j)))
        sample_collection(accept_count+1,:)=swapped_path(j,:);
        accept_count=accept_count+1;
        path(j+1,:)=swapped_path(j,:);    
        cost_function(accept_count+1)=D_new_path(1,j);
    else
        path(j+1,:)=path(j,:);
    end
    j=j+1;
    T=T/(i+1);
%     T=initial_temp/(i.^(-0.5));
%     T=T*0.99;

end

figure(1);
plot(x(1,initial_path),y(1,initial_path),'-*b')
figure(2); plot(x(1,path(100,:)),y(1,path(100,:)),'-*r')
% figure(3);plot(cost_function,'*-b')

