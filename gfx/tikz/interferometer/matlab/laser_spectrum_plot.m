clear all;
close all;

data = csvread('laser_spectrum_1nmres.csv');
lambda = data(:, 1);
p = data(:, 2);

figure('Color', 'White');
    plot(lambda, p);
    xlabel('$\lambda$ [nm]', 'interpreter', 'latex');
    ylabel('Power [dBm]', 'interpreter', 'latex');
    ylim([-40, -5]);
    title('Source spectrum');

data = csvread('laser_spectrum_1nm.csv');
lambda2 = data(:, 1);
p = data(:, 2);
figure('Color', 'White');
    plot(lambda2, p, 'k');
    ylim([-40, -5]);
    xlabel('$\lambda$ [nm]', 'interpreter', 'latex');
    ylabel('Power [dBm]', 'interpreter', 'latex');
    title('Source spectrum');
    
    
    