clear
clc
close all

%% Read in data

forced = importdata('Sphere_Forced_edit.txt');
natural = importdata('Sphere_Natural_edit.txt');
fcube = importdata('Cube_Forced_edit.txt');
ncube = importdata('Cube_Natural_edit.txt');

%% Constants
rho = 7930; %material: 304 SS
cp = 500;
d = 38.1/1000;
As = 4*pi/4*d^2;
V = 4/3*pi*(d/2)^3;

Acu = 6*(25.55/1000)^2;
Vcu = (25.55/1000)^3;

%% Sphere Regression
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

%% Cube Regression
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
outs = [];
timesto = [];
filt = [];

lfor_rm = length(forced(:,1));
lnat_rm = length(natural(:,1));
tof_rm = forced(1,2);
ton_rm = natural(1,2);
tinf = 20;

ln_for_rm = log((tof_rm-tinf)./(forced(:,2)-tinf));
ln_nat_rm = log((ton_rm-tinf)./(natural(:,2)-tinf));
t_for_rm = forced(:,1);
t_nat_rm = natural(:,1);

for i = 7:(length(ln_for_rm)-7)
    window = ln_for_rm(i-5:i+5);
    time = forced(i-5:i+5,1);
    std_fcu = std(ln_for_rm(i-5:i+5));
    mean_fcu = mean(ln_for_rm(i-5:i+5));
    lwin = length(window);
        if window(6)>=(mean_fcu+std_fcu) || window(6)<=(mean_fcu-std_fcu)
            outs = [outs window(6)];
        else
            timesto = [timesto ; time(6)];
            filt = [filt ;  window(6)];
        end
end

forced_filt = [timesto, filt];

figure
plot(t_for_rm,ln_for_rm)
title('Forced Sphere Correlation without Outliers')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(timesto,filt)
title('Forced Sphere Correlation, Filtered')
xlabel('Time (s)')
ylabel('Natural Log Function')


figure
plot(t_nat_rm,ln_nat_rm)
title('Natural Sphere Correlation without Outliers')
xlabel('Time (s)')
ylabel('Natural Log Function')

reg_for_rm = polyfit(ln_for_rm,t_for_rm,1);
reg_nat_rm = polyfit(ln_nat_rm,t_nat_rm,1);

reg_forced_filt = polyfit(filt,timesto,1);

%% Cube Regression without Outliers
outs = [];
timesto = [];
filt = [];

lforcu_rm = length(fcube(:,1));
lnatcu_rm = length(ncube(:,1));
tofcu_rm = fcube(1,2);
toncu_rm = ncube(1,2);
tinf = 20;

ln_forcu_rm = log((tofcu_rm-tinf)./(fcube(:,2)-tinf));
ln_natcu_rm = log((toncu_rm-tinf)./(ncube(:,2)-tinf));
t_forcu_rm = fcube(:,1);
t_natcu_rm = ncube(:,1);

for i = 7:(length(ln_forcu_rm)-7)
    window = ln_forcu_rm(i-5:i+5);
    time = fcube(i-5:i+5,1);
    std_fcu = std(ln_forcu_rm(i-5:i+5));
    mean_fcu = mean(ln_forcu_rm(i-5:i+5));
    lwin = length(window);
        if window(6)>=(mean_fcu+std_fcu/6) || window(6)<=(mean_fcu-std_fcu)
            outs = [outs window(6)];
        else
            timesto = [timesto ; time(6)];
            filt = [filt ;  window(6)];
        end
end

forcu_filt = [timesto, filt];

figure
plot(t_forcu_rm,ln_forcu_rm)
title('Forced Cube Correlation without Outliers')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(timesto,filt)
title('Forced Cube Correlation, Filtered')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(t_natcu_rm,ln_natcu_rm)
title('Natural Cube Correlation without Outliers')
xlabel('Time (s)')
ylabel('Natural Log Function')

reg_forcu_rm = polyfit(ln_forcu_rm,t_forcu_rm,1);
reg_natcu_rm = polyfit(ln_natcu_rm,t_natcu_rm,1);

reg_forcu_filt = polyfit(filt,timesto,1);

%% h calc
h_forced_sph = (rho*V*cp)/(abs(reg_for(1))*As)
h_natural_sph = (rho*V*cp)/(abs(reg_nat(1))*As)
h_forced_cu = (rho*Vcu*cp)/(abs(reg_forcu(1))*Acu)
h_natural_cu = (rho*Vcu*cp)/(abs(reg_natcu(1))*Acu)

h_forced_rm_sph = (rho*V*cp)/(abs(reg_for_rm(1))*As)
h_natural_rm_sph = (rho*V*cp)/(abs(reg_nat_rm(1))*As)
h_forced_cu_rm = (rho*Vcu*cp)/(abs(reg_forcu_rm(1))*Acu)
h_natural_cu_rm = (rho*Vcu*cp)/(abs(reg_natcu_rm(1))*Acu)

