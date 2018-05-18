function saveTableData(dateStr,xlsFilePath)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存测温点数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    load checkdata_ntc.mat dat_K dat_V
    title = ['波段接收机测温点温度(测量日期:',dateStr,')'];
    cnames_K = {'左上角底板','天线口','左下角底板',...
        '中放面板','混频器','噪声源',...
        '右下角底板','右上角底板','中频输出'};
    %write2xls(filePath , title , values , sheetName , length)
    write2xls(xlsFilePath,['K',title],cnames_K,dat_K,length(cnames_K));
    cnames_V = {'天线口','噪声源','中放','混频器',...
    '左上角底板','倍频器','右下角','中间底板',...
    '右上角'};
    write2xls(xlsFilePath,['V',title],cnames_V,dat_V,length(cnames_V));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存控温点数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    load('checkdata_tec.mat', 'dat_K_TEC', 'dat_V1_TEC', 'dat_V2_TEC');
    cnames_K_TEC = {'上面板中心','左面板中心','前面板中心',...
    '右面板中心','后面板中心','下面板中心'};
    title = ['波段接收机控温点温度(测量日期:',dateStr,')'];
    write2xls(xlsFilePath,['K',title],cnames_K_TEC,dat_K_TEC,length(cnames_K_TEC));
    cnames_V_TEC1 = {'控温点1','控温点2','控温点3','控温点4',...
    '控温点5','控温点6','控温点7','控温点8'};
    write2xls(xlsFilePath,['V',title],cnames_V_TEC1,dat_V1_TEC,length(cnames_V_TEC1));
    cnames_V_TEC2 = {'控温点9','控温点10','控温点11','控温点12','控温点14',...
    '控温点15','控温点16','控温点17'};%,'控温点13'
    dat_V2_TEC(:,5)=[];
    write2xls(xlsFilePath,['V',title],cnames_V_TEC2,dat_V2_TEC,length(cnames_V_TEC2));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存黑体和空间点数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    load('checkdata_spaceAndBB.mat', 'dat_space_temperature',...
        'dat_BB_temperature');
    cnames_space = {'空间点1'};
    title = ['空间点温度(测量日期:',dateStr,')'];
    write2xls(xlsFilePath,title,cnames_space,dat_space_temperature,length(cnames_space));
    cnames_BB = {'黑体中心','黑体1','黑体2','黑体3','黑体4'};
    title = ['黑体温度(测量日期:',dateStr,')'];
    write2xls(xlsFilePath,title,cnames_BB,dat_BB_temperature,length(cnames_BB));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存黑体差值数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%     load('checkdata_deltaT_BB.mat', 'dat_deltaBB_temperature');
%     title = ['黑体测温点与环境温度的差值(测量日期:',dateStr,')'];
%     write2xls(xlsFilePath,title,cnames_BB,dat_deltaBB_temperature,length(cnames_BB));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存电压数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    load checkdata_Vol.mat Vol_dat_K Vol_dat_V
    for i = 1:8
        cnames_vol(i) = {['通道',num2str(i)]};
    end
    title = ['波段接收机各通道电压(测量日期:',dateStr,'）'];
    global rnames;
    rnames = {'均值/V','标准差/V','峰峰值/V'};%修改单位
    write2xls(xlsFilePath,['K',title],cnames_vol,Vol_dat_K,length(cnames_vol));
    write2xls(xlsFilePath,['V',title],cnames_vol,Vol_dat_V,length(cnames_vol));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %保存温度数据表格
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    load('checkdata_tem.mat', 'temp_value');
    title = ['环境温度(测量日期:',dateStr,'）'];
    cnames{1} = '温度';
    rnames = {'均值/℃','标准差/℃','峰峰值/℃'};
    write2xls(xlsFilePath,title,cnames,temp_value,length(cnames));
end