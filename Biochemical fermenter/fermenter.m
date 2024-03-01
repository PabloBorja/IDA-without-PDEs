% ==== Biochemical Fermenter ====%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************* Created by Pablo Borja ***************** %
% ***** Contact: pablo.borjarosales@plymouth.ac.uk ***** %
% ***** SECaM, Univerity of Plymouth, Plymouth, UK ***** %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dy = fermenter(t,y,par,xd)


% This example illustrates the results of Proposition 1  


Y = par(1); 
mu_max = par(2); 
Sf = par(3); 
c1 = par(4); 
c2 = par(5);


% States

x1 = y(1);
x2 = y(2);

% Model

mu = mu_max*x2/(c1+x2+c2*x2^2); %μ(x2)

F = mu*x1*[-1 0; 0 -1/(x2*Y)];
% Fi = (1/(mu*x1))*[-1 0; 0 -x2*Y]; % F^{-1}

g = mu*x1*[-x1; Sf-x2];

nH = [-1; x2]; %Hamiltonian's gradient


% % Desired equilibrium. Modify if necessary. Remember to satisfy x1d/Y+x2d = Sf  

x1d = xd(1);
x2d = xd(2);

% Control parameters

gamma = x1^2/2 - Sf*Y*x2^2/2 + Y*x2^3/3;
gamma_s = x1d^2/2 - Sf*Y*x2d^2/2 + Y*x2d^3/3;
u_s = 1/x1d;

% Control gains. Modify if necessary


K = 5;
Kdi = 15/(mu*x1); % Modifying the closed-loop damping 
%is necessary to achieve asymptotic stability

ngPhi = u_s + K*(gamma-gamma_s); % Partial of Φ with respect to γ

nPhi = [x1; -Sf*Y*x2+Y*x2^2]*ngPhi; % Gradient of Φ with respect to x. 
% You are encouraged to try different functions Φ

nHd = nPhi + nH; % Gradient of Hd. 

% Controller

u = -ngPhi-Kdi*g'*nHd;  

dy = F*nH+g*u;
 
end
