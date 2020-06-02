function [info] = parse_params_old(info)

%Scan ticker file       
file_params = 'C:/Users/Zato/Desktop/AMMO/get/params.csv';
    fid = fopen(file_params);
    if (fid ~= -1)
        params = textscan(fid,'%s %f','Delimiter',',','Headerlines',1);
    fclose(fid);
    end
    
%Initialize Params
    info.params = [];
    
%Start assigning params
    info.params.trigger_pctb_high = params{1,2}(1,1);
    info.params.trigger_pctb_low = params{1,2}(2,1);
    info.params.trigger_so_fastpctd_high = params{1,2}(3,1);
    info.params.trigger_so_fastpctd_low = params{1,2}(4,1);
    info.params.trigger_aroon_oscillator_high = params{1,2}(5,1);
    info.params.trigger_aroon_oscillator_low = params{1,2}(6,1);
    info.params.so_fk_period = params{1,2}(7,1);
    info.params.so_sk_period = params{1,2}(8,1);
    info.params.so_sd_period = params{1,2}(9,1);
    info.params.so_above_thres = params{1,2}(10,1);
    info.params.so_below_thres = params{1,2}(11,1);
    info.params.ma_iii_value = params{1,2}(12,1);
    info.params.ma_c_value = params{1,2}(13,1);
    info.params.ma_cc_value = params{1,2}(14,1);
    info.params.ma_c_short = params{1,2}(15,1);
    info.params.ma_cc_short = params{1,2}(16,1);
    info.params.level_period = params{1,2}(17,1);
    info.params.atr_period = params{1,2}(18,1);
    info.params.aroon_period = params{1,2}(19,1);
    info.params.aroon_high_thres = params{1,2}(20,1);
    info.params.aroon_low_thres = params{1,2}(21,1);
    info.params.aroon_trendup = params{1,2}(22,1);
    info.params.aroon_trenddn = params{1,2}(23,1);
    info.params.adx_period = params{1,2}(24,1);
    info.params.adx_thres = params{1,2}(25,1);
    info.params.ma_tslope_value = params{1,2}(26,1);
    info.params.trigger_tslope_up = params{1,2}(27,1);
    info.params.trigger_tslope_dn = params{1,2}(28,1);
    info.params.run_length = params{1,2}(29,1);
    
end
    
% function [trigger_pctb_high	trigger_pctb_low trigger_so_fastpctd_high trigger_so_fastpctd_low trigger_aroon_oscillator_high	trigger_aroon_oscillator_low so_fk_period so_sk_period so_sd_period	so_above_thres	so_below_thres	ma_iii_value	ma_c_value	ma_cc_value	ma_c_short	ma_cc_short	level_period	atr_period	aroon_period	aroon_high_thres	aroon_low_thres	aroon_trendup	aroon_trenddn	adx_period	adx_thres ma_tslope_value trigger_tslope_up trigger_tslope_dn run_length ma_tslope_stdev] = parse_params()    
%     trigger_pctb_high = params{1,2}(1,1);
%     trigger_pctb_low = params{1,2}(2,1);
%     trigger_so_fastpctd_high = params{1,2}(3,1);
%     trigger_so_fastpctd_low = params{1,2}(4,1);
%     trigger_aroon_oscillator_high = params{1,2}(5,1);
%     trigger_aroon_oscillator_low = params{1,2}(6,1);
%     so_fk_period = params{1,2}(7,1);
%     so_sk_period = params{1,2}(8,1);
%     so_sd_period = params{1,2}(9,1);
%     so_above_thres = params{1,2}(10,1);
%     so_below_thres = params{1,2}(11,1);
%     ma_iii_value = params{1,2}(12,1);
%     ma_c_value = params{1,2}(13,1);
%     ma_cc_value = params{1,2}(14,1);
%     ma_c_short = params{1,2}(15,1);
%     ma_cc_short = params{1,2}(16,1);
%     level_period = params{1,2}(17,1);
%     atr_period = params{1,2}(18,1);
%     aroon_period = params{1,2}(19,1);
%     aroon_high_thres = params{1,2}(20,1);
%     aroon_low_thres = params{1,2}(21,1);
%     aroon_trendup = params{1,2}(22,1);
%     aroon_trenddn = params{1,2}(23,1);
%     adx_period = params{1,2}(24,1);
%     adx_thres = params{1,2}(25,1);
%     ma_tslope_value = params{1,2}(26,1);
%     trigger_tslope_up = params{1,2}(27,1);
%     trigger_tslope_dn = params{1,2}(28,1);
%     run_length = params{1,2}(29,1);

% end