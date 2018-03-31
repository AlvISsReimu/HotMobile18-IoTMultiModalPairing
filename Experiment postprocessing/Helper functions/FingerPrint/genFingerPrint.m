function fingerprint = genFingerPrint( data, min, max, layers )
    bounds = linspace(min, max, layers+1);
    fingerprint = zeros(1, length(data));
    for i = 1:length(data)
        for j = 1:layers
            if data(i) >= bounds(j) && data(i) < bounds(j+1)
                fingerprint(i) = j - 1;
                break;
            elseif data(i) == bounds(j)
                fingerprint(i) = j;
            end
        end
    end
end
