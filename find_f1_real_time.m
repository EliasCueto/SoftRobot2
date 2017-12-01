% 
%  Soft robot - contact detection in real time
%  Jean Chenevier, june 2017
%  UniZar -  EC Nantes
%
clear
close all
clc
% This script aims to demonstrate that it's possible to get F1 in real time
% by optimization, given the value of h
%% Inputs
h=linspace(0.001,0.031,100);
Pobj=1;
F1=linspace(0,100,100); % starting points
%% Levenberg-Marquardt Algorithm (damped least-squares method)
Fsol=zeros(100,100);
time=zeros(100,100);
cpt=0;
for i=1:100
    for j=1:100
        cpt=cpt+1;
        percent=round(cpt/100,1);
        clc
        disp(['Performing simulation num',num2str(cpt),' on 10000 (',num2str(percent),'%)'])
        P=build_pressure(F1(j),h(i));
        tic
        while abs(P-Pobj)>1e-6
            dF1=Pobj-P;
            dP=build_pressure(F1(j)+0.001,h(i))-P;dP=dP/0.001;
            dF1=dF1/dP;
            F1(j)=F1(j)+dF1;
            P=build_pressure(F1(j),h(i));
        end
        time(i,j)=toc;
        Fsol(i,j)=F1(j);
    end
end
%% Statistic study on the simulation time
time=time(:);
time=1000*time;
avgtime=mean(time);
stddevtime=std(time);
figure
h=histogram(time);
title('Simulation time distribution on a sample size of 10000')
xlabel('t(ms)')
ylabel('Number of simulations')
disp(['Minimal simulation time is ',num2str(min(time)),' ms'])
disp(['Maximal simulation time is ',num2str(max(time)),' ms'])
disp(['Average simulation time is ',num2str(avgtime),' ms'])
disp(['Standard deviation on simulation time is ',num2str(stddevtime),' ms'])
%% Statistics on the truncated sample
% indices=find(time<=0.026);
% tcttime=time(indices);
% tctavgtime=mean(tcttime);
% tctstddevtime=std(tcttime);
% newsamplesize=numel(indices);
% figure
% htct=histogram(tcttime);
% title(['Simulation time distribution on a truncated sample size of ',num2str(newsamplesize)])
% xlabel('t(s)')
% ylabel('Number of simulations')
% disp(['Minimal simulation time is ',num2str(min(tcttime)),' s'])
% disp(['Maximal simulation time is ',num2str(max(tcttime)),' s'])
% disp(['Average simulation time is ',num2str(tctavgtime),' s'])
% disp(['Standard deviation on simulation time is ',num2str(tctstddevtime),' s'])