clear
clc
close all

%% Read in data
forced = importdata('Sphere_Forced_edit.txt');
natural = importdata('Sphere_Natural_edit.txt');

%% Regression
lfor = length(forced(:,1));
lnat = length(natural(:,1));
tof = forced(1,2);
ton = natural(1,2);
tinf = 20;

ln_for = log((tof-tinf)./((forced(:,2)-tinf)));
ln_nat = log((ton-tinf)./(natural(:,2)-tinf));
t_for = forced(:,1);
t_nat = natural(:,1);

figure
plot(t_for,ln_for)
figure
plot(t_nat,ln_nat)
