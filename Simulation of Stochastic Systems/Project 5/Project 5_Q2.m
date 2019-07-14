clear all;
close all;

% MCMC for Optimization

n=2;
for i=-500:500
    for j=-500:500
        x(1,1)=i;
        x(1,2)=j;
        function_x(i+501,j+501)=418.9829*n- ((x(1,1)*sin(sqrt(abs(x(1,1)))))+(x(1,2)*sin(sqrt(abs(x(1,2))))));
    end
end
X=-500:500;
Y=-500:500;
figure(1);
surfc(X,Y,function_x);
figure(4);
contour(X,Y,function_x);


accept_count=0;
x(1,1)=0;
x(1,2)=0;
k=1;
sigma=200;
i=1;
original_T=20;
T=original_T;
while(i<100)
    proposed_pdf(i,:)=normrnd(x(i,:),sigma,[1,2]);
    g_y=(418.9829*n -((proposed_pdf(i,1)*sin(sqrt(abs(proposed_pdf(i,1)))))+(proposed_pdf(i,2)*sin(sqrt(abs(proposed_pdf(i,2)))))));
    g_x=(418.9829*n- ((x(1,1)*sin(sqrt(abs(x(1,1)))))+(x(1,2)*sin(sqrt(abs(x(1,2)))))));
    if(500>=proposed_pdf(i,1) && proposed_pdf(i,1)>=-500 && -500<=proposed_pdf(i,2) && proposed_pdf(i,2)<=500)
        alpha=min(1,exp(-(g_y-g_x)/T));
        u=rand;
        if ( u<=alpha )
            sample_collection(accept_count+1,:)=proposed_pdf(i,:);
            accept_count=accept_count+1;
            x(i+1,:)=proposed_pdf(i,:);
        else
            x(i+1,:)=x(i,:);
        end
        i=i+1;
        a=rand;
%         T=original_T/log(i+1); % logarithm
%         T=original_T/exp(-(i+1)); %exponential 
        T=original_T/((i+1).^(a)); %polynomial
    end
end


figure(2);

hist3(sample_collection);


X=-500:500;
Y=-500:500;
figure(5);
contour(X,Y,function_x);
hold on;
plot(sample_collection(:,1),sample_collection(:,2),'-*r');


% 
% compPlot = figure('Name', 'Comparison of Stuff');
% ax1 = axes('Parent', compPlot);
% hold(ax1, 'on');
% plot(ax1, a, 'Color', 'blue');
% plot(ax1, b, 'Color', 'red');
% title(ax1, 'Figure 3: Plot of Stuff');
% legend('Thing 1','Thing 2');
% hold(ax1, 'off');