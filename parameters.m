% paramters.m
% parameters for Controllability - Observability tutorial
% MKS units
% Author: Brian Trmaine, TremaineConsultingGroup.com

% When output y is x1+x3 the system is not fully observable
% by having two separate outputs, x1, and x3, the system is the 
% fully observable

Mlrg = 10.0;
Kflrg= 10.0;
Kvlrg= 0.5;

Msm = 1.0;
Kfsm= 2.0;
Kvsm= 0.1;

U1 = 1.0;
U2 = 3.0;

A = [ 0 1 0 0 ;
      0 -Kvsm/Msm 0 0
      0 0 0 1 ;
      0 0 0 -Kvlrg/Mlrg];

B = [0 0;
     Kfsm/Msm 0
     0 0;
     0 Kflrg/Mlrg];

C = [1 0 0 0; 0 0 1 0];

CO = ctrb(A,B)

OB= obsv(A,C)
