% ==== Magnetic Levitation System ====%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************* Created by Pablo Borja ***************** %
% ***** Contact: pablo.borjarosales@plymouth.ac.uk ***** %
% ***** SECaM, Univerity of Plymouth, Plymouth, UK ***** %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dy = maglev(t,y,par,xd)


% This example illustrates the results of Proposition 4  

% Parameters of the plant

mb = par(1);
rho = par(2);
k = par(3);
gr = par(4);
r = par(5);

% States


q = y(1);
p = y(2);
phi = y(3);

% Model

F = [0 1 0; -1 0 0; 0 0 -r];
Fuu = [0 1; -1 0];
Faa = -r;
g = [0 0 1]';

nH = [mb*gr-phi^2/(2*k); p/mb; phi*(rho-q)/k]; %Hamiltonian's gradient

beta_u = [mb*gr; p/mb];
beta_a = phi^2/(2*k);

% Desired equilibrium 

qd = xd(1);
phid = xd(2);

% Control parameters

Upsilon = -[1; 0];
Kz = 0.08; %Gain. Modify if necessary
Kdi = 0; %Damping injection gain. The system has natural damping (in the electrical part), but you can add more (if wanted)

% Ψ is considered as in the PDF file. Hence,

nPsi = [Kz*(q+phi-qd-phid)-mb*gr; 0; Kz*(q+phi-qd-phid)-mb*gr]; % Gradient of Ψ. You are encouraged to try different functions Ψ

nHd = nPsi + [beta_u;beta_a]; % Gradient of Hd. For this example σ=1

% Controller

u = -Upsilon'*Fuu'*[nHd(1);nHd(2)]+Faa*(nHd(3)-nH(3))-Kdi*nHd(3); % Note that Fau = 0.

dy = F*nH+g*u;
 
end

