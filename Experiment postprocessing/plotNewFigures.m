datetime = '2017-10-11 19-57-36';
isPlotWave = 1;
isPlotFP = 1;
offset = 0.13;
layers = 7;

data = loadRealExperimentData(struct('datetime',{datetime}, 'ch','80'), [], 2, 13, 30);
UAVgravityFactor = 9.81;

% for strAxCell = {'X', 'Y', 'Z'}
for strAxCell = {'Y'}
	strAx = strAxCell{:};
    
    % generate FP
    max_UAV = max(UAVgravityFactor.*data.a_UAV.(strAx).measured);
    min_UAV = min(UAVgravityFactor.*data.a_UAV.(strAx).measured);
    max_cam = max(data.a_cam.(strAx).measured);
    min_cam = min(data.a_cam.(strAx).measured);
%     max_all = max(max_UAV, max_cam);
    max_all = 3;
%     min_all = min(min_UAV, min_cam);
    min_all = -3;
    
    fp_UAV = genFingerPrint(UAVgravityFactor.*data.a_UAV.(strAx).measured, min_all, max_all, layers);
    fp_cam = genFingerPrint(data.a_cam.(strAx).measured, min_all, max_all, layers);
    
    % calculate simularity
    sim.(strAx) = calSimularity(data.a_UAV.(strAx).t, fp_UAV, fp_cam, offset);
    
    if isPlotWave == 1
        figure;
        title(strAx);
        hold on;
        % a_UAV
%         plot(data.a_UAV.(strAx).t - offset, UAVgravityFactor.*data.a_UAV.(strAx).measured, 'r', 'LineWidth',1);
        % a_cam
        plot(data.a_cam.(strAx).t, data.a_cam.(strAx).measured, 'b', 'LineWidth',1);
        legend('a_{UAV},raw', 'a_{UAV},filt', 'a_{cam}');
    end
	
    if isPlotFP == 1
        figure;
        title('FP_' + strAx);
        hold on;
    %     fp_UAV
%         plot(data.a_UAV.(strAx).t + offset, fp_UAV, 'r', 'LineWidth',1);
    %     fp_cam
        plot(data.a_cam.(strAx).t, fp_cam, 'b', 'LineWidth',1);
        legend('fp_{UAV}', 'fp_{cam}');
    end
end

disp(sim);