%% OVERWRITING SOME OF THE PARAMETERS CONTAINED IN gains.m WHEN USING FSM
if strcmpi(SM.SM_TYPE, 'YOGA')
    
    CONFIG.SMOOTH_DES_COM      = 1;    % If equal to one, the desired streamed values 
                                       % of the center of mass are smoothed internally 
    CONFIG.SMOOTH_DES_Q        = 1;    % If equal to one, the desired streamed values 
                                       % of the postural tasks are smoothed internally 

    reg.pinvDamp               = 1;
    reg.pinvDampVb             = 1e-7;
    reg.impedances             = 0.1;
    reg.dampings               = 0;
    reg.HessianQP              = 1e-7;

    sat.torque                 = 2000;

    gain.footSize              = [ -0.16  0.16   ;   % xMin, xMax
                                   -0.075 0.075 ];   % yMin, yMax
                   
    forceFrictionCoefficient   = 1/3;  
    
    %Smoothing time for time varying impedances
    gain.SmoothingTimeGainScheduling  = 2;  

    %Smoothing time for time-varying constraints
    CONFIG.smoothingTimeTranDynamics  = 0.02;

    gain.PCOM     =    [10    20   10   % state ==  1   TWO FEET BALANCING
                        10    20   10   % state ==  2   COM TRANSITION TO LEFT 
                        10    20   10   % state ==  3   LEFT FOOT BALANCING
                        10    20   10   % state ==  4   YOGA LEFT FOOT 
                        10    20   10   % state ==  5   PREPARING FOR SWITCHING 
                        10    20   10   % state ==  6   LOOKING FOR CONTACT
                        10    20   10   % state ==  7   TRANSITION TO INITIAL POSITION 
                        10    20   10   % state ==  8   COM TRANSITION TO RIGHT FOOT
                        10    20   10   % state ==  9   RIGHT FOOT BALANCING
                        10    20   10   % state ==  10  YOGA RIGHT FOOT 
                        10    20   10   % state ==  11  PREPARING FOR SWITCHING 
                        10    20   10   % state ==  12  LOOKING FOR CONTACT
                        10    20   10]; % state ==  13  TRANSITION TO INITIAL POSITION
    
    gain.PCOM  = gain.PCOM;
    gain.ICOM  = gain.PCOM*0;
    gain.DCOM  = 2*sqrt(gain.PCOM);
    
    gain.PAngularMomentum  = 0.95;
    gain.DAngularMomentum  = 2*sqrt(gain.PAngularMomentum);

    % state ==  1  TWO FEET BALANCING
    % state ==  2  COM TRANSITION TO LEFT FOOT
    % state ==  3  LEFT FOOT BALANCING 
    % state ==  4  YOGA LEFT FOOT  
    % state ==  5  PREPARING FOR SWITCHING
    % state ==  6  LOOKING FOR CONTACT 
    
    % state ==  7  TRANSITION TO INITIAL POSITION
    
    % state ==  8  COM TRANSITION TO RIGHT FOOT
    % state ==  9  RIGHT FOOT BALANCING 
    % state == 10  YOGA RIGHT FOOT  
    % state == 11  PREPARING FOR SWITCHING
    % state == 12  LOOKING FOR CONTACT 
    % state == 13  TRANSITION TO INITIAL POSITION


    %                   %   TORSO  %%      LEFT ARM   %%      RIGHT ARM   %%            LEFT LEG            %%         RIGHT LEG           %% 
    gain.impedances  = [10   30   20, 10   10    10    8   10, 10   10    10    8   10, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  1  TWO FEET BALANCING
                        10   30   20, 10   10    10    8   10, 10   10    10    8   10, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  2  COM TRANSITION TO LEFT 
                        80  120   80, 40   40    40   40   40, 40   40    40   40   40, 80   80  250   200     50  50, 70   100  70    70     50  50   % state ==  3  LEFT FOOT BALANCING
                        80  120   80, 40   40    40   40   40, 40   40    40   40   40, 80   80  250   200     50  50, 70   100  70    70     50  50  % state ==  4  YOGA LEFT FOOT 
                        30   30   30, 10   10    10   10   10, 10   10    10   10   10, 30   50  300    60     50  50, 30   50   30    60     50  50  % state ==  5  PREPARING FOR SWITCHING 
                        10   30   20, 10   10    10    8   10, 10   10    10    8   10, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  6  LOOKING FOR CONTACT
                        10   30   20, 10   10    10    8   10, 10   10    10    8   10, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  7  TRANSITION TO INITIAL POSITION 
                        80  120   80, 40   40    40   40   40, 40   40    40   40   40, 80  100   50    50     50  50, 80   80  250   200     50  50  % state ==  8  COM TRANSITION TO RIGHT FOOT
                        80  120   80, 40   40    40   40   40, 40   40    40   40   40, 80  100   50    50     50  50, 80   80  250   200     50  50  % state ==  9  RIGHT FOOT BALANCING
                        80   80   80, 40   40    40   40   40, 40   40    40   40   40, 80  100   50    50     50  50, 80   80  250   200     50  50  % state == 10  YOGA RIGHT FOOT 
                        10   30   20, 10   10    10    8   10, 10   10    10    8   10, 30   50   30    60     50  50, 30   50   30    60     50  50  % state == 11  PREPARING FOR SWITCHING 
                        10   30   20, 10   10    10    8   10, 10   10    10    8   10, 30   50   30    60     50  50, 30   50   30    60     50  50  % state == 12  LOOKING FOR CONTACT
                        10   30   20, 10   10    10    8   10, 10   10    10    8   10, 30   50   30    60     50  50, 30   50   30    60     50  50];% state == 13  TRANSITION TO INITIAL POSITION
