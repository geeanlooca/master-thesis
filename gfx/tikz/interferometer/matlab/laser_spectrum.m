file = importdata('laser_spec_analyz.csv');
f = file.data(:, 1)/1e6;
spectrum_analyzer_data = file.data(:, 2);

figure('Name', 'Laser power spectrum', 'Color', 'White');
    plot(f, spectrum_analyzer_data);
    xlabel('Frequency [MHz]');
    ylabel('Magnitude [dBm]');    
    title('Laser output spectrum, after two 50/50 couplers, 100 avgs');
    
