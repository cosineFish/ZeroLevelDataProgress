function plot_t_spaceAndBB(temperature,objection,time,dateStr)
    %�����µ��¶�ͼ  
    global figure_num;
    %global legend_rect_outside;
    global lengend_rect_inside;
    figure_num = figure_num +1;    
    figure('name',num2str(figure_num));
    color = {'-g','-r','-c','-b','-m','-y','-k','--r','--k'};
    if strcmp(objection, 'space')
        length = 1;%�����ռ��3
        for i = 1 : length
            space_temperature_aver(i) = mean(temperature(:,i));
            space_temperature_std(i) = std(temperature(:,i));
            space_max(i) = max(temperature(:,i));
            space_min(i) = min(temperature(:,i));
            space_temperature_pp(i) = space_max(i) - space_min(i);
        end
        dat_space_temperature = [space_temperature_aver;space_temperature_std;space_temperature_pp];
        save('checkdata_spaceAndBB.mat', 'dat_space_temperature');
        min_value = floor(min(space_min(:)));
        max_value = ceil(max(space_max(:)));
    elseif strcmp(objection, 'blackbody')
        length = 5;
        for i = 1 : length
            BB_temperature_aver(i) = mean(temperature(:,i));
            BB_temperature_std(i) = std(temperature(:,i));
            BB_max(i) = max(temperature(:,i));
            BB_min(i) = min(temperature(:,i));
            BB_temperature_pp(i) = BB_max(i) - BB_min(i);
        end
        dat_BB_temperature = [BB_temperature_aver;BB_temperature_std;BB_temperature_pp];
        if(exist('checkdata_spaceAndBB.mat','file')~=0)
            save('checkdata_spaceAndBB.mat', 'dat_BB_temperature','-append');
        else
            save('checkdata_spaceAndBB.mat', 'dat_BB_temperature');
        end
        min_value = floor(min(BB_min(:)));
        max_value = ceil(max(BB_max(:)));        
    end
%     delta_value = max_value - min_value;
%     if delta_value < 3
%         min_value = min_value - 4/2;max_value = min_value + 4;
%     elseif delta_value < 4
%         min_value = min_value - 1;max_value = min_value + 4;
%     end
    load('envir_temp.mat','Tem','max_temp','min_temp','delta_temp_tick');
    if delta_temp_tick < 3
        min_temp = min_temp - 4/2;max_temp = min_temp + 4;
        min_value = min_value - 4/2;max_value = min_value + 4;
    elseif delta_temp_tick < 4
        min_temp = min_temp - 1;max_temp = min_temp + 4;
        min_value = min_value - 1;max_value = min_value + 4;
    end      
    yyaxis left
    x_data = datenum(time);
    for i = 1:length
        plot(x_data , temperature(:,i) ,color{i},'LineWidth',3);
        hold on;
    end
    ylim([min_value,max_value ]);
    set(gca,'ytick',min_value:0.5:max_value);
    %ylim([17,21]);
    %set(gca,'ytick',17:0.5:21);
    ylabel('�¶�/\circC');
    set(gca,'FontSize',14);
    hold on;
    %�������¶�����
    yyaxis right
    plot(x_data ,Tem,'LineWidth',2,'Color',[0.4,0.4,0.4]);ylabel('�����¶�/��','color',[0.4,0.4,0.4]);    
    ylim([min_temp,max_temp]);
    xtick_data = linspace(time(1),time(end),7);
    ax = gca;
    ax.XTick = datenum(xtick_data);
    datetick(ax,'x','HH:MM','keepticks');
    if strcmp(objection,  'space')
        legend('�ռ��1','�����¶�',...
        'Location',lengend_rect_inside);
        title_string = '�ռ�';
    elseif strcmp(objection, 'blackbody')
        legend('�������Ĳ��µ�','������µ�1','������µ�2','������µ�3','������µ�4','�����¶�',...
        'Location',lengend_rect_inside);
        title_string = '�������';
    end
    xlabel('����ʱ�䣨ʱ:��:�룩');
    ylabel('�����¶�/\circC');
    title([title_string,'���¶ȣ��������ڣ�',dateStr,'��'],'FontSize',14);
    grid on;
    set (gcf,'Position',[100,100,1000,800], 'color','w');
    hold off;
    save2word([dateStr,'report.doc'],['-f',num2str(figure_num)]);
end