%     gain.impedances(5,:) = gain.impedances(5,:)/10;
%     gain.impedances(6,:) = gain.impedances(6,:)/10;
%     gain.impedances(7,:) = gain.impedances(7,:)/10;

end              

    gain.impedances = gain.impedances;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                      
         
%% %%%%%%%%%%%%%%%%    FINITE STATE MACHINE SPECIFIC PARAMETERS
sm.skipYoga                      = true;
sm.demoOnlyRightFoot             = false;
sm.yogaAlsoOnRightFoot           = false;
sm.yogaInLoop                    = false;
sm.com.threshold                 = 0.01;
sm.wrench.thresholdContactOn     = 100;%25;       % Force threshole above which contact is considered stable
sm.wrench.thresholdContactOff    = 25;%85;       % Force threshole under which contact is considered off
sm.joints                        = struct;
sm.joints.thresholdNotInContact  = 5;      % Degrees
sm.joints.thresholdInContact     = 50;     % Degrees
sm.joints.pauseTimeLastPostureL  = 3;
sm.joints.pauseTimeLastPostureR  = 3;

sm.stateAt0                      = 1;

sm.DT                            = 1;
sm.waitingTimeAfterYoga          = 0;

sm.jointsSmoothingTimes          = [5;   %% state ==  1  TWO FEET BALANCING
                                         %%
                                    5;   %% state ==  2  COM TRANSITION TO LEFT FOOT
                                    3;   %% state ==  3  LEFT FOOT BALANCING 
                                    4;   %% state ==  4  YOGA LEFT FOOT
                                    5;   %% state ==  5  PREPARING FOR SWITCHING
                                    1;   %% state ==  6  LOOKING FOR CONTACT 
                                         %%
                                    4;   %% state ==  7  TRANSITION INIT POSITION
                                         %%
                                    5;   %% state ==  8  COM TRANSITION TO RIGHT FOOT
                                    3;   %% state ==  9  RIGHT FOOT BALANCING 
                                    4;   %% state == 10  YOGA RIGHT FOOT
                                    5;   %% state == 11  PREPARING FOR SWITCHING
                                    5;   %% state == 12  LOOKING FOR CONTACT 
                                         %%
                                    4];  %% state == 13  TRANSITION INIT POSITION

sm.com.states      = [0.0,  0.01,  0.0;     %% state ==  1  TWO FEET BALANCING NOT USED
                      0.0,  0.01,  0.0;     %% state ==  2  COM TRANSITION TO LEFT FOOT: THIS REFERENCE IS USED AS A DELTA W.R.T. THE POSITION OF THE LEFT FOOT
                      0.0,  0.00,  0.0;     %% state ==  3  LEFT FOOT BALANCING 
                      0.0,  0.02,  0.02;    %% state ==  4  YOGA LEFT FOOT
                      0.0,  0.00, -0.02;    %% state ==  5  PREPARING FOR SWITCHING
                      0.0, -0.15, -0.05;    %% state ==  6  LOOKING FOR CONTACT 
                      0.0, -0.15, -0.05;    %% state ==  7  TRANSITION INIT POSITION
                      % FROM NOW ON, THE REFERENCE ARE ALWAYS DELTAS W.R.T.
                      % THE POSITION OF THE RIGHT FOOT
                      0.0, -0.02, -0.075;     %% state ==  8  COM TRANSITION TO RIGHT FOOT
                      0.0, -0.02,  0.0;     %% state ==  9  RIGHT FOOT BALANCING 
                      0.0, -0.00, -0.0;     %% state == 10  YOGA RIGHT FOOT
                      0.0, -0.00,  0.0;     %% state == 11  PREPARING FOR SWITCHING
                      0.0,  0.09,  0.0;     %% state == 12  LOOKING FOR CONTACT 
                      0.0,  0.00,  0.0];    %% state == 13  TRANSITION INIT POSITION: THIS REFERENCE IS IGNORED
