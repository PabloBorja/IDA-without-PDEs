% ==== Planar Manipulator ====%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************* Created by Pablo Borja ***************** %
% ***** Contact: pablo.borjarosales@plymouth.ac.uk ***** %
% ***** SECaM, Univerity of Plymouth, Plymouth, UK ***** %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dy = planar(y,par,xd)


% This example illustrates the results of Proposition 2  

% Parameters of the plant

a1= par(1);
a2= par(2);
b= par(3);
c1= par(4);
c2= par(5);

% States

q1 = y(1);
q2 = y(2);
p1 = y(3);
p2 = y(4);

% Model

F = [0 0 1 0; 0 0 0 1; -1 0 -c1 0; 0 -1 0 -c2];
Fua = eye(2,2);
g = [0 0; 0 0; 1 0; 0 1];

nq2H = -(b*sin(q2)*(a1*p2 - b*p1*cos(q2) + b*p2*cos(q2))*(a2*p2 - a2*p1 + b*p2*cos(q2)))/(a1*a2 - b^2*cos(q2)^2)^2; % Partial derivative of H with respect to q2

nH = [0; nq2H; -(a2*p2 - a2*p1 + b*p2*cos(q2))/(a1*a2 - b^2*cos(q2)^2); (a1*p2 - a2*p1 + a2*p2 - b*p1*cos(q2) + 2*b*p2*cos(q2))/(a1*a2 - b^2*cos(q2)^2)]; %Hamiltonian's gradient


% Desired equilibrium.  

q1d = xd(1); 
q2d = xd(2);

% Control parameters

K = diag([5 5]); %Gains. Modify if necessary
Kdi = diag([0.8 1]); %Damping injection gains.

nVd = K*[q1-q1d;q2-q2d]; %Gradient of the desired potential energy

nHd = nH+[nVd;0;0]; % Gradient of Hd.

% Controller

u = -Fua'*nVd-Kdi*[nHd(3);nHd(4)];  

dy = F*nH+g*u;
 
end

