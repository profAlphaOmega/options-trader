function [info] = volatility_analysis(info,historical_volatility_annual,implied_volatility_annual,p)
try

%% Find Min Index and Replace vol with blended atm strike vols
szindex = min([size(historical_volatility_annual,1) size(implied_volatility_annual,1)]); % size index 

implied_volatility_annual(1,1) = ((info.ammo.stage(p).atm_options.call.impliedVol + info.ammo.stage(p).atm_options.put.impliedVol) / 2); % average of the call and the put option   
  info.ammo.stage(p).implied_volatility.iv_bars.close = implied_volatility_annual; % store in info
%% Volatility Oscillator
info.ammo.stage(p).strat_indicators.volatility.oscillator = implied_volatility_annual(1:szindex,1) - historical_volatility_annual(1:szindex,1); 

for i = 1:size(info.ammo.stage(p).strat_indicators.volatility.oscillator,1)
    try

        info.ammo.stage(p).strat_indicators.volatility.avg_oscillator(i,1) = mean(info.ammo.stage(p).strat_indicators.volatility.oscillator(i:i+info.params.strat_params.vol_oscillator_lookback,1));   
    
    catch 
        continue
    end
%% Find Min Size Index
szindex = min([size(info.ammo.stage(p).strat_indicators.volatility.oscillator,1) size(info.ammo.stage(p).strat_indicators.volatility.avg_oscillator,1)]); % size index    

%% Store Vol Ultra
info.ammo.stage(p).strat_indicators.volatility.vol_ultra = (info.ammo.stage(p).strat_indicators.volatility.oscillator(1:szindex) - info.ammo.stage(p).strat_indicators.volatility.avg_oscillator(1:szindex)) ./ abs(info.ammo.stage(p).strat_indicators.volatility.avg_oscillator(1:szindex));
    
end

catch
   sendmail('ammodono@gmail.com', 'ERROR: volatility_analysis',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end