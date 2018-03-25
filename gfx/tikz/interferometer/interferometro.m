load interferometro.mat;
close all
N_int = length(interferometro.internalclock);
N_ext = length(interferometro.externalclock);

N_int_fft = 2^nextpow2(N_int);
N_ext_fft = 2^nextpow2(N_ext);

F_int = 500e6;
dt = 1/F_int;

F_ext = 306e6;


f_int = linspace(0, F_int/2, N_int_fft/2);
f_ext = linspace(0, F_ext/2, N_ext_fft/2);

w_int = blackmanharris(N_int);
Y_int = 2*fft(interferometro.internalclock .* w_int, N_int_fft) / N_int;
Y_int = Y_int(1:N_int_fft/2);

w_ext = blackmanharris(N_ext);
Y_ext = 2*fft(interferometro.externalclock .* w_ext, N_ext_fft) / N_ext;
Y_ext = Y_ext(1:N_ext_fft/2);


t_int = linspace(0, N_int*dt, N_int);
t_ext = linspace(0, 5e-6, N_ext);


figure;
plot(t_int*1e6, interferometro.internalclock, 'k');
axis tight;
xlabel('Time [us]');
ylabel('Voltage [V]');


figure;
plot(t_ext*1e6, interferometro.externalclock, 'k');
axis tight;
xlabel('Time [us]');
ylabel('Voltage [V]');


figure;
plot(f_int*1e-6, abs(Y_int)/ max(abs(Y_int)), 'k');
xlabel('Frequency [MHz]');
ylabel('Normalized FFT magnitude');
axis tight;

figure;
plot(f_ext*1e-6, abs(Y_ext)/max(abs(Y_ext)), 'k');
xlabel('Frequency [MHz]');
ylabel('Normalized FFT magnitude');
axis tight;
