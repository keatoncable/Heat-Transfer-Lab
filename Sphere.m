clear
clc
close all

%% Read in data
forced = importdata('Sphere_Forced_edit.txt');
natural = importdata('Sphere_Natural_edit.txt');
fcube = importdata('Cube_Forced_edit.txt');
ncube = importdata('Cube_Natural_edit.txt');

forced_rm = rmoutliers(forced,'mean');
natural_rm = rmoutliers(natural,'mean');
fcube_rm = rmoutliers(fcube,'mean');
ncube_rm = rmoutliers(ncube,'mean');

%% Constants
rho = 7930; %material: 304 SS
cp = 500;
d = 38.1/1000;
As = 4*pi/4*d^2;
V = 4/3*pi*(d/2)^3;

Acu = 6*(25.55/1000)^2;
Vcu = (25.55/1000)^3;

%% Sphere Regression with Outliers
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

%% Cube Regression with Outliers
lforcu = length(fcube(:,1));
lnatcu = length(ncube(:,1));
tofcu = fcube(1,2);
toncu = ncube(1,2);
tinf = 20;

ln_forcu = log((tofcu-tinf)./(fcube(:,2)-tinf));
ln_natcu = log((toncu-tinf)./(ncube(:,2)-tinf));
t_forcu = fcube(:,1);
t_natcu = ncube(:,1);

reg_forcu = polyfit(ln_forcu,t_forcu,1);
reg_natcu = polyfit(ln_natcu,t_natcu,1);
reg_forcu2 = polyfit(t_forcu,ln_forcu,1);
reg_natcu2 = polyfit(t_natcu,ln_natcu,1);

figure
hold on
plot(t_forcu,ln_forcu)
plot(10:1:1150,polyval(reg_forcu2,10:1:1150))
title('Forced Cube Correlation')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(t_natcu,ln_natcu)
title('Natural Cube Correlation')
xlabel('Time (s)')
ylabel('Natural Log Function')



%% Sphere Regression without Outliers
lfor_rm = length(forced_rm(:,1));
lnat_rm = length(natural_rm(:,1));
tof_rm = forced_rm(1,2);
ton_rm = natural_rm(1,2);
tinf = 20;

ln_for_rm = log((tof_rm-tinf)./(forced_rm(:,2)-tinf));
ln_nat_rm = log((ton_rm-tinf)./(natural_rm(:,2)-tinf));
t_for_rm = forced_rm(:,1);
t_nat_rm = natural_rm(:,1);

figure
plot(t_for_rm,ln_for_rm)
title('Forced Sphere Correlation without Outliers')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(t_nat_rm,ln_nat_rm)
title('Natural Sphere Correlation without Outliers')
xlabel('Time (s)')
ylabel('Natural Log Function')

reg_for_rm = polyfit(ln_for_rm,t_for_rm,1);
reg_nat_rm = polyfit(ln_nat_rm,t_nat_rm,1);

%% Cube Regression without Outliers
lforcu_rm = length(fcube_rm(:,1));
lnatcu_rm = length(ncube_rm(:,1));
tofcu_rm = fcube_rm(1,2);
toncu_rm = ncube_rm(1,2);
tinf = 20;

ln_forcu_rm = log((tofcu_rm-tinf)./(fcube_rm(:,2)-tinf));
ln_natcu_rm = log((toncu_rm-tinf)./(ncube_rm(:,2)-tinf));
t_forcu_rm = fcube_rm(:,1);
t_natcu_rm = ncube_rm(:,1);

figure
plot(t_forcu_rm,ln_forcu_rm)
title('Forced Cube Correlation without Outliers')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(t_natcu_rm,ln_natcu_rm)
title('Natural Cube Correlation without Outliers')
xlabel('Time (s)')
ylabel('Natural Log Function')

reg_forcu_rm = polyfit(ln_forcu_rm,t_forcu_rm,1);
reg_natcu_rm = polyfit(ln_natcu_rm,t_natcu_rm,1);

%% h calc
h_forced = (rho*V*cp)/(abs(reg_for(1))*As)
h_natural = (rho*V*cp)/(abs(reg_nat(1))*As)
h_forced_cu = (rho*Vcu*cp)/(abs(reg_forcu(1))*Acu)
h_natural_cu = (rho*Vcu*cp)/(abs(reg_natcu(1))*Acu)

h_forced_rm = (rho*V*cp)/(abs(reg_for_rm(1))*As)
h_natural_rm = (rho*V*cp)/(abs(reg_nat_rm(1))*As)
h_forced_cu_rm = (rho*Vcu*cp)/(abs(reg_forcu_rm(1))*Acu)
h_natural_cu_rm = (rho*Vcu*cp)/(abs(reg_natcu_rm(1))*Acu)


