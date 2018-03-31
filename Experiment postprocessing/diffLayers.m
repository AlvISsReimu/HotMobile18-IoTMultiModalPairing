function diffLayers( datetimes, min_layers, max_layers, offset )

    UAVgravityFactor = 9.81;

    fps_UAV = cell(length(datetimes), max_layers - min_layers + 1, 3); % fps(file, layer, axis)
    fps_cam = cell(length(datetimes), max_layers - min_layers + 1, 3);
    results = zeros(length(datetimes), max_layers - min_layers + 1, 3); % results(file, layer, axis)

    for i = 1:length(datetimes)
        disp(['Experiment ' num2str(i)]);
        datetime = char(datetimes(i));
        disp(['    Datetime: ' datetime]);
        data = loadRealExperimentData(struct('datetime', {char(datetime)}, 'ch','80'), [], 2, 13, 30);
        layers = min_layers;
        while layers <= max_layers
            for strAxCell = {'X', 'Y', 'Z'}
                strAx = strAxCell{:};
                if strAx == 'X'
                    index = 1;
                elseif strAx == 'Y'
                    index = 2;
                else
                    index = 3;
                end
                max_UAV = max(data.a_UAV.(strAx).measured);
                min_UAV = min(data.a_UAV.(strAx).measured);
                max_cam = max(data.a_cam.(strAx).measured);
                min_cam = min(data.a_cam.(strAx).measured);
    %             max_all = max(max_UAV * UAVgravityFactor, max_cam);
                max_all = 3;
                min_all = -3;
    %             min_all = min(min_UAV * UAVgravityFactor, min_cam);
                % generate FP
                fp_UAV = genFingerPrint(UAVgravityFactor.*data.a_UAV.(strAx).measured, min_all, max_all, layers);
                fp_cam = genFingerPrint(data.a_cam.(strAx).measured, min_all, max_all, layers);
                % write into fps
                fps_UAV{i, layers-min_layers+1, index} = fp_UAV;
                fps_cam{i, layers-min_layers+1, index} = fp_cam;
                % calculate simularity
                sim = calSimularity(data.a_UAV.(strAx).t, fp_UAV, fp_cam, offset);
                % write into results
                results(i, layers-min_layers+1, index) = sim;
                % write into time
                time{i} = data.a_UAV.(strAx).t;
            end
            disp(['    sim on ' num2str(layers) ' layers: X ' num2str(results(i, layers-min_layers+1, 1)) ...
                ' Y ' num2str(results(i, layers-min_layers+1, 2)) ...
                ' Z ' num2str(results(i, layers-min_layers+1, 3))]);
            layers = layers + 1;
        end
    end
    % clear var
    clear data datetime datetimes fp_cam fp_UAV i index layers max_cam max_UAV min_cam min_UAV sim strAx strAxCell UAVgravityFactor max_layers min_layers offset max_all min_all;
    % save var
    save varibles time results fps_UAV fps_cam;
end