% ==== Microelectromechanical Switch ====%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************* Created by Pablo Borja ***************** %
% ***** Contact: pablo.borjarosales@plymouth.ac.uk ***** %
% ***** SECaM, Univerity of Plymouth, Plymouth, UK ***** %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dy = mems(t,y,par,xd)


% This example illustrates the results of Proposition 3  

% Parameters of the plant. 

q0=par(1);
Ae=par(2);
m=par(3);
k=par(4);
b=par(5);
r=par(6);

% States

q = y(1);
p = y(2);
Q = y(3);

% Model

F=[0 1 0;-1 -b 0;0 0 -1/r];
Faa = -1/r;
g=[0 0 1]'; % The input is U = u/r. See the PDF file

nH = [k*tanh(q)+Q^2/(2*Ae); p/m; (q+q0)*Q/Ae]; %Hamiltonian's gradient


% Desired equilibrium. 
qd = xd(1); 
Qd = xd(2);

% Control parameters

% Control gains. Modify if necessary

Ka = 100;
Kdi = 20;

nPhia = Ka*(Q-Qd) - (qd+q0)*Qd/Ae; % Partial of Φa with respect to xa (see PDF)
 
% You are encouraged to try different functions Φa

nHd = [0;0;nPhia] + nH; % Gradient of Hd. 

% Controller

u = Faa*nPhia-Kdi*nHd(3);  % Note that Fau = 0.

dy = F*nH+g*u;
 
end
