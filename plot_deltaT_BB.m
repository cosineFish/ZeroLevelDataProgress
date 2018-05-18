function plot_deltaT_BB(temperature)
    %画控温点温度图  
    global figure_num;
    global legend_rect_up;
    global lengend_rect_down;
    figure_num = figure_num +1;    
    sz = get(0,'screensize');
    figure('name',num2str(figure_num),'outerposition',sz);
    load checkdata_num.mat lineNum splitNum timeNum
    load('envir_temp.mat','Tem','max_temp','min_temp','delta_temp_tick');
    color = {'-g','-r','--c','-b','-m','-y','-k','--r','--k'};
    length = 5;
    for i = 1 : length
        deltaTemp(:,i) = temperature(:,i) - Tem';
        deltaBB_temp_aver(i) = mean(deltaTemp(:,i));
        deltaBB_temp_std(i) = std(deltaTemp(:,i));
        BB_max(i) = max(deltaTemp(:,i));
        BB_min(i) = min(deltaTemp(:,i));
        deltaBB_temp_pp(i) = BB_max(i) - BB_min(i);
    end
    dat_deltaBB_temperature = [deltaBB_temp_aver;deltaBB_temp_std;deltaBB_temp_pp];
    save('checkdata_deltaT_BB.mat', 'dat_deltaBB_temperature');
    min_value = floor(min(BB_min(:)));
    max_value = ceil(max(BB_max(:)));        
    if delta_temp_tick < 3
        min_temp = min_temp - 4/2;max_temp = min_temp + 4;
        min_value = min_value - 4/2;max_value = min_value + 4;
    elseif delta_temp_tick < 4
        min_temp = min_temp - 1;max_temp = min_temp + 4;
        min_value = min_value - 1;max_value = min_value + 4;
    end      
    for i = 1:length
        plot(1:1:lineNum , deltaTemp(:,i) ,color{i},'LineWidth',3);
        hold on;
    end
    global dateStr;
    load checkdata_xtick.mat xticklabel
    set(gca,'xtick',1:splitNum:timeNum*splitNum +1);
    set(gca,'xticklabel',xticklabel);
    ylim([min_value,max_value ]);
    set(gca,'ytick',min_value:0.5:max_value);
    ylabel('温度差值/\circC');
    set(gca,'FontSize',14);
    hold on;
    %画环境温度曲线
    yyaxis right
    plot(1:1:lineNum ,Tem,'LineWidth',3);ylabel('环境温度/℃');    
    ylim([min_temp,max_temp]);
    legend('黑体中心测温点','黑体测温点1','黑体测温点2','黑体测温点3','黑体测温点4','环境温度',...
        'Location',legend_rect_up);
    xlabel('测量时间（时:分:秒）');
    ylabel('环境温度/\circC');
    title(['黑体测温点温度与环境温度的差值（测量日期：',dateStr,'）'],'FontSize',14);
    hold off;
    save2word([dateStr,'report.doc'],['-f',num2str(figure_num)]);
end