sm.tBalancing      = 0;%inf;%0.5;


sm.joints.states = [[0.0864,0.0258,0.0152, ...                          %% state == 1  TWO FEET BALANCING, THIS REFERENCE IS IGNORED 
                     0.1253,0.8135,0.3051,0.7928,0 ...                  %
                     0.0563,0.6789,0.3340,0.6214,0 ...                  %
                     0.0522,-0.2582,0.0014,-0.2129,-0.0944,0.1937,...   %
                     0.0128,0.4367,0.0093,-0.1585,-0.0725,-0.2931];     %
                    [-0.0348,0.0779,0.0429, ...                         %% state == 2  COM TRANSITION TO LEFT 
                     -0.1493,0.8580,0.2437,0.8710,0 ...                 %
                     -0.1493,0.8580,0.2437,0.8710,0 ...                 %
                     -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630, ...  %  
                     0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151];     %  
                    [0.0864,0.0258,0.0152, ...                          %% state == 3  LEFT FOOT BALANCING
                     0.1253,0.8135,0.3051,0.7928,0 ...                  %    
                     0.0563,0.6789,0.3340,0.6214,0 ...                  %
                     -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630, ...  %  
                     0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151];     % 
                    [0.0864,0.0258,0.0152, ...                          %% state == 4  YOGA LEFT FOOT, THIS REFERENCE IS IGNORED 
                     0.1253,0.8135,0.3051,0.7928,0 ...                  %
                     0.0563,0.6789,0.3340,0.6214,0 ...                  %
                     0.0522,-0.2582,0.0014,-0.2129,-0.0944,0.1937,...   %
                     0.0128,0.4367,0.0093,-0.1585,-0.0725,-0.2931];     %
                    [-0.0348,0.0779,0.0429, ...                         %% state == 5  PREPARING FOR SWITCHING
                     -0.1493,0.8580,0.2437,0.8710,0 ...                 %
                     -0.1493,0.8580,0.2437,0.8710,0 ...                 %
                     -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630, ...  %  
                     0.0005,0.0793,-0.0014,-0.0051    0.0073   -0.1151];%                                  %
                    [0.0864,0.0258,0.0152, ...                          %% state == 6  LOOKING FOR CONTACT
                     0.1253,0.8135,0.3051,0.7928,0 ...                  %
                     0.0563,0.6789,0.3340,0.6214,0 ...                  %
                     0.0107,-0.0741,-0.0001,-0.0120,0.0252,0.1369,...   %
                     -0.0026,0.0225,0.0093,-0.0020,0.0027,-0.0277];     %   
                     zeros(1,ROBOT_DOF);                                %% state == 7  TRANSITION INIT POSITION: THIS REFERENCE IS IGNORED
                    [0.0864,0.0258,0.0152, ...                          %% state == 8  COM TRANSITION TO RIGHT FOOT
                     0.1253,0.8135,0.3051,0.7928,0 ...                  %
                     0.0563,0.6789,0.3340,0.6214,0 ...                  %
                     0.0107,-0.0741,-0.0001,-0.0120,0.0252,0.1369,...   %
                     -0.0026,0.0225,0.0093,-0.0020,0.0027,-0.0277];     % 
                    [0.0864,0.0258,0.0152, ...                          %% state == 9  RIGHT FOOT BALANCING
                     0.1253,0.8135,0.3051,0.7928,0 ...                  %    
                     0.0563,0.6789,0.3340,0.6214,0 ...                  %
                     0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151, ...  %  
                     -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630];     %  
                     zeros(1,ROBOT_DOF);                                %% state == 10  YOGA RIGHT FOOT, THIS REFERENCE IS IGNORED  
                    [-0.0348,0.0779,0.0429, ...                         %% state == 11  PREPARING FOR SWITCHING
                     -0.1493,0.8580,0.2437,0.8710,0 ...                 %
                     -0.1493,0.8580,0.2437,0.8710,0 ...                 %
                      0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151, ... %  
                      -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630];    %                                  %
                    [0.0864,0.0258,0.0152, ...                          %% state == 12  LOOKING FOR CONTACT
                     0.1253,0.8135,0.3051,0.7928,0 ...                  %
                     0.0563,0.6789,0.3340,0.6214,0 ...                  %
                     -0.0026,0.0225,0.0093,-0.0020,0.0027,-0.0277,...   %
                     0.0107,-0.0741,-0.0001,-0.0120,0.0252,0.1369];     %   
                    zeros(1,ROBOT_DOF)];                                %% state == 13  BALANCING TWO FEET, THIS REFERENCE IS IGNORED                     

 
