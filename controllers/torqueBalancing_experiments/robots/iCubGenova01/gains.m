ROBOT_DOF = 23;

CONFIG.LEFT_RIGHT_FOOT_IN_CONTACT  = [1 1];

CONFIG.SMOOTH_DES_COM      = 0;    % If equal to one, the desired streamed values 
                            % of the center of mass are smoothed internally 
CONFIG.SMOOTH_DES_Q        = 0;    % If equal to one, the desired streamed values 
                            % of the postural tasks are smoothed internally 
                            
references.joints.smoothingTime    = 1.0;
references.com.smoothingTime       = 5;

sat.torque = 34;

smoothingTimeTransitionDynamics    = 0.05;

ROBOT_DOF_FOR_SIMULINK = eye(ROBOT_DOF);
gain.qTildeMax         = 20*pi/180;
postures = 0;  

gain.SmoothingTimeImp  = 1;  
gain.ikin.kp           = 5;
gain.ikin.kd           = 2*sqrt(gain.ikin.kp);

%%
%           PARAMETERS FOR TWO FEET ONE GROUND
if (sum(CONFIG.LEFT_RIGHT_FOOT_IN_CONTACT) == 2)
    gain.PCOM                 = diag([ 25   25  25]);
    gain.ICOM                 = diag([  0    0   0]);
    gain.DCOM                 = 2*sqrt(gain.PCOM)*0;

    gain.PAngularMomentum     = 1 ;
    gain.DAngularMomentum     = 1 ;

    % Impadances acting in the null space of the desired contact forces 

    impTorso            = [40   40   40
                            0    0    0]; 
    impArms             = [15   15    20   12   
                            0    0     0    0   ];
                        
    impLeftLeg          = [ 35   10   60   700      0  10
                             0    0    0     0      0   0]; 

    impRightLeg         = [ 35   10   60   700      0  10
                             0    0    0     0      0   0]; 
    
                         
    intTorso            = [0   0    0]; 
    intArms             = [0   0    0    0  ];
                        
    intLeftLeg          = [0   0    0    0    0  0]; 

    intRightLeg         = [0   0     0  0    0  0];   
    
                                           
end

% PARAMETERS FOR ONLY ONE FOOT ONE GROUND

if (sum(CONFIG.LEFT_RIGHT_FOOT_IN_CONTACT) == 1)
    %%
    gain.PCOM                 = diag([120  140 120]);
    gain.ICOM                 = diag([  0    0   0]);
    gain.DCOM                 = diag([  0    0   0]);

    gain.PAngularMomentum     = 1 ;
    gain.DAngularMomentum     = 1 ;

    % Impadances acting in the null space of the desired contact forces 

    
    intTorso            = [0   0    0]; 
    intArms             = [0   0    0    0  ];
                        
    intLeftLeg          = [0   0    0    0    0  0]; 

    intRightLeg         = [0   0    0    0    0  0];  
    
    scalingImp          = 1;
    
    impTorso            = [20   20   20
                            0    0    0]*scalingImp; 
    impArms             = [13   17    13    5     
                            0    0     0    0   ]*scalingImp;
                        
    impLeftLeg          = [ 70   70   65   300      0   0
                             0    0    0     0      0   0]*scalingImp; 

    impRightLeg         = [ 20   20   20    10      0    0
                             0    0    0     0      0   0]*scalingImp; 
                            
%%    
end

sat.integral              = 0;
gain.integral            = [intTorso,intArms,intArms,intLeftLeg,intRightLeg];
gain.impedances          = [impTorso(1,:),impArms(1,:),impArms(1,:),impLeftLeg(1,:),impRightLeg(1,:)];
gain.dampings            = zeros(1,ROBOT_DOF);
gain.increasingRatesImp  = [impTorso(2,:),impArms(2,:),impArms(2,:),impLeftLeg(2,:),impRightLeg(2,:)];
sat.impedences            = [80   25    1400];

if (size(gain.impedances,2) ~= ROBOT_DOF)
    error('Dimension mismatch between ROBOT_DOF and dimension of the variable impedences. Check these variables in the file gains.m');
end


%% constraints for QP for balancing on both feet - friction cone - z-moment - in terms of f (not f0!)


% Friction cone parameters
numberOfPoints               = 4; % The friction cone is approximated by using linear interpolation of the circle. 
                                  % So, numberOfPoints defines the number of points used to interpolate the circle in each cicle's quadrant 

forceFrictionCoefficient     = 1/3;  
torsionalFrictionCoefficient = 2/150;

%physical size of foot
phys.footSize                = [ -0.065 0.13   ;    % xMin, xMax
                                 -0.045 0.05  ];   % yMin, yMax    
                      
   gain.footSize  = [ -0.07  0.12   ;    % xMin, xMax
                       -0.045 0.05 ];   % yMin, yMax   

% gain.footSize                = [ -0.065 0.13   ;    % xMin, xMax
%                                  -0.04 0.04  ];   % yMin, yMax
fZmin                        = 10;

%% The QP solver will search a solution fo that 
% satisfies the inequality Aineq_f F(fo) < bineq_f
reg.pinvTol     = 1e-5;
reg.pinvDamp    = 0.01;
reg.pinvDampVb  = 0.001;
reg.HessianQP   = 1e-7;