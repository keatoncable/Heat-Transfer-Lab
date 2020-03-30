clear
clc
close all

%% Read in data
forced = importdata('Sphere_Forced_edit.txt');
natural = importdata('Sphere_Natural_edit.txt');
% fcube = importdata('
% ncube = 

%% Constants
rho = 7930; %material: 304 SS
cp = 500;
d = 38.1/1000;
As = 4*pi/4*d^2;
V = 4/3*pi*(d/2)^3;

%% Regression
lfor = length(forced(:,1));
lnat = length(natural(:,1));
tof = forced(1,2);
ton = natural(1,2);
tinf = 20;

ln_for = log((tof-tinf)./(forced(:,2)-tinf));
ln_nat = log((ton-tinf)./(natural(:,2)-tinf));
t_for = forced(:,1);
t_nat = natural(:,1);

figure
plot(t_for,ln_for)
title('Forced Sphere Correlation')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(t_nat,ln_nat)
title('Natural Sphere Correlation')
xlabel('Time (s)')
ylabel('Natural Log Function')

reg_for = polyfit(ln_for,t_for,1);
reg_nat = polyfit(ln_nat,t_nat,1);

%% h calc
h_forced = (rho*V*cp)/(abs(reg_for(1))*As)
h_natural = (rho*V*cp)/(abs(reg_nat(1))*As)


