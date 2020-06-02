function [info] = target_strikes(info,close_prices,p)
%% Hard Code Parameters
call_days = 10;
put_days = 45;

%% Call Multiplier
% the current call atm IV is populated for the most recent data point
    m_call_iv = info.ammo.stage(p).implied_volatility.profile.(['implied_volatility_' num2str(call_days)]); % 1 standard deviations
           m_call_iv(1,1) = ((info.ammo.stage(p).atm_options.call.impliedVol / sqrt(252)) * sqrt(10)); % convert annual vol to call 10 day        
                info.ammo.stage(p).strat_indicators.target_strikes.m_call_iv = m_call_iv;
                       
    m_call_hv = info.ammo.stage(p).historical_volatility.profile.(['historical_volatility_' num2str(call_days)]); % 1 standard deviations
            info.ammo.stage(p).strat_indicators.target_strikes.m_call_hv = m_call_hv;
%% Put Multiplier
% the current put atm IV is populated for the most recent data point
    m_put_iv = info.ammo.stage(p).implied_volatility.profile.(['implied_volatility_' num2str(put_days)]); % 1 standard deviations
            m_put_iv(1,1) = ((info.ammo.stage(p).atm_options.put.impliedVol / sqrt(252)) * sqrt(45)); % convert annual vol to put 45 day        
                info.ammo.stage(p).strat_indicators.target_strikes.m_put_iv = m_put_iv; 
                
    m_put_hv = info.ammo.stage(p).historical_volatility.profile.(['historical_volatility_' num2str(put_days)]); % 1 standard deviations
            info.ammo.stage(p).strat_indicators.target_strikes.m_put_hv = m_put_hv;

%% Call Strikes
    szindex = min([size(m_call_iv,1) size(close_prices,1)]); % size index for dimension mismatch errors
    info.ammo.stage(p).strat_indicators.target_strikes.call_strike_iv = (m_call_iv(1:szindex,1) .* close_prices(1:szindex,1)) + close_prices(1:szindex,1); 
    
    szindex = min([size(m_call_hv,1) size(close_prices,1)]); % size index for dimension mismatch errors
    info.ammo.stage(p).strat_indicators.target_strikes.call_strike_hv = (m_call_hv(1:szindex,1) .* close_prices(1:szindex,1)) + close_prices(1:szindex,1); 

%% Put Strikes
    szindex = min([size(m_put_iv,1) size(close_prices,1)]); % size index for dimension mismatch errors
    info.ammo.stage(p).strat_indicators.target_strikes.put_strike_iv = close_prices(1:szindex,1) - (m_put_iv(1:szindex,1) .* close_prices(1:szindex,1)); 
    %% 
   
    szindex = min([size(m_put_hv,1) size(close_prices,1)]); % size index for dimension mismatch errors
    info.ammo.stage(p).strat_indicators.target_strikes.put_strike_hv = close_prices(1:szindex,1) - (m_put_hv(1:szindex,1) .* close_prices(1:szindex,1));


end
