function saveTableData(dateStr,xlsFilePath)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %������µ����ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    load checkdata_ntc.mat dat_K dat_V
    title = ['���ν��ջ����µ��¶�(��������:',dateStr,')'];
    cnames_K = {'���Ͻǵװ�','���߿�','���½ǵװ�',...
        '�з����','��Ƶ��','����Դ',...
        '���½ǵװ�','���Ͻǵװ�','��Ƶ���'};
    %write2xls(filePath , title , values , sheetName , length)
    write2xls(xlsFilePath,['K',title],cnames_K,dat_K,length(cnames_K));
    cnames_V = {'���߿�','����Դ','�з�','��Ƶ��',...
    '���Ͻǵװ�','��Ƶ��','���½�','�м�װ�',...
    '���Ͻ�'};
    write2xls(xlsFilePath,['V',title],cnames_V,dat_V,length(cnames_V));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %������µ����ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    load('checkdata_tec.mat', 'dat_K_TEC', 'dat_V1_TEC', 'dat_V2_TEC');
    cnames_K_TEC = {'���������','���������','ǰ�������',...
    '���������','���������','���������'};
    title = ['���ν��ջ����µ��¶�(��������:',dateStr,')'];
    write2xls(xlsFilePath,['K',title],cnames_K_TEC,dat_K_TEC,length(cnames_K_TEC));
    cnames_V_TEC1 = {'���µ�1','���µ�2','���µ�3','���µ�4',...
    '���µ�5','���µ�6','���µ�7','���µ�8'};
    write2xls(xlsFilePath,['V',title],cnames_V_TEC1,dat_V1_TEC,length(cnames_V_TEC1));
    cnames_V_TEC2 = {'���µ�9','���µ�10','���µ�11','���µ�12','���µ�14',...
    '���µ�15','���µ�16','���µ�17'};%,'���µ�13'
    dat_V2_TEC(:,5)=[];
    write2xls(xlsFilePath,['V',title],cnames_V_TEC2,dat_V2_TEC,length(cnames_V_TEC2));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�������Ϳռ�����ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    load('checkdata_spaceAndBB.mat', 'dat_space_temperature',...
        'dat_BB_temperature');
    cnames_space = {'�ռ��1'};
    title = ['�ռ���¶�(��������:',dateStr,')'];
    write2xls(xlsFilePath,title,cnames_space,dat_space_temperature,length(cnames_space));
    cnames_BB = {'��������','����1','����2','����3','����4'};
    title = ['�����¶�(��������:',dateStr,')'];
    write2xls(xlsFilePath,title,cnames_BB,dat_BB_temperature,length(cnames_BB));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��������ֵ���ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%     load('checkdata_deltaT_BB.mat', 'dat_deltaBB_temperature');
%     title = ['������µ��뻷���¶ȵĲ�ֵ(��������:',dateStr,')'];
%     write2xls(xlsFilePath,title,cnames_BB,dat_deltaBB_temperature,length(cnames_BB));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����ѹ���ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    load checkdata_Vol.mat Vol_dat_K Vol_dat_V
    for i = 1:8
        cnames_vol(i) = {['ͨ��',num2str(i)]};
    end
    title = ['���ν��ջ���ͨ����ѹ(��������:',dateStr,'��'];
    global rnames;
    rnames = {'��ֵ/V','��׼��/V','���ֵ/V'};%�޸ĵ�λ
    write2xls(xlsFilePath,['K',title],cnames_vol,Vol_dat_K,length(cnames_vol));
    write2xls(xlsFilePath,['V',title],cnames_vol,Vol_dat_V,length(cnames_vol));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����¶����ݱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    load('checkdata_tem.mat', 'temp_value');
    title = ['�����¶�(��������:',dateStr,'��'];
    cnames{1} = '�¶�';
    rnames = {'��ֵ/��','��׼��/��','���ֵ/��'};
    write2xls(xlsFilePath,title,cnames,temp_value,length(cnames));
end