h_forcu_filt = (rho*Vcu*cp)/(abs(reg_forcu_filt(1))*Acu)
h_forced_filt = (rho*V*cp)/(abs(reg_forced_filt(1))*As)

%% Different Filters
outs = [];
timesto = [];
filt = [];

lforcu_rm = length(fcube(:,1));
lnatcu_rm = length(ncube(:,1));
tofcu_rm = fcube(1,2);
toncu_rm = ncube(1,2);
tinf = 20;

ln_forcu_rm = log((tofcu_rm-tinf)./(fcube(:,2)-tinf));
ln_natcu_rm = log((toncu_rm-tinf)./(ncube(:,2)-tinf));
t_forcu_rm = fcube(:,1);
t_natcu_rm = ncube(:,1);

for i = 7:(length(ln_forcu_rm)-7)
    window = ln_forcu_rm(i-5:i+5);
    time = fcube(i-5:i+5,1);
    std_fcu = std(ln_forcu_rm(i-5:i+5));
    mean_fcu = mean(ln_forcu_rm(i-5:i+5));
    lwin = length(window);
        if window(6)>=(mean_fcu+std_fcu/2) || window(6)<=(mean_fcu-std_fcu)
            outs = [outs window(6)];
        else
            timesto = [timesto ; time(6)];
            filt = [filt ;  window(6)];
        end
end
forcu_filt_2 = [timesto, filt];

outs = [];
timesto = [];
filt = [];


for i = 7:(length(ln_forcu_rm)-7)
    window = ln_forcu_rm(i-5:i+5);
    time = fcube(i-5:i+5,1);
    std_fcu = std(ln_forcu_rm(i-5:i+5));
    mean_fcu = mean(ln_forcu_rm(i-5:i+5));
    lwin = length(window);
        if window(6)>=(mean_fcu+std_fcu/4) || window(6)<=(mean_fcu-std_fcu)
            outs = [outs window(6)];
        else
            timesto = [timesto ; time(6)];
            filt = [filt ;  window(6)];
        end
end
forcu_filt_4 = [timesto, filt];

outs = [];
timesto = [];
filt = [];


for i = 7:(length(ln_forcu_rm)-7)
    window = ln_forcu_rm(i-5:i+5);
    time = fcube(i-5:i+5,1);
    std_fcu = std(ln_forcu_rm(i-5:i+5));
    mean_fcu = mean(ln_forcu_rm(i-5:i+5));
    lwin = length(window);
        if window(6)>=(mean_fcu+std_fcu/6) || window(6)<=(mean_fcu-std_fcu)
            outs = [outs window(6)];
        else
            timesto = [timesto ; time(6)];
            filt = [filt ;  window(6)];
        end
end
forcu_filt_6 = [timesto, filt];

outs = [];
timesto = [];
filt = [];


for i = 7:(length(ln_forcu_rm)-7)
    window = ln_forcu_rm(i-5:i+5);
    time = fcube(i-5:i+5,1);
    std_fcu = std(ln_forcu_rm(i-5:i+5));
    mean_fcu = mean(ln_forcu_rm(i-5:i+5));
    lwin = length(window);
        if window(6)>=(mean_fcu+std_fcu/10) || window(6)<=(mean_fcu-std_fcu)
            outs = [outs window(6)];
        else
            timesto = [timesto ; time(6)];
            filt = [filt ;  window(6)];
        end
end
forcu_filt_10 = [timesto, filt];

figure
plot(forcu_filt_2(:,1),forcu_filt_2(:,2))
title('Forced Cube Correlation, Filtered, Std. Dev./2')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(forcu_filt_4(:,1),forcu_filt_4(:,2))
title('Forced Cube Correlation, Filtered, Std. Dev./4')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(forcu_filt_6(:,1),forcu_filt_6(:,2))
title('Forced Cube Correlation, Filtered, Std. Dev./6')
xlabel('Time (s)')
ylabel('Natural Log Function')

figure
plot(forcu_filt_10(:,1),forcu_filt_10(:,2))
title('Forced Cube Correlation, Filtered, Std. Dev./10')
xlabel('Time (s)')
ylabel('Natural Log Function')

reg_2 = polyfit(forcu_filt_2(:,2),forcu_filt_2(:,1),1);
reg_4 = polyfit(forcu_filt_4(:,2),forcu_filt_4(:,1),1);
reg_6 = polyfit(forcu_filt_6(:,2),forcu_filt_6(:,1),1);
reg_10 = polyfit(forcu_filt_10(:,2),forcu_filt_10(:,1),1);

h_2 = (rho*Vcu*cp)/(abs(reg_2(1))*Acu)
h_4 = (rho*Vcu*cp)/(abs(reg_4(1))*Acu)
h_6 = (rho*Vcu*cp)/(abs(reg_6(1))*Acu)
h_10 = (rho*Vcu*cp)/(abs(reg_10(1))*Acu)



