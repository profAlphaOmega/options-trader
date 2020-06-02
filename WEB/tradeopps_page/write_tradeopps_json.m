function [info] = write_tradeopps_json(info)
try
%% Preallocate Error 
    symbol_t = cellstr(num2str(zeros(size(info.ammo.stage,2),1)));
    ul_price_t = cellstr(num2str(zeros(size(info.ammo.stage,2),1)));
    aroon_t = cellstr(num2str(zeros(size(info.ammo.stage,2),1)));
    stoch_pctk_t = cellstr(num2str(zeros(size(info.ammo.stage,2),1)));
    bb_pctb_t = cellstr(num2str(zeros(size(info.ammo.stage,2),1)));
    vol_oscillator_t = cellstr(num2str(zeros(size(info.ammo.stage,2),1)));
    vol_ultra_oscillator_t = cellstr(num2str(zeros(size(info.ammo.stage,2),1)));
        
for i = 1:size(info.ammo.stage,2)
    try
%% Stage
    stage = info.ammo.stage(i);
    symbol = stage.symbol;
    symbol_t{i,1} = symbol;
    
%% Graph Chart Data
    stock_graph_price = {flipud(stage.historical_bars.close(1:180))}; % flipud for js purposes
    
    date = {flipud(num2str((datenum(stage.historical_bars.dateNum(1:180)) - datenum('Jan-1-1970'))  .* (24*60*60*1000)))}; % subtract the date from jan 1st 1970 to find days the convert to milliseconds
    stock_open = {flipud(stage.historical_bars.open(1:180))}; % flipud for js purpose
    stock_high = {flipud(stage.historical_bars.high(1:180))}; % flipud for js purpose
    stock_low = {flipud(stage.historical_bars.low(1:180))}; % flipud for js purpose
    stock_close = {flipud(stage.historical_bars.close(1:180))}; % flipud for js purpose
    stock_volume = {flipud(stage.historical_bars.volume(1:180))}; % flipud for js purpose
    avg_volume = {flipud(stage.strat_indicators.moveavg.ma_volume(1:180))}; % flipud for js purpose
    
    iv_date = {flipud(num2str((datenum(stage.implied_volatility.iv_bars.dateNum(1:180)) - datenum('Jan-1-1970'))  .* (24*60*60*1000)))}; % flipud for js purpose   
    iv_open = {flipud(stage.implied_volatility.iv_bars.open(1:180))}; % flipud for js purpose
    iv_high = {flipud(stage.implied_volatility.iv_bars.high(1:180))}; % flipud for js purpose
    iv_low = {flipud(stage.implied_volatility.iv_bars.low(1:180))}; % flipud for js purpose
    iv_close = {flipud(stage.implied_volatility.iv_bars.close(1:180))}; % flipud for js purpose
        
    bollinger_highband = {flipud(stage.strat_indicators.bollinger.bb_highband(1:180))}; % flipud for js purposes
    bollinger_middleband = {flipud(stage.strat_indicators.bollinger.bb_middleband(1:180))}; % flipud for js purposes
    bollinger_lowband = {flipud(stage.strat_indicators.bollinger.bb_lowband(1:180))}; % flipud for js purposes
    
    call_strike_iv = {flipud(stage.strat_indicators.target_strikes.call_strike_iv(1:180))}; % flipud for js purposes
    call_strike_hv = {flipud(stage.strat_indicators.target_strikes.call_strike_hv(1:180))}; % flipud for js purposes
    put_strike_iv = {flipud(stage.strat_indicators.target_strikes.put_strike_iv(1:180))}; % flipud for js purposes
    put_strike_hv = {flipud(stage.strat_indicators.target_strikes.put_strike_hv(1:180))}; % flipud for js purposes
    
    stock_graph_hv = {flipud(stage.historical_volatility.hv_bars.close(1:180))}; % flipud for js purposes
    stock_graph_iv = {flipud(stage.implied_volatility.iv_bars.close(1:180))}; % flipud for js purposes
   