q1 =        [-0.0790,0.2279, 0.4519, ...
             -1.1621,0.6663, 0.4919, 0.9947,0, ... 
             -1.0717,1.2904,-0.2447, 1.0948,0, ...
              0.2092,0.2960, 0.0006,-0.1741,-0.1044, 0.0700, ...
              0.3484,0.4008,-0.0004,-0.3672,-0.0530,-0.0875];

q2 =        [-0.0790,0.2279, 0.4519, ...
             -1.1621,0.6663, 0.4965, 0.9947,0, ...
             -1.0717,1.2904,-0.2493, 1.0948,0, ...
              0.2092,0.2960, 0.0006,-0.1741,-0.1044,0.0700, ... 
              0.3714,0.9599, 1.3253,-1.6594, 0.6374,-0.0614];
          
q3 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042,0, ...
             -0.4181, 1.6800,0.7373, 0.3031,0, ...
              0.2092,0.2960, 0.0006,-0.1741,-0.1044,0.0700, ...
              0.3714,0.9599, 1.3253,-1.6594, 0.6374,-0.0614];
          
q4 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042,0, ...
             -0.4181, 1.6800,0.7373, 0.3031,0, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253,-0.0189, 0.6374,-0.0614];
          
q5 =        [-0.0790,-0.1273, 0.4519, ...
             -1.1621,0.6663, 0.4965, 0.9947,0, ...
             -1.0717,1.2904,-0.2493, 1.0948,0, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253,-0.0189, 0.6374,-0.0614];
          
q6 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042,0, ...
             -0.4181, 1.6800,0.7373, 0.3031,0, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253,-0.0189, 0.6374,-0.0614];
          
q7 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042,0, ...
             -0.4181, 1.6800,0.7373, 0.3031,0, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253, -1.6217, 0.6374,-0.0614];
          
q8 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042,0, ...
             -0.4181, 1.6800,0.7373, 0.3031,0, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253,-0.0189, 0.6374,-0.0614];

%%          
sm.joints.pointsL =[ 0,                            q1;
                     1*sm.jointsSmoothingTimes(10),q2;
                     2*sm.jointsSmoothingTimes(10),q3;
                     3*sm.jointsSmoothingTimes(10),q4;
                     4*sm.jointsSmoothingTimes(10),q5;
                     5*sm.jointsSmoothingTimes(10),q6;
                     6*sm.jointsSmoothingTimes(10),q7;
                     7*sm.jointsSmoothingTimes(10),q8];
                 
sm.joints.pointsR = sm.joints.pointsL;
					 
for i = 1:size(sm.joints.pointsR,1)				
	sm.joints.pointsR(i,2:4)          = [sm.joints.pointsR(i,2) -sm.joints.pointsR(i,3) -sm.joints.pointsR(i,4)];
	
	rightArm                           =  sm.joints.pointsR(i,end-16:end-12);
	sm.joints.pointsR(i,end-16:end-12) =  sm.joints.pointsR(i,end-21:end-17);
	sm.joints.pointsR(i,end-21:end-17) =  rightArm;
	
	rightLeg                          =  sm.joints.pointsR(i,end-5:end);
	sm.joints.pointsR(i,end-5:end)    =  sm.joints.pointsR(i,end-11:end-6);
	sm.joints.pointsR(i,end-11:end-6) =  rightLeg;
end	 


%% Remapping of the references in order to fit the Bigman configuration and the iCub configuration
addpath('../../../../utilityMatlabFunctions/')
numOfStates     = size(sm.joints.states,1);
ndof            = size(sm.joints.states,2);
numOfStatesYoga = 8;

for kk = 1:numOfStates
    
    sm.joints.states(kk,:) = from_iCub_To_Bigman_JointRemapper(sm.joints.states(kk,:),ndof);
end

for kk = 1:numOfStatesYoga
    
    qjRemapped                    = from_iCub_To_Bigman_JointRemapper(sm.joints.pointsR(kk,2:end),ndof);
    sm.joints.pointsR(kk,2:end)   = qjRemapped;
    qjRemapped                    = from_iCub_To_Bigman_JointRemapper(sm.joints.pointsL(kk,2:end),ndof);
    sm.joints.pointsL(kk,2:end)   = qjRemapped;
end

q1 = from_iCub_To_Bigman_JointRemapper(q1,ndof);
q2 = from_iCub_To_Bigman_JointRemapper(q2,ndof);
q3 = from_iCub_To_Bigman_JointRemapper(q3,ndof);
q4 = from_iCub_To_Bigman_JointRemapper(q4,ndof);
q5 = from_iCub_To_Bigman_JointRemapper(q5,ndof);
q6 = from_iCub_To_Bigman_JointRemapper(q6,ndof);
q7 = from_iCub_To_Bigman_JointRemapper(q7,ndof);
q8 = from_iCub_To_Bigman_JointRemapper(q8,ndof);


clear q1 q2 q3 q4;
