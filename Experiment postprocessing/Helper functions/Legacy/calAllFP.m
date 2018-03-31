warning('off','all');
UAVgravityFactor = 9.81;
offset = 0.13;
datetimes = allDatetime();
simularities = zeros(length(datetimes), 3);
for i = 1:length(datetimes)
    datetime = char(datetimes(i));
    disp(datetime);
    data = loadRealExperimentData(struct('datetime', {char(datetime)}, 'ch','80'), [], 2, 13, 30);
    for strAxCell = {'X', 'Y', 'Z'}
        strAx = strAxCell{:};
        % generate FP
        fp_UAV = genFingerPrint(UAVgravityFactor.*data.a_UAV.(strAx).measured);
        fp_cam = genFingerPrint(data.a_cam.(strAx).measured);
        if strAx == 'X'
            index = 1;
        elseif strAx == 'Y'
            index = 2;
        else
            index = 3;
        end
        % calculate simularity
        simularities(i, index) = calSimularity(data.a_UAV.(strAx).t, fp_UAV, fp_cam, offset);
    end
end

disp(simularities);