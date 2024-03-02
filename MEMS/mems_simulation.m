% ======= Simulation Microelectromechanical Switch ======== %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ************* Created by Pablo Borja ***************** %
% ***** Contact: pablo.borjarosales@plymouth.ac.uk ***** %
% ***** SECaM, Univerity of Plymouth, Plymouth, UK ***** %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameters of the plant. 

q0=15e-6;
Ae=35.6e-9; % This parameter is equivalent to the product Aε
m=2.35e-9;
k=0.46;
b=5.5e-7;
r=100;

par = [q0 Ae m k b r]';

%% Desired equilibrium. Modify if necessary. Remember to satisfy -q0 < qd <= 0  

qd = -5e-6; 
Qd = sqrt(-2*Ae*k*tanh(qd));

% Remember that pd is always zero

xd = [qd Qd]';

%% Initial conditions

IC = [0 0 0]; % Modify to simulate different initial conditions

%% Final time 

T = 0.005; % Modify if you want to simulate a longer or shorter period

%% Simulation

opts = odeset('RelTol',1e-10,'AbsTol',1e-12);

[t,y] = ode45(@(t,y)mems(y,par,xd),[0,T],IC,opts); % The file mems.m must be in the same folder

%% Plots

close all

% Position

subplot(3, 1, 1)
yline(qd, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,1),'LineWidth',2)
hold off
title('$q$','interpreter','latex','FontSize',20)
set(gca,'FontSize',18)
legend('$q_{d}$','$q$','interpreter','latex','Location','NorthEast')
ylabel('Position [m]','interpreter','latex','FontSize',20)

% Momentum

subplot(3, 1, 2)
yline(0, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,2),'LineWidth',2)
hold off
title('$p$','interpreter','latex','FontSize',20)
set(gca,'FontSize',18)
ylabel('Momentum [kg$\cdot$m/s]','interpreter','latex','FontSize',20)

% Charge

subplot(3, 1, 3)
yline(Qd, 'r--', 'LineWidth', 2);
grid on
hold on 
plot(t,y(:,3),'LineWidth',2)
hold off
title('$Q$','interpreter','latex','FontSize',20)
set(gca,'FontSize',18)
legend('$Q_{d}$','$Q$','interpreter','latex','Location','SouthEast')
xlabel('Time [s]','interpreter','latex','FontSize',20)
ylabel('Charge [C]','interpreter','latex','FontSize',20)