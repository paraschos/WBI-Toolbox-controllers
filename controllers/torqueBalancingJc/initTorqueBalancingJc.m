clear all;
clc;

%robotName = 'icub'; 
 robotName = 'icubGazeboSim';              
 setenv('YARP_ROBOT_NAME','icubGazeboSim');
 localName = 'matlabTorqueBalancing';

 LinkName = 'codyco_balancing_world';

 simulationTime    = inf;       % Simulation time in seconds

 USE_QP_SOLVER    = 0;

 LEFT_RIGHT_FOOT_IN_CONTACT  = [1 1];

 DEMO_MOVEMENTS   = 0;  % Either 0 or 1 

%Controller period
 n_joints = 23;
 Ts               = 0.01; % [s]

% Load gains and parameters for the specific robot
run(strcat('robots/',getenv('YARP_ROBOT_NAME'),'/gains.m')); 
addpath('extra/')
[ConstraintsMatrix,bVectorConstraints]= constraints(forceFrictionCoefficient,numberOfPoints,torsionalFrictionCoefficient,gain.footSize,fZmin);

% Uncomment the following line if you want to sync Gazebo and simulink.

setenv('YARP_CLOCK','/clock');
      
% If you want to sync Gazebo and simulink,
% you have to launch gazebo as follow:
% 
% gazebo -slibgazebo_yarp_clock.so
%
% Also, open the subsystem "Synchronizer" in the simulink model 
% "balancingOptTau.mdl" and comment the block "Real Time Syncronizer" and
% uncomment the block "ySynchronizer".