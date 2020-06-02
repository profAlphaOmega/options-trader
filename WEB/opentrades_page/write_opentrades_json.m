function [info] = write_opentrades_json(info)
ot_table = [];
opentrades_array = transpose({info.web.home.json.ot_table(:).comp_name});

for i = 1:size(opentrades_array,1)
    try
%% Pull Symbol Data
        tradename = opentrades_array{i};
        if strcmp(tradename(4),'_')
            tradesymbol = tradename(1:3);
        else
            tradesymbol = tradename(1:4);
        end
         
%% Find Weighted Info       
        weighted_info = info.ammo.portfolio.trades.(tradesymbol).([tradename '_weighted']);
            weighted_name = {weighted_info.comp_name};
            weighted_dte = {weighted_info.comp_dte};
            weighted_current_ul = {weighted_info.current_ul};
            weighted_comp_long_strike = sprintf('%.2f',weighted_info.comp_long_strike);
            weighted_premium_paid = sprintf('%.2f',weighted_info.comp_premium_paid);
            weighted_short_strike = sprintf('%.2f',weighted_info.comp_short_strike);
            weighted_credit_received = sprintf('%.2f',weighted_info.comp_credit_received);
            weighted_ncr = sprintf('%.2f',100*weighted_info.comp_ncr);
            weighted_breakeven = sprintf('%.2f',weighted_info.comp_breakeven);
            weighted_maxprofit = sprintf('%.2f',100*weighted_info.comp_maxprofit);
            weighted_maxloss = sprintf('%.2f',100*weighted_info.comp_maxloss);
            weighted_pl = sprintf('%.2f',weighted_info.comp_pl);
            weighted_pop = sprintf('%.2f',weighted_info.comp_pop);
        
%% Individual Trades Table
        ot_table = info.ammo.portfolio.trades.(tradesymbol).(tradename);
        ot_table = struct2table(ot_table); % convert to table
        ot_table = table2cell(ot_table); % convert to cell array
        ot_table = sortrows(ot_table,2); % sort cell array

            % soft code columns
            symbol = ot_table(:,1);
            localsymbol = ot_table(:,2);
            exchange = ot_table(:,3);
            secType = ot_table(:,4);
            currency = ot_table(:,5);
            right = ot_table(:,6);
            expiry = ot_table(:,7);
            strike = ot_table(:,8);
            position = ot_table(:,9);
            marketValue = ot_table(:,10);
            marketPrice = ot_table(:,11);
            averageCost = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,12))))};
          % contract = ot_table(:,13); % this is a structure
            conId = ot_table(:,14);
            
            current_ul = ot_table(:,16);
            
            optprice = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,18))))};
            impliedvol = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,19))))};
            delta = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,20))))};
            pos = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,21))))};
            gamma = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,22))))};
            theta = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,23))))};
            vega = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,24))))};
            dte = ot_table(:,25);
            pl = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,26))))}; 
            pomax= {str2num(sprintf('%.2f ',cell2mat(ot_table(:,27))*100))}; 
                
%% Graph Chart Data
    stage = info.ammo.stage(strcmp(transpose({info.ammo.stage(:).symbol}),tradesymbol));
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
    
    stock_graph_hv = {flipud(stage.historical_volatility.hv_bars.close(1:180))}; % flipud for js purposes
    stock_graph_iv = {flipud(stage.implied_volatility.iv_bars.close(1:180))}; % flipud for js purposes
    bollinger_highband = {flipud(stage.strat_indicators.bollinger.bb_highband(1:180))}; % flipud for js purposes
    bollinger_middleband = {flipud(stage.strat_indicators.bollinger.bb_middleband(1:180))}; % flipud for js purposes
    bollinger_lowband = {flipud(stage.strat_indicators.bollinger.bb_lowband(1:180))}; % flipud for js purposes
    
%% Graph Table Data    
    aroon = stage.strat_indicators.aroon.aroon_oscillator(1,1);
    
    stoch_pctk = sprintf('%.2f',stage.strat_indicators.stochastic.so_fastpctd(1,1));
    stoch_pctd = sprintf('%.2f',stage.strat_indicators.stochastic.so_slowpctd(1,1));
    stoch_histogram = sprintf('%.2f',stage.strat_indicators.stochastic.so_histogram(1,1));
    
    osma = sprintf('%.2f',stage.strat_indicators.macd.macd_osma(1,1));
    macd = sprintf('%.2f',stage.strat_indicators.macd.macdline(1,1));
    
    bb_pctb = sprintf('%.2f',stage.strat_indicators.bollinger.bb_percentb(1,1));
    bb_bandwidth = sprintf('%.2f',stage.strat_indicators.bollinger.bb_bandwidth(1,1));
    bb_avg_bandwidth = sprintf('%.2f',stage.strat_indicators.bollinger.bb_avg_bandwidth(1,1));
    
    current_iv = sprintf('%.2f',stage.implied_volatility.current_iv);
    current_hv = sprintf('%.2f',stage.historical_volatility.current_hv);
    
    iv_rank = sprintf('%.2f',stage.implied_volatility.iv_rank);
    iv_percentile = sprintf('%.2f',stage.implied_volatility.iv_percentile);
    iv_pctv = sprintf('%.2f',stage.implied_volatility.iv_pctv);
    
    vol_oscillator = sprintf('%.2f',stage.strat_indicators.volatility.oscillator(1,1));
    avg_vol_oscillator = sprintf('%.2f',stage.strat_indicators.volatility.avg_oscillator(1,1));
    vol_ultra = sprintf('%.2f',stage.strat_indicators.volatility.vol_ultra(1,1));
    
    current_volume = sprintf('%.f',stage.historical_bars.volume(1,1)); % flipud for js purpose
    volume_ultra = sprintf('%.f',stage.strat_indicators.moveavg.volume_ultra(1,1)); % flipud for js purpose
    
    
    
%% Convert into a cell array for JSON writing purposes
json_array = {weighted_name weighted_dte weighted_current_ul ...
                weighted_comp_long_strike weighted_premium_paid ...
                weighted_short_strike weighted_credit_received ...
                weighted_ncr weighted_breakeven ...
                weighted_maxprofit weighted_maxloss ...
                weighted_pl weighted_pop...
                symbol localsymbol right  position expiry ...
                strike...
                marketValue averageCost ...
                dte pl pomax ...
                stock_graph_price stock_graph_hv stock_graph_iv ...
                bollinger_highband bollinger_middleband bollinger_lowband ...
                aroon stoch_pctk stoch_pctd ...
                osma bb_pctb bb_bandwidth ...
                current_iv current_hv ...
                iv_rank iv_percentile optprice impliedvol delta gamma theta vega ...
                stoch_histogram vol_oscillator bb_avg_bandwidth macd avg_vol_oscillator vol_ultra iv_pctv ...
                pos ...
                stock_open stock_high stock_low stock_close stock_volume ...
                iv_open iv_high iv_low iv_close ...
                date iv_date ...
                current_volume volume_ultra avg_volume};

file_opentrades_json = ['F:/inetpub/ammoroot/json/' tradename '.json'];
info.web.opentrades.json.([tradename '_encoded_array']) = savejson('',json_array,file_opentrades_json);
        
    catch ME
    end
end



end
