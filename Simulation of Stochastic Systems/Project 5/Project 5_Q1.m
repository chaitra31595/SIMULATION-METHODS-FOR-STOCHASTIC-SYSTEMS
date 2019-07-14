
% MCMC for Sampling 

i=1;
for x=0:0.01:1
p(i)=0.6*betapdf(x,1,8)+0.4*betapdf(x,9,1);
i=i+1;
end
figure(1)
plot(0:0.01:1,p);

%samples=p(rand(1,100));
accept_count=0;
x(1,1)=rand;
k=1;
sigma=0.1;
i=1;
while(accept_count<5000)
    ab=rand;
%     proposed_pdf(i)=normrnd(x(1,i),sigma); %Normal
    proposed_pdf(i)=x(1,i)+tan(pi*(ab-0.5)); %Cauchy
    alpha=min(1,((0.6*betapdf(proposed_pdf(i),1,8)+0.4*betapdf(proposed_pdf(i),9,1))/(0.6*betapdf(x(1,i),1,8)+0.4*betapdf(x(1,i),9,1))));
    u=rand;
    if u<=alpha
        sample_collection(accept_count+1)=proposed_pdf(i);
        accept_count=accept_count+1;
        x(1,i+1)=proposed_pdf(i);
    else
        x(1,i+1)=x(1,i);
    end
    i=i+1;
end
figure(2);
histogram(sample_collection);
title('Histogram of samples : Proposed pdf: Normal with sigma = 0.1');
figure(3);
plot(sample_collection);
title('Sample Path for initial point 0.77863');



