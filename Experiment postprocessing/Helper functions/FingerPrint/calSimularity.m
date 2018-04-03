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
    zero_num = 0;
    max_length = max(length(UAV)-off, length(cam));
    for i = 1:max_length
        if i > length(cam) || i+off > length(UAV)
            break;
        end
        if cam(i) == -1 && UAV(i+off) == -1
            same = same + 1;
            zero_num = zero_num + 1;
        elseif cam(i) == UAV(i+off)
            same = same + 1;
        elseif abs(cam(i) - UAV(i+off)) == 1
            same = same + 0.5;
        end
    end
%     disp(['l_UAV: ' num2str(length(UAV)) ' l_cam: ' num2str(length(cam)) ' zero: ' num2str(zero_num) ' same: ' num2str(same)]);
    sim = same / (max_length);
end
