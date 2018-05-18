function plot_tem(tem,rh,time,dateStr)
    global lengend_rect_inside;
    global figure_num;
    figure_num = figure_num +1;    
    figure('name',num2str(figure_num));
    %环境湿度
    min_rh = floor(min(rh))-1;max_rh = ceil(max(rh))+1;
    delta_rh = floor((max_rh - min_rh)/8);    
    %温度
    min_value = min(tem);
    max_value = max(tem);
    mean_value = mean(tem);
    std_value = std(tem);
    pp_value = max_value - min_value;
    temp_value = [mean_value;std_value;pp_value];
    save('checkdata_tem.mat', 'temp_value');
    min_tem = floor(min_value*100)/100;max_tem = ceil(max_value*100)/100;
    delta_tem = max_tem - min_tem;  
    %画图
    x_data = datenum(time);
    yyaxis left
    plot(x_data ,tem,'LineWidth',3,'Color',[0.4,0.4,0.4]);ylabel('环境温度/℃','color',[0.4,0.4,0.4]);    
    ylim([min_value min_tem + delta_tem]);
    set(gca,'ytick',min_tem:delta_tem/5:max_tem);
    yyaxis right
    plot(x_data ,rh,'LineWidth',3);  ylabel('相对湿度/%');
    ylim([min_rh,max_rh]);
    xtick_data = linspace(time(1),time(end),7);
    ax = gca;
    ax.XTick = datenum(xtick_data);
    datetick(ax,'x','HH:MM','keepticks');
    set(gca,'FontSize',14);
    xlabel('测量时间（时:分:秒）');
    lgd = legend('温度','相对湿度','Location',lengend_rect_inside);%
    lgd.FontSize = 15;
    title(['温湿度传感器测得的环境温湿度曲线（测量日期：',dateStr,'）'],'FontSize',14);
    grid on;
    set (gcf,'Position',[100,100,1000,800], 'color','w');
    hold off;
    save2word([dateStr,'report.doc'],['-f',num2str(figure_num)]);
end