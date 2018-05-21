function plot_v(Vol,receiver_name,time,dateStr)
    global figure_num;
    figure_num = figure_num +1;    
    figure('name',num2str(figure_num));
    x_data = datenum(time);
    min_value = min(Vol(:,1:8));
    max_value = max(Vol(:,1:8));
    Vol_aver = mean(Vol(:,1:8));
    Vol_std = std(Vol(:,1:8));
    Vol_pp = max_value(1:8) - min_value(1:8);
    v_gca = zeros(1,8);
    for i = 1:8
        subplot(4,2,i);%h(i) = subplot(4,2,i);
        plot(x_data ,Vol(:,i));
        v_gca(i) = gca;
        ylabel(['通道',num2str(i),'电压/V']);
        %set(gca,'FontSize',14);
        hold on;
        grid on;
    end
    xtick_data = linspace(time(1),time(end),4);
    Vol_delta = ceil(max(Vol_pp) * 1000) / 1000.0;
    for i = 1:8    
        minValue = floor(min_value(i)* 1000) / 1000.0;
        maxValue = minValue + Vol_delta;
        ylnew = [minValue  maxValue];
        set(v_gca(i), 'Ylim', ylnew);
        set(v_gca(i),'ytick',minValue:Vol_delta/5:maxValue);
        ax = v_gca(i);
        %ax.XTick = datenum(xtick_data);
        set(ax,'xtick',datenum(xtick_data));
        datetick(ax,'x','HH:MM','keepticks');
    end       
    suptitle([receiver_name,...
        '波段接收机各通道的电压曲线（测量日期：',dateStr,'）']);
    set (gcf,'Position',[100,100,1000,800], 'color','w');
    hold off;
    if receiver_name == 'K'
        Vol_dat_K = [Vol_aver;Vol_std;Vol_pp];
        save('checkdata_Vol.mat','Vol_dat_K');
    elseif receiver_name == 'V'
        Vol_dat_V = [Vol_aver;Vol_std;Vol_pp];
        save('checkdata_Vol.mat','Vol_dat_V','-append');
    end
    save2word([dateStr,'report.doc'],['-f',num2str(figure_num)]);
end