warning('off','all');

min_layers = 2;
max_layers = 50;
offset = 0.13;
output_layer = 7;
output_axis = 2;

datetimes = allDatetime();
datetimes = datetimes(randperm(length(datetimes)));

% diffLayers(datetimes, min_layers, max_layers, offset);
nonParingCompare(offset, length(datetimes), min_layers, output_layer, output_axis);