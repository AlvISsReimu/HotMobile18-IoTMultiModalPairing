function fingerprint = genFingerPrint( data, min, max, layers, isDiffRange, variance )
    bounds = linspace(min, max, layers+1);
    each_length = zeros(1, layers);
    if isDiffRange == 1
        for i = 1:layers
            each_length(i)=normcdf(bounds(i+1),0,variance)-normcdf(bounds(i),0,variance);
        end
        each_length = 1./each_length;
        length_sum = sum(each_length);
        each_length = (max - min) .* each_length ./ length_sum;
        for i = 2:layers
           bounds(i) = bounds(i-1) + each_length(i-1);
        end
    end
    fingerprint = zeros(1, length(data));
    threshold = 0.1;
    for i = 1:length(data)
        if data(i) >= -threshold && data(i) <= threshold
            fingerprint(i) = -1;
            continue;
        elseif data(i) < bounds(1)
            fingerprint(i) = 0;
            continue;
        elseif data(i) >= bounds(length(bounds))
            fingerprint(i) = layers - 1;
            continue;
        end
        for j = 1:layers
            if data(i) >= bounds(j) && data(i) < bounds(j+1)
                fingerprint(i) = j - 1;
                break;
            end
        end
    end
end
