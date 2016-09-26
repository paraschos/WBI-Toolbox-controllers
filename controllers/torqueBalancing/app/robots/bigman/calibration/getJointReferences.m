% getJointReferences is used to elaborate the joints positions during the
%                    YOGA++ demo, and to generate the joint references for
%                    robot Walkman.
%                    
%   To get the new references, just run the script. Make sure that the file
%   "jointPositions.mat" exists and/or is in your PATH. If mode DEBUGMODE is
%   activated, the script will provide useful plots that help to understand
%   what the robot will do in each state
%
% Author : Gabriele Nava (gabriele.nava@iit.it)
% Genova, May 2016
%

%% Initialize the script
clear 
close all
clc
% activate the debug mode if you want to debug the joint references you
% defined with this script.
DEBUGMODE = true;
load('JointPositions.mat')

% list of variables
time          = qj_and_v.time;
state         = qj_and_v.signals(6).values;

torso         = qj_and_v.signals(1).values;
leftArm       = qj_and_v.signals(2).values;
rightArm      = qj_and_v.signals(3).values;
leftLeg       = qj_and_v.signals(4).values;
rightLeg      = qj_and_v.signals(5).values;

torsoDes      = qjDes_and_v.signals(1).values;
leftArmDes    = qjDes_and_v.signals(2).values;
rightArmDes   = qjDes_and_v.signals(3).values;
leftLegDes    = qjDes_and_v.signals(4).values;
rightLegDes   = qjDes_and_v.signals(5).values;

%% Separate the different states
storeStateIndex  = 1;
numOfStates      = 1;

for k  = 1:length(state)

    if state(k) > numOfStates
        
        eval(sprintf('state_%d = storeStateIndex:k-1;',numOfStates));
        storeStateIndex   = k;
        numOfStates       = numOfStates +1;
    end
end

% add the last state
eval(sprintf('state_%d = storeStateIndex:k;',numOfStates));
    
%% Evaluate the variables in each state
jointGroup = 'torso';

for k = 1:numOfStates
    
    if  strcmp(jointGroup,'torso') == 1
        figure(k)
        plot(time(eval(sprintf('state_%d',k))),torso(eval(sprintf('state_%d',k)),1)*(180/pi),'b','linewidth',2)
        grid on
        hold on
        plot(time(eval(sprintf('state_%d',k))),torsoDes(eval(sprintf('state_%d',k)),1)*(180/pi),'r','linewidth',2)
        title(['torso joints in state ',num2str(k)])
        xlabel('Time [s]')
        ylabel('qj [deg]')
        legend('Real qj','Des qj')
        lgd             = legend;
        loc             = lgd.Location;
        lgd.Location    = 'southeast';
    elseif strcmp(jointGroup,'leftArm') == 1
        figure(k)
        plot(time(eval(sprintf('state_%d',k))),leftArm(eval(sprintf('state_%d',k)))*(180/pi),'b','linewidth',2)
        grid on
        hold on
        plot(time(eval(sprintf('state_%d',k))),leftArmDes(eval(sprintf('state_%d',k)))*(180/pi),'r','linewidth',2)
        title(['leftArm joints in state ',num2str(k)])
        xlabel('Time [s]')
        ylabel('qj [deg]')
        legend('Real qj','Des qj')
        lgd             = legend;
        loc             = lgd.Location;
        lgd.Location    = 'southeast';
    elseif strcmp(jointGroup,'rightArm') == 1
         figure(k)
        plot(time(eval(sprintf('state_%d',k))),rightArm(eval(sprintf('state_%d',k)))*(180/pi),'b','linewidth',2)
        grid on
        hold on
        plot(time(eval(sprintf('state_%d',k))),rightArmDes(eval(sprintf('state_%d',k)))*(180/pi),'r','linewidth',2)
        title(['rightArm joints in state ',num2str(k)])
        xlabel('Time [s]')
        ylabel('qj [deg]')
        legend('Real qj','Des qj')
        lgd             = legend;
        loc             = lgd.Location;
        lgd.Location    = 'southeast';
    elseif strcmp(jointGroup,'leftLeg') == 1
        figure(k)
        plot(time(eval(sprintf('state_%d',k))),leftLeg(eval(sprintf('state_%d',k)))*(180/pi),'b','linewidth',2)
        grid on
        hold on
        plot(time(eval(sprintf('state_%d',k))),leftLegDes(eval(sprintf('state_%d',k)))*(180/pi),'r','linewidth',2)
        title(['leftLeg joints in state ',num2str(k)])
        xlabel('Time [s]')
        ylabel('qj [deg]')
        legend('Real qj','Des qj')
        lgd             = legend;
        loc             = lgd.Location;
        lgd.Location    = 'southeast';
    elseif strcmp(jointGroup,'rightLeg') == 1
         figure(k)
        plot(time(eval(sprintf('state_%d',k))),rightLeg(eval(sprintf('state_%d',k)))*(180/pi),'b','linewidth',2)
        grid on
        hold on
        plot(time(eval(sprintf('state_%d',k))),rightLegDes(eval(sprintf('state_%d',k)))*(180/pi),'r','linewidth',2)
        title(['rightLeg joints in state ',num2str(k)])
        xlabel('Time [s]')
        ylabel('qj [deg]')
        legend('Real qj','Des qj')
        lgd             = legend;
        loc             = lgd.Location;
        lgd.Location    = 'southeast';
    end
end

%% Generate the joint references [deg]
qs1 = [];
qs2 = [-6,];
qs3 = [-10,];
qs5 = [-5.5,];
qs6 = [-2.5,];

%% Generate the YOGA references [deg]


