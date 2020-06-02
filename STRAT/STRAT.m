function [info] = STRAT(info)
try
%STRAT High Structure STRAT Function
%   All functions to pull and calculate strategy information goes on here


for p = 1:size(info.ammo.stage,2)
    try
        %% Store prices for strat run
        
        close_prices = info.ammo.stage(p).historical_bars.close; % Temp close variable
        high_prices = info.ammo.stage(p).historical_bars.high; % Temp high variable
        low_prices = info.ammo.stage(p).historical_bars.low; % Temp low variable
        historical_volatility_annual = info.ammo.stage(p).historical_volatility.hv_bars.close;
        implied_volatility_annual = info.ammo.stage(p).implied_volatility.iv_bars.close;
        
        %% Run Subs
        [info] = moveavg(info,close_prices,p);%moveavg.m function
        [info] = bollinger(info,close_prices,p);%bollinger.m function
        [info] = macds(info,close_prices,p);%macd.m function
        [info] = stochastic(info,close_prices,high_prices,low_prices,p);%stochastic.m function
        [info] = atrs(info,close_prices,high_prices,low_prices,p);%atr.m function
        %[info] = adxs(info,high_prices,low_prices,p);%adx.m function
        [info] = aroon(info,high_prices,low_prices,p);%aroon.m function
        [info] = level(info,high_prices,low_prices,p);%level.m function
        [info] = ammo_hv_profilecone(info,historical_volatility_annual,p);% ammo_historical_vol.m;
        [info] = ammo_iv_profilecone(info,implied_volatility_annual,p);% ammo_historical_vol.m;
        [info] = volatility_analysis(info,historical_volatility_annual,implied_volatility_annual,p); % volatility_analysis
        [info] = target_strikes(info,close_prices,p);    
    catch ME
%         continue
    end
end


catch ME
    sendmail('ammodono@gmail.com', 'ERROR: STRAT',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
