% blog_example_param.m
% parameters for Controllability - Observability tutorial
% MKS units
% Author: Brian Tremaine, TremaineConsultingGroup.com

% When output y is x1+x3 the system is not fully observable
% by having two separate outputs, x1, and x3, the system 
% states are fully observable
% states: x1= cart1 pos
%         x2= cart1 vel
%         x3= cart2 pos
%         x4= cart2 vel
clear

% first define continuous time system 
% large mass: M2,  small mass: M1
M = 10.0;
Kf2= 10.0;
Kv2= 0.5;

m = 1.0;
Kf1= 2.0;
Kv1= 0.1;

Kf12 = 0.2;
Kf21 = 1.0;

U1 = 1.0;
U2 = 3.0;

A = [ 0  1        0 0 ;
      0 -Kv1/m    0 0
      0  0        0 1 ;
      0 0 0      -Kv2/M];
B = [0        0;
     Kf1/m    Kf21/m
     0        0;
     Kf12/M   Kf2];
C = [1 0 0 0
     0 0 1 0];
D = 0;

%% Convert to discrete time
Ts = 1E-3;
SYS= ss(A,B,C,D);
SYSd = c2d(SYS,Ts);

%% compute CO and OB
CO = ctrb(SYSd.A,SYSd.B);
OB= obsv(SYSd.A,SYSd.C);
rank(CO) ;
rank(OB) ;

%% lqr gains
Q = 100;    % states
R = 1;   % control

[K,S, CLP]= dlqr(SYSd.A,SYSd.B,Q,R);

Nx= [1 0 1 0; 0 0 0 0];

SYS1 = ss(SYSd.A-SYSd.B*K,SYSd.B,SYSd.C,SYSd.D);
%% step response
dstep(SYS1.A,SYS1.B,SYS1.C,SYS1.D)

%% matricies from sim model
Ad = SYSd.A;
Bd = SYSd.B;
Cd = SYSd.C;
Dd = SYSd.D;


