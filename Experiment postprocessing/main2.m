warning('off','all');

min_layers = 7;
max_layers = 7;
offset = 0.13;
output_axis = 2;
isDiffRange = 1;
variance_min = 0.1;
variance_max = 2;
variance_num = 11;

datetimes = allDatetime();
datetimes = datetimes(randperm(length(datetimes)));

diff_var_avg_pair = zeros(1, variance_num);
diff_var_avg_nonpair = zeros(1, variance_num);

variance_range = linspace(variance_min, variance_max, variance_num);

for variance_index = 1:variance_num
    variance = variance_range(variance_index);
    disp(['Variance: ' num2str(variance)]);
    diffLayers(datetimes, min_layers, max_layers, offset, isDiffRange, variance);

    layers = linspace(min_layers, max_layers, max_layers-min_layers+1);
    all_sims = zeros(length(datetimes), length(datetimes), max_layers-min_layers+1);

    for i = 1:length(layers)
        all_sims(:,:,i) = nonParingCompare(offset, length(datetimes), min_layers, layers(i), output_axis);
    end

    avg_pair = zeros(length(layers), 1);
    avg_nonpair = zeros(length(layers), 1);

    for i = 1:length(layers)
        one_sim = all_sims(:,:,i);
        diag_sum = sum(diag(one_sim));
        sim_sum = sum(sum(one_sim));
        avg_pair(i) = diag_sum / length(datetimes);
        avg_nonpair(i) = (sim_sum - diag_sum) / (length(datetimes) * (length(datetimes) - 1));
        diff_var_avg_pair(variance_index) = avg_pair(i);
        diff_var_avg_nonpair(variance_index) = avg_nonpair(i);
    end
end