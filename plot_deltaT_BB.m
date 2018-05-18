function plot_deltaT_BB(temperature)
    %�����µ��¶�ͼ  
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
    ylabel('�¶Ȳ�ֵ/\circC');
    set(gca,'FontSize',14);
    hold on;
    %�������¶�����
    yyaxis right
    plot(1:1:lineNum ,Tem,'LineWidth',3);ylabel('�����¶�/��');    
    ylim([min_temp,max_temp]);
    legend('�������Ĳ��µ�','������µ�1','������µ�2','������µ�3','������µ�4','�����¶�',...
        'Location',legend_rect_up);
    xlabel('����ʱ�䣨ʱ:��:�룩');
    ylabel('�����¶�/\circC');
    title(['������µ��¶��뻷���¶ȵĲ�ֵ���������ڣ�',dateStr,'��'],'FontSize',14);
    hold off;
    save2word([dateStr,'report.doc'],['-f',num2str(figure_num)]);
end