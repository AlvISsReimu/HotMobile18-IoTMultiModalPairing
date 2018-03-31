function sim = calSimularity( t, UAV, cam, offset )
    off = 0;
    for i = 1:length(t)
        if t(i) <= offset
            off = off + 1;
        else
            break;
        end
    end
    same = 0;
    max_length = max(length(UAV)-off, length(cam));
    for i = 1:max_length
        if i > length(cam) || i+off > length(UAV)
            break;
        end
        if cam(i) == UAV(i+off)
            same = same + 1;
        end
    end
%     disp(['l_UAV: ' num2str(length(UAV)) ' l_cam: ' num2str(length(cam)) ' same: ' num2str(same)]);
    sim = same / max_length;
end

