function [info] = strat_ammo(info)

%run parse_params.m
%%Eventually put all params vars in params structure and append into info, or probably keep on its own as a structure

for p = 1:size(info.ammo.stage,2)
    try
%% Store prices for strat run
        
        close_prices = info.ammo.stage(p).historical_bars.close; % Temp close variable
        high_prices = info.ammo.stage(p).historical_bars.high; % Temp high variable
        low_prices = info.ammo.stage(p).historical_bars.low; % Temp low variable

%% Run Subs
        % [info] = counter(info,p); % This function can be replaced with modification to moveavg function; counter function
        [info] = moveavg(info,close_prices,p);%moveavg.m function
        [info] = bollinger(info,close_prices,p);%bollinger.m function
        [info] = macds(info,close_prices,p);%macd.m function
        [info] = stochastic(info,close_prices,high_prices,low_prices,p);%stochastic.m function
        %[info] = atrs(info,close_prices,high_prices,low_prices,p);%atr.m function
        %[info] = adxs(info,high_prices,low_prices,p);%adx.m function
        [info] = aroon(info,high_prices,low_prices,p);%aroon.m function
        [info] = level(info,high_prices,low_prices,p);%level.m function
        [info] = ammo_hv_profilecone(info,p);% ammo_historical_vol.m; 
        [info] = ammo_iv_profilecone(info,p);% ammo_historical_vol.m; 
     
        
    catch ME
    end
end
        
end
