function [info] = parse_params(info)
    
%   Run Length Param
    info.params.run_length = 745;

%   Trigger Param
    info.params.trigger_tslope_up = .43;
    info.params.trigger_tslope_dn = -.43;
    info.params.trigger_pctb_high = 70;
    info.params.trigger_pctb_low = 30;
    info.params.trigger_so_fastpctd_high = 80;
    info.params.trigger_so_fastpctd_low = 20;
    info.params.trigger_aroon_oscillator_high = 50;
    info.params.trigger_aroon_oscillator_low = -50;
    
%   Stochastic Param    
    info.params.so_fk_period = 15;
    info.params.so_sk_period = 5;
    info.params.so_sd_period = 5;
    info.params.so_above_thres = 80;
    info.params.so_below_thres = 20;
    
%   Moveing Average Param
    info.params.ma_tslope_value = 2;
    info.params.ma_iii_value = 3;
    info.params.ma_c_value = 100;
    info.params.ma_cc_value = 200;
    info.params.ma_c_short = 25;
    info.params.ma_cc_short = 50;
    
%   Leve Param    
    info.params.level_period = 25;
    
%   ATR Param    
    info.params.atr_period = 14;
    
%   Aroon Param    
    info.params.aroon_period = 25;
    info.params.aroon_high_thres = 90;
    info.params.aroon_low_thres = -90;
    info.params.aroon_trendup = 70;
    info.params.aroon_trenddn = -70;
    
%   ADX Param
    info.params.adx_period = 14;
    info.params.adx_thres = 25;

% Info Time Stamp
    info.params.date_params = date();
    
% save('C:\Users\Zato\Desktop\AMMO\IB stage\params.mat')
    
end