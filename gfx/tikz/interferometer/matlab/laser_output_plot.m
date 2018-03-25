clear all
close all
load sample_arm_calibration\laser_output.mat

T1 = T1 * 1e6; % convert in microseconds
T1 = T1 - T1(1); % normalize time to start at 0 microseconds

p_out = -4*Y1;

figure;
plot(T1, p_out);
xlabel('Time [$\mu s$]', 'interpreter', 'latex');
ylabel('Amplitude [$V$]', 'interpreter', 'latex');

fft_length = length(p_out)/2;
Fs = 500;
f = linspace(0, Fs/2, fft_length);
P_out = 10*log10(abs(fft(p_out)).^2);
P_out = P_out(1:fft_length);

figure;
    plot(f, P_out);
    xlabel('Frequency [MHz]');
    ylabel('FFT magnitude [dB]');
    xlim([0 20]);
    
figure;
pwelch(p_out);

file = importdata('laser_spec_analyz.csv')
f = file.data(:, 1)/1e6;
spectrum_analyzer_data = file.data(:, 2);

figure;
plot(f, spectrum_analyzer_data);
xlabel('Frequency [MHz]');
ylabel('Magnitude [dB]');