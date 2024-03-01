% ======= Simulation Planar Manipulator ======== %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************* Created by Pablo Borja ***************** %
% ***** Contact: pablo.borjarosales@plymouth.ac.uk ***** %
% ***** SECaM, Univerity of Plymouth, Plymouth, UK ***** %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameters of the plant

a1= 0.1547;
a2= 0.0111;
b= 0.0168;
c1= 1.5964;
c2= 0.6971;

par = [a1 a2 b c1 c2]';

%% Desired equilibrium. Modify if necessary 

q1d = -0.2; 
q2d = 0.3;

% Both 'desired' momenta are zero

xd = [q1d q2d]';

%% Initial conditions

IC = [0 0 0 0]; % Modify to simulate different initial conditions

%% Final time 

T = 5; % Modify if you want to simulate a longer or shorter period

%% Simulation

[t,y] = ode23(@(t,y)planar(t,y,par,xd),[0,T],IC); % The file planar.m must be in the same folder

%% Plots

close all

% q1

subplot(2, 2, 1)
yline(q1d, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,1),'LineWidth',2)
hold off
title('$q_{1}$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
legend('$q_{1_{d}}$','$q_{1}$','interpreter','latex')
ylabel('Angular position [rad]','interpreter','latex','FontSize',22)

% q2

subplot(2, 2, 2)
yline(q2d, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,2),'LineWidth',2)
hold off
title('$q_{2}$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
legend('$q_{2_{d}}$','$q_{2}$','interpreter','latex')
ylabel('Angular position [rad]','interpreter','latex','FontSize',22)

% p1

subplot(2, 2, 3)
yline(0, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,3),'LineWidth',2)
hold off
title('$p_{1}$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
ylabel('Angular momentum [kg$\cdot$m$^{2}$/s]','interpreter','latex','FontSize',22)

% p2

subplot(2, 2, 4)
yline(0, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,4),'LineWidth',2)
hold off
title('$p_{2}$','interpreter','latex','FontSize',22)
set(gca,'FontSize',18)
xlabel('Time [s]','interpreter','latex','FontSize',22)
ylabel('Angular momentum [kg$\cdot$m$^{2}$/s]','interpreter','latex','FontSize',22)