%% Indicators

    ul_price = sprintf('%.2f',stage.historical_bars.close(1,1));
    
    ma_iii = sprintf('%.2f',stage.strat_indicators.moveavg.ma_iii(1,1));
    ma_c = sprintf('%.2f',stage.strat_indicators.moveavg.ma_c(1,1));
        
    bb_pctb = sprintf('%.2f',stage.strat_indicators.bollinger.bb_percentb(1,1));
    bb_bandwidth = sprintf('%.2f',stage.strat_indicators.bollinger.bb_bandwidth(1,1));
    bb_avg_bandwidth = sprintf('%.2f',stage.strat_indicators.bollinger.bb_avg_bandwidth(1,1));
    
    osma = sprintf('%.2f',stage.strat_indicators.macd.macd_osma(1,1));
    macd = sprintf('%.2f',stage.strat_indicators.macd.macdline(1,1));
    avg_macd = sprintf('%.2f',stage.strat_indicators.macd.avg_macd(1,1));
    osmacross = stage.strat_indicators.macd.macd_osmacross(1,1);
    macdcentercross = stage.strat_indicators.macd.macd_centercross(1,1);

    stoch_pctk = sprintf('%.2f',stage.strat_indicators.stochastic.so_fastpctd(1,1));
    stoch_pctd = sprintf('%.2f',stage.strat_indicators.stochastic.so_slowpctd(1,1));
    stoch_histogram = sprintf('%.2f',stage.strat_indicators.stochastic.so_histogram(1,1));
    
    atr = sprintf('%.2f',stage.strat_indicators.atr.atr(1,1));
    tr = sprintf('%.2f',stage.strat_indicators.atr.tr(1,1));
    avg_atr = sprintf('%.2f',stage.strat_indicators.atr.avg_atr(1,1));
    
    aroon = stage.strat_indicators.aroon.aroon_oscillator(1,1);
    aroon_avgoscillator = sprintf('%.2f',stage.strat_indicators.aroon.aroon_avgoscillator(1,1));
    aroon_trend = sprintf('%.2f',stage.strat_indicators.aroon.aroon_trend(1,1));
    aroon_signalcross = stage.strat_indicators.aroon.aroon_signalcross(1,1);
    
    resistance = sprintf('%.2f',stage.strat_indicators.level.resistance(1,1));
    support = sprintf('%.2f',stage.strat_indicators.level.support(1,1));
    
    avg_vol_oscillator = sprintf('%.2f',100*stage.strat_indicators.volatility.avg_oscillator(1,1));
    vol_oscillator = sprintf('%.2f',100*stage.strat_indicators.volatility.oscillator(1,1));
    vol_ultra = sprintf('%.2f',stage.strat_indicators.volatility.vol_ultra(1,1));
    
    current_hv = sprintf('%.2f',100*stage.historical_volatility.hv_bars.close(1,1));
    hv_rank = sprintf('%.2f',stage.historical_volatility.hv_rank);
    hv_percentile = sprintf('%.2f',stage.historical_volatility.hv_percentile);
    hv_min = sprintf('%.2f',stage.historical_volatility.hv_min);
    hv_max = sprintf('%.2f',stage.historical_volatility.hv_max);
    hv_pctv = sprintf('%.2f',stage.historical_volatility.hv_pctv);
    
    current_iv = sprintf('%.2f',100*stage.implied_volatility.iv_bars.close(1,1));
    iv_rank = sprintf('%.2f',stage.implied_volatility.iv_rank);
    iv_percentile = sprintf('%.2f',stage.implied_volatility.iv_percentile);
    iv_min = sprintf('%.2f',stage.implied_volatility.iv_min);
    iv_max = sprintf('%.2f',stage.implied_volatility.iv_max);
    iv_pctv = sprintf('%.2f',stage.implied_volatility.iv_pctv);
    
    current_volume = sprintf('%.f',stage.historical_bars.volume(1,1)); % flipud for js purpose
    volume_ultra = sprintf('%.f',stage.strat_indicators.moveavg.volume_ultra(1,1)); % flipud for js purpose
    
%% Build Tradeopps Table
    ul_price_t{i,1} = ul_price;
    aroon_t{i,1} = aroon;
    stoch_pctk_t{i,1} = stoch_pctk;
    bb_pctb_t{i,1} = bb_pctb;
    vol_oscillator_t{i,1} = vol_oscillator;
    vol_ultra_oscillator_t{i,1} = vol_ultra; % num2str(str2double(vol_oscillator) - str2double(avg_vol_oscillator)) 
    last_updated = info.start_time_str; % updated time
%% Convert into a cell array for JSON writing purposes
json_array = {stock_graph_price stock_graph_hv stock_graph_iv ...
                bollinger_highband bollinger_middleband bollinger_lowband ...
                ul_price ma_iii ma_c ... 
                bb_pctb bb_bandwidth bb_avg_bandwidth ...
                osma macd osmacross macdcentercross ...
                stoch_pctk stoch_pctd stoch_histogram ...
                atr tr ...
                aroon aroon_avgoscillator aroon_trend aroon_signalcross ...
                resistance support ...
                vol_oscillator avg_vol_oscillator ...
                current_hv hv_rank hv_percentile hv_min hv_max hv_pctv ...
                current_iv iv_rank iv_percentile iv_min iv_max iv_pctv avg_atr avg_macd ...
                vol_ultra ...
                stock_open stock_high stock_low stock_close stock_volume ...
                iv_open iv_high iv_low iv_close ...
                date iv_date ...
                current_volume volume_ultra avg_volume ...
                call_strike_iv put_strike_iv call_strike_hv put_strike_hv};

file_tradeopps_json = ['F:/inetpub/ammoroot/json/' symbol '.json'];
info.web.tradeopps.json.([symbol '_encoded_array']) = savejson('',json_array,file_tradeopps_json);
         
    catch 
    %% Error Processing
    stage = info.ammo.stage(i);
    symbol = stage.symbol;
    symbol_t{i,1} = symbol;
    
    ul_price_t{i,1} = 'error';
    aroon_t{i,1} = 'error';
    stoch_pctk_t{i,1} = 'error';
    bb_pctb_t{i,1} = 'error';
    vol_oscillator_t{i,1} = 'error';
    vol_ultra_oscillator_t{i,1} = 'error'; 

    end
end

pause(1);

json_table_array = {symbol_t ul_price_t aroon_t stoch_pctk_t bb_pctb_t vol_oscillator_t vol_ultra_oscillator_t last_updated};
file_tradeopps_table_json = 'F:/inetpub/ammoroot/json/tradeopps.json';
info.web.tradeopps.json.table = savejson('',json_table_array,file_tradeopps_table_json);

catch
     sendmail('ammodono@gmail.com', 'ERROR: tradeopps_json',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end