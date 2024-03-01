% ======= Simulation Magnetic Levitation System ======== %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************* Created by Pablo Borja ***************** %
% ***** Contact: pablo.borjarosales@plymouth.ac.uk ***** %
% ***** SECaM, Univerity of Plymouth, Plymouth, UK ***** %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameters of the plant

mb = 0.1; %Ball's mass
rho = 0.05; %Ball's radius
k = 0.01; %This parameter is related to the number of turns in the coil
gr = 9.8; %Gravitational acceleration
r = 8; %Electrical resistance

par = [mb rho k gr r]';

%% Desired equilibrium 

qd = -0.02; %Desired position. Modify if necessary.
phid = sqrt(2*mb*gr*k);

% Remember that pd is always zero

xd = [qd phid]';

%% Initial conditions

IC = [0 0 0]; % Modify to simulate different initial conditions

%% Final time 

T = 20; % Modify if you want to simulate a longer or shorter period

%% Simulation

[t,y] = ode23(@(t,y)maglev(t,y,par,xd),[0,T],IC); % The file maglev.m must be in the same folder

%% Plots

close all

% Position

subplot(3, 1, 1)
yline(qd, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,1),'LineWidth',2)
hold off
title('$q$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
legend('$q_{d}$','$q$','interpreter','latex','Location','SouthEast')
ylabel('Position [m]','interpreter','latex','FontSize',22)

% Momentum

subplot(3, 1, 2)
yline(0, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,2),'LineWidth',2)
hold off
title('$p$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
ylabel('Momentum [kg$\cdot$m/s]','interpreter','latex','FontSize',22)

% Flux

subplot(3, 1, 3)
yline(phid, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,3),'LineWidth',2)
hold off
title('$\varphi$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
legend('$\varphi_{d}$','$\varphi$','interpreter','latex','Location','SouthEast')
xlabel('Time [s]','interpreter','latex','FontSize',22)
ylabel('Flux [Wb]','interpreter','latex','FontSize',22)