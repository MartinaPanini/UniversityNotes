clear all; clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         INITIAL POSE OF THE VEHICLE     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global x0;
global y0;
global th0;
x0 = 0;
y0 = 0;
th0 = -0.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      INITIAL DESIRED POSITION OF THE VEHICLE  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global x0d;
global y0d;
global th0d;
x0d = 2;
y0d = 2;
th0d = 0.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Controller gains                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global kp;
global kth;
kp = 10;
kth = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Function Pointers                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Desired velocity
global p_veld;
p_veld = @velD;

%Desired position
global p_xd;
p_xd= @posD;

%Control computation
global p_ctrl;
p_ctrl = @lineControl;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Simulation                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global Tmax;
Tmax = 10;

% this is the simulaton with the controller that computes the states with a
% fine grade (ode45)
[t, x]=ode45(@uniControlledKinematics, [0, Tmax], [x0;y0;th0]);

des_pos_log=[];
vel_des_log=[];
vel_log = [];
%this is just a repetition to extrract the des traj and the control variable that were not logged
for i = 1:length(t),
   des_pos = posD(t(i));
   des_pos_log = [des_pos_log; des_pos'];
   [vd omegad] = velD(t(i));
   [v, om] = lineControl(x(i,:)', des_pos, vd, omegad);
   
   vel_des_log = [vel_des_log; vd omegad];
   vel_log = [vel_log; v om];
end

close all
figure(1)
title('Trajectory');
plot(x(:,1),x(:,2));
hold
plot(des_pos_log(:,1), des_pos_log(:,2));
xlabel('x');
ylabel('y');
legend('Actual Trajectory', 'Desired Trajectory');

figure(2)
title('state variables')
subplot(3,1,1);
plot(t,x(:,1));
hold
plot(t, des_pos_log(:,1));
xlabel('t');
legend('x','x_d');

subplot(3,1,2);
plot(t,x(:,2));
hold
plot(t, des_pos_log(:,2));
legend('y','y_d');

subplot(3,1,3);
plot(t,x(:,3));
hold
plot(t, des_pos_log(:,3));
xlabel('t');
legend('\theta','\theta_d');

figure(3)
title('Command variables')
subplot(2,1,1);
plot(t,vel_log(:,1));
hold
plot(t, vel_des_log(:,1));
xlabel('t');
legend('v','v_d');

subplot(2,1,2);
plot(t,vel_log(:,2));
hold
plot(t, vel_des_log(:,2));
xlabel('t');
legend('\omega','\omega_d');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Auxiliary Functions          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SINC
function [s] = sinc(t)
    if t == 0,
        s = 1;
    else
        s = sin(t)/t;
    end
end

%DESIRED VELOCITY
function [vd, omegad] = velD(t)
    if (t < 2)
        vd = 10;
        omegad = 0;
    else if (t < 5),
            vd = 10;
            omegad = -0.7;
        else
            vd = 0;
            omegad = 0;
        end
    end
end


%DESIRED POSITION
function [xd] = posD(t)
    global x0d;
    global y0d;
    global th0d;
    global Tmax;
    persistent xD;
    persistent tD;

    if isempty(xD)
        [tD, xD] = ode45(@uniFreeKinematics,[0:0.001:Tmax], [x0d; y0d; th0d]);
    end
    [lost, i] = min(abs(tD-t));
    xd = xD(i,:)';
end

% LYAPUNOV BASED CONTROL
% Control algorithm to make sure that the robot follows
% the ideal point 
function [v, omega] = lineControl(x, xd, vd, omegad)
    global kp;
    global kth;


    ex = x(1)-xd(1);
    ey = x(2)-xd(2);
    eth = x(3)-xd(3);
    thd = xd(3);
    th = x(3);

    psi = atan2(ey, ex);
    alpha = (th+thd)/2;
    %if (abs(cos(psi-th))<1e-3)
    %    warning('troubles in sight');
    %end
    exy = sqrt(ey*ey+ex*ex);
    dv = -kp*exy*cos(psi-th);
    %dv = -2*v0*sin(eth/2)*sin(psi-alpha)/cos(psi-th)-exy*kp/cos(psi-th);

    v = vd+dv;
    domega =  -kth*eth -vd*sinc(eth/2)*exy*sin(psi-alpha/2);
    omega = omegad + domega;
 
end

%KINEMATIC FUNCTION FOR THE CONTROLLED VEHICLE
function dxdt = uniControlledKinematics(t, x)
    global p_xd;
    global p_ctrl;
    global p_veld;
  
    [vd, omegad] = p_veld(t);
    [v, omega] = p_ctrl(x, p_xd(t), vd, omegad );
    dxdt =[ v*cos(x(3));
            v*sin(x(3));
            omega];
    
end

%KINEAMTIC FUNCTION FOR THE REFERENCE VEHICLE
function dxdt = uniFreeKinematics(t, x)
    global p_veld;
    global cmd;
    
    [v, omega] = p_veld(t);
    dxdt =[ v*cos(x(3));
            v*sin(x(3));
            omega];
end



    
    
    
