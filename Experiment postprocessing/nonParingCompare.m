function z = nonParingCompare(offset, filenum, min_layers, output_layer, output_axis)
    load varibles.mat;
    for i = 1:filenum
        for j = 1:filenum
            fp_cam = fps_cam{i,output_layer-min_layers+1,output_axis};
            fp_UAV = fps_UAV{j,output_layer-min_layers+1,output_axis};
            if size(time{i}) >= size(time{j})
                max_time = time{i};
            else
                max_time = time{j};
            end
            sim = calSimularity(max_time, fp_UAV, fp_cam, offset);
            disp([num2str(i) '&' num2str(j) ': ' num2str(sim)]);
            z(i,j) = sim;
        end
    end
    
    figure;
    imagesc(z);
    axis xy;
    set(gca,'CLim',[0,1]);
    colorbar;
    title([num2str(output_layer) 'layers']);

    % x = linspace(1,filenum,filenum);
    % y = linspace(1,filenum,filenum);
    % X = reshape(meshgrid(x,x)', 1, filenum*filenum);
    % Y = reshape(meshgrid(x,x), 1, filenum*filenum);
    % Z = reshape(z, 1, filenum*filenum);
    % figure;
    % [newX,newY,newZ]=griddata(X,Y,Z,linspace(1,filenum)',linspace(1,filenum),'v4');
    % pcolor(newX,newY,newZ);
    % shading interp;
    % colorbar;
    clear i j fp_cam fp_UAV max_time;
end