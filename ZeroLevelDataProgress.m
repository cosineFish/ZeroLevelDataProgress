clearvars;clc;
close all;%关闭所有figure窗口
format_data = '';
for i = 1:1:86
    format_data = strcat(format_data,'%f ');
end
[filename,filepath]=uigetfile('*.txt','打开文件');
complete_file = strcat(filepath,filename);
tic%启动秒表计时器
fidin = fopen(complete_file,'r+');
sourceData = textscan(fidin,format_data,'CommentStyle','#');
fclose(fidin);
column_length = length(sourceData{1});
%year = sourceData{1};month = sourceData{2};day = sourceData{3};
%hour = sourceData{4};minute = sourceData{5};second = sourceData{6};
time = datetime(sourceData{1},sourceData{2},sourceData{3},sourceData{4},sourceData{5},sourceData{6});
Irt = sourceData{9};Tem = sourceData{11};Rh = sourceData{12};
V_TEC1 = zeros(column_length,8);V_NTC = zeros(column_length,9);
V_TEC2 = zeros(column_length,9);
K_TEC = zeros(column_length,6);K_NTC = zeros(column_length,9);
Blackbody_T = zeros(column_length,5);
Space_T = zeros(column_length,2);
K_Vol = zeros(column_length,8);V_Vol = zeros(column_length,8);
for i = 1:4
    V_TEC1(:,i) = sourceData{12+i};
    V_NTC(:,i) = sourceData{16+i};
    V_TEC1(:,i+4) = sourceData{20+i};
    V_NTC(:,i+4) = sourceData{24+i};
end
for i = 1:5
    V_TEC2(:,i) = sourceData{28+i};
end
V_NTC(:,9) = sourceData{34};
Blackbody_T(:,1) = sourceData{35};%35对应黑体中心测温点
Space_T(:,1) = sourceData{36};
for i = 1:4
    V_TEC2(:,i+5) = sourceData{36+i};
end
for i = 1:4
    Blackbody_T(:,i+1) = sourceData{40+i};
    K_TEC(:,i) = sourceData{44+i};
    K_NTC(:,i) = sourceData{48+i};
end
K_TEC(:,5) = sourceData{53};
K_TEC(:,6) = sourceData{54};
for i = 1:5
    K_NTC(:,i+4) = sourceData{54+i};
end
Space_T(:,2) = sourceData{60};
for i = 1:8
    K_Vol(:,i) = sourceData{68+i};
    V_Vol(:,i) = sourceData{76+i};
end
waste_time = toc;%显示时间
max_temp = ceil(max(Tem(:)));min_temp = floor(min(Tem(:)));
delta_temp_tick = max_temp - min_temp;
save('envir_temp.mat','Tem','max_temp','min_temp','delta_temp_tick');
format_onlyDate = 'yymmdd';
startDate = datestr(time(1),format_onlyDate);startMonth = datestr(time(1),'yymm');
endDate = datestr(time(end),format_onlyDate);
if startDate == endDate
    dateStr = startDate;
else
    dateStr = [startDate,'~',endDate];
end
global figure_num;
figure_num = 0;
global legend_rect_outside;
global lengend_rect_inside;
legend_rect_outside = 'southeastoutside';
lengend_rect_inside = 'northeast';
%plot_tem(Tem,Rh,time,dateStr);
%plot_t_spaceAndBB(Blackbody_T,'blackbody',time,dateStr);
%plot_v(K_Vol,'K',time,dateStr);
%plot_v(V_Vol,'V',time,dateStr);
%画测温点温度曲线
global ylim_min;
ylim_min = 60;
plot_t(K_NTC,'K',time,dateStr);
ylim_min = 55;
plot_t(K_NTC,'K',time,dateStr);
ylim_min = 60;
plot_t(V_NTC,'V',time,dateStr);
%画控温点温度曲线
plot_t_tec(K_TEC,'K',time,dateStr); 
plot_t_tec(V_TEC1,'V1',time,dateStr); 
plot_t_tec(V_TEC2,'V2',time,dateStr);
%画空间点、黑体、黑体差值的温度曲线
plot_t_spaceAndBB(Space_T,'space',time,dateStr);
plot_t_spaceAndBB(Blackbody_T,'blackbody',time,dateStr);
%plot_deltaT_BB(Blackbody_T);
%画接收机输出电压曲线
K_Vol(:,5) = K_Vol(:,4);
plot_v(K_Vol,'K',time,dateStr);
plot_v(V_Vol,'V',time,dateStr);
%画红外曲线
plot_irt(Irt,time,dateStr);
%画环境温度曲线
plot_tem(Tem,Rh,time,dateStr);
%把表格保存到excel，注意excel文件太大（190KB左右）可能导致数据写不进去的情况
global positionRowNum;
positionRowNum = 0;
global rnames;
rnames = {'均值/℃','标准差/℃','峰峰值/℃'};
global sheetNum;
sheetNum = 1;
xlsFilePath = ['data_',startMonth,'.xls'];
saveTableData(dateStr,xlsFilePath);
system('taskkill /F /IM EXCEL.EXE');
%清除产生的mat文件
delete_mat();
close all;%关闭所有图像窗口