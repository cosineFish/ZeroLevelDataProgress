function plot_irt(irt,time,dateStr)
    global figure_num;
    figure_num = figure_num +1;    
    figure('name',num2str(figure_num));
    min_value = min(irt);
    max_value = max(irt);
%     mean_value = mean(irt);
%     std_value = std(irt);
%     pp_value = max_value - min_value;
    x_data = datenum(time);
    plot(x_data ,irt);
    ylim([(min_value - 0.5) (max_value + 0.5)]);   
    xtick_data = linspace(time(1),time(end),8);
    ax = gca;
    ax.XTick = datenum(xtick_data);
    datetick(ax,'x','HH:MM','keepticks');
    set(gca,'FontSize',14);
    ylabel('红外温度/\circC');
    xlabel('测量时间（时:分）');
    title(['红外温度曲线（测量日期：',dateStr,'）'],'FontSize',14);
    grid on;
    set (gcf,'Position',[100,100,1000,800], 'color','w');
    hold off;
    save2word([dateStr,'report.doc'],['-f',num2str(figure_num)]);
end