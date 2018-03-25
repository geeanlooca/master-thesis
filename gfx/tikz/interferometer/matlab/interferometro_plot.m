clear all
close all


external_clock = true;
if external_clock == true
    load interferometro_ext.mat
    plot_title = 'External Clock';
    Fs = 307;
else
    load interferometro_int.mat
    plot_title = 'Internal Clock';
    Fs = 500;
end


T = T1 * 1e6; % convert in microseconds
T = T - T(1); % normalize time to start at 0 microsecondsY1
Y = Y1;
spectr = 10*log10(abs(fftshift(fft(Y))).^2);
f = linspace(0, 1, length(spectr)) * Fs;

figure('Color', 'White', 'Position', [100 100 800 400]);
subplot(2,2,1);
plot(T, Y);
xlabel('Time [$\mu s$]', 'interpreter', 'latex');
ylabel('Amplitude [$V$]', 'interpreter', 'latex');
xlim([0 T(end)]);
title('Signal');

f_fft = linspace(-1, 1, length(spectr))*0.5*Fs;
subplot(2,2,3);
plot(f_fft, spectr);
%ylim([-30 80]);
xlim([0 0.5*Fs]);
xlabel('Frequency [MHz]');
title('FFT');

subplot(2,2, [2 4]);
[psd, w] = pwelch(Y);
f = w/pi * Fs/2;
plot(f, 10*log10(psd));
xlim([0 f(end)]);
xlabel('Frequency [MHz]');
title('Power Spectral Density');

annotation('textbox', [0 0.9 1 0.1], ...
    'color', 'red', ...
    'FontSize', 14, ...
    'String', plot_title, ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')
