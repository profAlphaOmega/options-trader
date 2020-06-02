function [info] = ammo_tradeopps_greeks(info,i)
%AMMO_GREEKS Calculates all greeks for option

% List of Inputs needed

current_market_price = info.ammo.tradeopps(i).current_market_price; % current price of ul
strike % exercise price of ption
rate % annualized continously compounded risk-free rate = .04
time % time to expiration expressed in years
volatility % annualized historical vol
yield % optional






info.trade(1).theoretical_price = blsprice(); % [Call, Put] = blkprice(Price, Strike, Rate, Time, Volatility)
    current_market_price % current price of ul
    strike % exercise price of ption
    rate % annualized continously compounded risk-free rate = .04
    time % time to expiration expressed in years
    volatility % annualized historical vol
    yield % optional



info.trade(1).vega = blsvega(); % Vega = blsvega(Price, Strike, Rate, Time, Volatility, Yield)
    current_market_price % current price of ul
    strike % exercise price of ption
    rate % annualized continously compounded risk-free rate = .04
    time % time to expiration expressed in years
    volatility % annualized historical vol
    yield % optional


info.trade(1).theta = blstheta(); % [CallTheta, PutTheta] = blstheta(Price, Strike, Rate, Time, Volatility, Yield)
    current_market_price % current price of ul
    strike % exercise price of ption
    rate % annualized continously compounded risk-free rate = .04
    time % time to expiration expressed in years
    volatility % annualized historical vol
    yield % optional




info.trade(1).gamma = blsgamma(); % Gamma = blsgamma(Price, Strike, Rate, Time, Volatility, Yield)
    current_market_price % current price of ul
    strike % exercise price of ption
    rate % annualized continously compounded risk-free rate = .04
    time % time to expiration expressed in years
    volatility % annualized historical vol
    yield % optional



info.trade(1).delta = blsdelta(); % [CallDelta, PutDelta] = blsdelta(Price, Strike, Rate, Time, Volatility, Yield)
    current_market_price % current price of ul
    strike % exercise price of ption
    rate % annualized continously compounded risk-free rate = .04
    time % time to expiration expressed in years
    volatility % annualized historical vol
    yield % optional




info.trade(1).IV = blsimpv(); % Volatility = blsimpv(Price, Strike, Rate, Time, Value, Limit, Yield, Tolerance, Class)
    current_market_price % current price of ul
    strike % exercise price of ption
    rate % annualized continously compounded risk-free rate = .04
    time % time to expiration expressed in years
    volatility % annualized historical vol
    yield % optional
    tolerance % optional
    class %  Class = true or Class = {'call'} / Class = false or Class = {'put'}


end

