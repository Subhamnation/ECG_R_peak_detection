clc;
clear all;
close all;


%%%%%%%%%%%%_______EXTRACTION OF ECG SIGNAL FROM DATABASE________%%%%%%%%

x1=load('E:\Essential_documents_projects\resume_projects\projects\ECG_Project[1]\matlab_codes\R-peak detection\100m.mat');
z1=x1.val';
z2=z1-0;
z3=z2/200;
z4=z3(:,1);
z=z4(1:3700);


%%%%%%%%%%%%%%%%%%______________1st block_____________%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%_____________pre-processing____________%%%%%%%%%%%%

 n=360;
 wl=5;
 wh=20;
 w1=wl/n;
 w2=wh/n;
 w=[w1 w2];   %filter window in one vector
 ripple=0.0001;
 [b a]=cheby1(4,ripple,w,'bandpass');
 y=filtfilt(b,a,z);    %zero phase digital filtering

 figure;
plot(z);
title('ECG SIGNAL');

figure;
plot(y);
title('ECG SIGNAL after filtering');

%%%%1st order differentiation%%%%%%%
s1=diff(y);
figure;
plot(s1,'g');
title('ECG after 1st order diff');


%%%%%%normalisation%%%%%%
ns=s1/max(abs(s1));
figure;
plot(ns,'r');     %%%need of doing it%%%%
title('normed value after 1st stage');





%%%%%%%%%%%%%%%%%%_________2nd block____________%%%%%%%%%%%%%%%%%%%%%

%%%%_________shanon energy envelope extraction__________%%%%

v=length(z);
for i=1:1:v-1
    se(i)=-((ns(i)^2)*log(ns(i)^2));
end

figure;
plot(se,'y');
title('ECG after shannon energy envelope');

%%%%%%%%___zero phase filtering___%%%%%%%

ma1=(1/65)*ones(65,1);
oma1=filtfilt(ma1,1,se);
figure;
plot(oma1);
title('ECG after moving average 1 filter');





%%%%%%%%%%%%______________3rd block______________%%%%%%%%%%%%

%%%%%%_______peak estimation logic_____%%%%%

s2=diff(oma1);
figure;
plot(s2);
title('ECG after differentiating');

%%%%%%squaring%%%%%
osqr=s2.^2;
figure;
plot(osqr);
title('after squareing');

%%%%%%%%%%moving avg 2nd time %%%%%%% 
q=(1/85)*ones(85,1);
ma2=filtfilt(q,1,osqr);
figure;
plot(ma2);
title('true R peaks or output of moving average 2 filter');
figure;
plot(ma2);
title('true R peaks or output of moving average 2 filter');
findpeaks(ma2);


%%%%%%%%%%%%%%%%%%%%_________4th block_________%%%%%%%%%%%%%%%%%%%

%%%%%%%%_________ True Rpeak detection__________%%%%%%%%


[pks, locs]= findpeaks(ma2);
u=length(locs);
disp(locs);

%%%%%%___________________Find the true R peak by searching in 25 samples from detected point______________%%%%%
        
for v=1:1:u
    j=1;
    for i=(locs(v)-25):1:(locs(v)+25)
        t(j)=z(i);
        j=j+1;
    end

[mag pos]=max(t);


o(v)=(pos-1)+locs(v)-25;
end
disp('final true position of Rpeak')
disp(o);


%ECG Rpeak location print                                         
g=1:length(z);
figure;
plot(z);
hold on;
stem(g(o),z(o),'r');


















