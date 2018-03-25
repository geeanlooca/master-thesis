clear all
close all
load sample_arm_calibration\internal_clock.mat


%% Load data
T_int = T1 * 1e6; % convert in microseconds
T_int = T_int - T_int(1); % normalize time to start at 0 microsecondsY1
Y_int = Y1;
spectr_int = 10*log10(abs(fft(Y_int)).^2);
[psd_int, w_int] = pwelch(Y_int); % compute PSD
f_int = w_int/pi * 500/2;


load sample_arm_calibration\external_clock.mat
T_ext = T10 * 1e6; % convert in microseconds
T_ext = T_ext - T_ext(1); % normalize time to start at 0 microsecondsY1
Y_ext = Y10;

w = hanning(length(Y_ext));


Y_ext = Y_ext - mean(Y_ext); % remove DC component
spectr_ext = 10*log10(abs(fft(Y_ext)).^2);
[psd_ext, w_ext] = pwelch(Y_ext); % compute PSD
f_ext = w_ext/pi * 307/2;


%% Plot
figure('Name', 'Reference Arm Calibration', 'Color', 'White', 'Position', [100 100 800 400]);; % open figure

subplot(2,2,1); % first subplot (top left)
plot(T_int, Y_int) % plot signal in time domain (internal clock @500MHz)
xlabel('Time [$\mu s$]', 'interpreter', 'latex');
ylabel('Amplitude [$V$]', 'interpreter', 'latex');
xlim([0 T_ext(end)]);
title('Time domain');

subplot(2,2,2); % second subplot (top right)
plot(f_int, 10*log10(psd_int)); % plot PSD
xlim([f_int(1), f_ext(end)]);
ylim([-80 -20]);
xlabel('Frequency [MHz]');
title('Power Spectral Density');

% plot(spectr_int);
% ylim([-50 20]);
% xlim([0 length(spectr_int)/2]);

subplot(2,2,3);
plot(T_ext, Y_ext)
xlabel('Time [$\mu s$]', 'interpreter', 'latex');
ylabel('Amplitude [$V$]', 'interpreter', 'latex');
xlim([0 T_int(end)]);

subplot(2,2,4);
plot(f_ext, 10*log10(psd_ext));
xlim([f_ext(1), f_ext(end)]);
xlabel('Frequency [MHz]');
% xlim([0 length(spectr_ext)/2]);
% ylim([-50 20]);

annotation('textbox', [0 0.9 1 0.1], ...
    'color', 'red', ...
    'FontSize', 14, ...
    'String', 'Internal Clock', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')
annotation('textbox', [0.0 0.45 1 0.1], ...
    'color', 'red', ...
    'FontSize', 14, ...
    'String', 'External Clock', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')
