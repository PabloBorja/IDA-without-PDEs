% ======= Simulation Biochemical Fermenter ======== %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************* Created by Pablo Borja ***************** %
% ***** Contact: pablo.borjarosales@plymouth.ac.uk ***** %
% ***** SECaM, Univerity of Plymouth, Plymouth, UK ***** %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameters of the plant. These parameter are taken from:

% ~~~~~~~~~~~~~~~~

% Dörfler, F., Johnsen, J. K., & Allgoewer, F. (2009).
% An introduction to interconnection and damping assignment passivity-based control in process engineering.
% Journal of Process Control, 19(9), 1413-1426.

% ~~~~~~~~~~~~~~~~

Y = 0.5; 
mu_max = 1; 
Sf = 10; 
c1 = 0.03; 
c2 = 0.5;

par = [Y mu_max Sf c1 c2]';

% Desired equilibrium. Modify if necessary. Remember to satisfy x1d/Y+x2d = Sf  

x1d = 4.8; 
x2d = Sf - x1d/Y;

xd = [x1d;x2d];

% Initial conditions

IC = [2.8 4.4]; % Modify to simulate different initial conditions

% Final time 

T = 5e-5; % Modify if you want to simulate a longer or shorter period

% Simulation

opts = odeset('RelTol',1e-10,'AbsTol',1e-12);

[t,y] = ode45(@(t,y)fermenter(t,y,par,xd),[0,T],IC,opts); % The file fermenter.m must be in the same folder

% Plots

close all

% x1

subplot(2, 1, 1)
yline(x1d, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,1), 'LineWidth',2)
hold off
title('$x_{1}$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
legend('$x_{1_{d}}$','$x_{1}$','interpreter','latex')
ylabel('Cell [kg$\cdot$BM/m$^{3}$]','interpreter','latex','FontSize',22)

% x2

subplot(2, 1, 2)
yline(x2d, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,2), 'LineWidth',2)
hold off
title('$x_{2}$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
legend('$x_{2_{d}}$','$x_{2}$','interpreter','latex')
xlabel('Time [s]','interpreter','latex','FontSize',22)
ylabel('Substrate [mol/m$^{3}$]','interpreter','latex','FontSize',22)

% NOTE: the convergence is extremely fast. This might be due to unrealistic
% values. However, that is out of the scope of this work