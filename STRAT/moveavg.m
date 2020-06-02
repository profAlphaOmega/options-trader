%%% MOVEAVG.M FUNCTION
% STRAT RUN FOR MOVING AVERAGE FUNCTION

function [info] = moveavg(info,close_prices,p)    
try
%% Load Params
ma_iii_value = info.params.strat_params.ma_iii_value; % 3 day
ma_c_value = info.params.strat_params.ma_c_value; % 100 day
ma_cc_value = info.params.strat_params.ma_cc_value; % 200 day
ma_tslope_value = info.params.strat_params.ma_tslope_value; 
ma_volume_lookback = info.params.strat_params.ma_volume_lookback;
% ma_c_short = info.params.strat_params.ma_c_short;
% ma_cc_short = info.params.strat_params.ma_cc_short;

%% Preallocation
ma_tslope = zeros(size(close_prices,1),1);

%% Calculate Moving Averages
    ma_iii = flipud(tsmovavg(flipud(close_prices),'s',ma_iii_value,1)); % 3 day simple moving average
    ma_c = flipud(tsmovavg(flipud(close_prices),'s',ma_c_value,1)); % 100 day simple moving average
    ma_cc = flipud(tsmovavg(flipud(close_prices),'s',ma_cc_value,1)); % 200 day simple moving average
 
%% Calculate Volume Average
     ma_volume = flipud(tsmovavg(flipud(info.ammo.stage(p).historical_bars.volume),'s',ma_volume_lookback,1)); % moving average of volume
     volume_ultra = info.ammo.stage(p).historical_bars.volume(1,1) - ma_volume(1,1); % volume ultra
    
%% Calculate Moving Average Slope
   for i = 1:size(ma_cc,1)
       try
           ma_tslope(i,1) = (ma_c(i,1) - ma_c(i+ma_tslope_value,1))/(i-(i+ma_tslope_value));
       catch 
           continue
       end
   end

%% Store Variables
info.ammo.stage(p).strat_indicators.moveavg.ma_c = ma_c;
info.ammo.stage(p).strat_indicators.moveavg.ma_iii = ma_iii;
info.ammo.stage(p).strat_indicators.moveavg.ma_tslope = ma_tslope;
info.ammo.stage(p).strat_indicators.moveavg.ma_volume = ma_volume;
info.ammo.stage(p).strat_indicators.moveavg.volume_ultra = volume_ultra;

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: moveavg',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end



%        
% ma_tslope(i,1) = (ma_cc(i,1) - ma_cc(i+ma_tslope_value,1))/(pkey(i,1)-pkey(i+ma_tslope_value,1));
%


% if size(close_prices,1) > 100
%     ma_iii = flipud(tsmovavg(flipud(close_prices),'s',ma_iii_value,1)); 
%     ma_c = flipud(tsmovavg(flipud(close_prices),'s',ma_c_value,1));
%     ma_cc = flipud(tsmovavg(flipud(close_prices),'s',ma_cc_value,1));
%     ma_oscillator = ma_iii - ma_cc;
% else
%     ma_iii = flipud(tsmovavg(flipud(close_prices),'s',ma_iii_value,1));
%     ma_c = flipud(tsmovavg(flipud(close_prices),'s',ma_c_short,1));
%     ma_cc = flipud(tsmovavg(flipud(close_prices),'s',ma_cc_short,1));
%     ma_oscillator = ma_iii - ma_cc; % Oscillator; might need to modify it to make two values closer in length. Currently you won't get a very sensitive signal unless extreme movement, which it will be too late by then
% end


       %5-Day Moving Average    
       %fiveday(i,1) = sum(ul{1,5}(i:i+4,1))/5;