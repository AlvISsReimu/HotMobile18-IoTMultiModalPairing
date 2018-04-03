warning('off','all');

min_layers = 7;
max_layers = 7;
offset = 0.13;
output_axis = 2;
isDiffRange = 0;
variance = 5;

datetimes = allDatetime();
datetimes = datetimes(randperm(length(datetimes)));

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
    
%     squre_sum_nonpair = 0;
%     for j = 1:length(datetimes)
%         for k = 1:length(datetimes)
%             if j ~= k
%                 squre_sum_nonpair = squre_sum_nonpair + (avg_pair(i)-one_sim(j,k))^2;
%             end
%         end
%     end
%     square_avg_nonpair(i) = squre_sum_nonpair/ (length(datetimes) * (length(datetimes) - 1));
end
dist = avg_pair - avg_nonpair;
prop = avg_pair./max(avg_nonpair, 0.2);
