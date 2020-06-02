function [chain_struct_unique] = test(chain_struct_unique)

for j = 1:size(chain_struct_unique,1) % go on rows dimension
    try
    
localsymbol = chain_struct_unique(j).localsymbol;
expiry = chain_struct_unique(j).expiry;
strike = chain_struct_unique(j).strike; % make sure this is a number and not a string
right = chain_struct_unique(j).right;


data_option = IBMatlab('action','query','localsymbol',localsymbol,'secType','OPT','ClientID',2666,'Port',4001);


chain_struct_unique(j).price = data_option(j).lastOptComp.optPrice; % ask price

chain_struct_unique(j).implied_volatility = data_option(j).lastOptComp.impliedVol; % implied Volatility
chain_struct_unique(j).delta = data_option(j).lastOptComp.delta; % delta
chain_struct_unique(j).theta = data_option(j).lastOptComp.theta; % theta
chain_struct_unique(j).vega = data_option(j).lastOptComp.vega; % vega
chain_struct_unique(j).gamma = data_option(j).lastOptComp.gamma; % gamma

    catch ME
    end
end


end


% hard code vairables
% price_ul = 194.00;
% price_ul = info.ammo.tradeopps(i).ammo_current_ul.askPrice; % use latest ask price
% strike = chain_struct_unique(j).strike;
% rate = .03; % 4 week average risk free rate www.treasury.gov
% time = 45/252;
% time = info.ammo.tradeopps(i).dte/252; % use trading days
% implied_volatility = .20;
% implied_volatility = info.ammo.tradeopps(i).implied_volatility.profile.implied_volatility_annual; % use implied volatility for now cause that is what the market is currently saying



% [chain_struct_unique(j).calldelta,chain_struct_unique(j).putdelta] = blsdelta(price_ul,strike,rate,time,implied_volatility); % delta
% % [CallDelta, PutDelta] = blsdelta(Price, Strike, Rate, Time, Volatility, Yield)
% 
% [chain_struct_unique(j).calltheoprice,chain_struct_unique(j).puttheoprice] = blsprice(price_ul,strike,rate,time,implied_volatility); % theoretical price
% % [Call, Put] = blkprice(Price, Strike, Rate, Time, Volatility)
% 
% vega = blsvega(price_ul,strike,rate,time,implied_volatility); % 
% chain_struct_unique(j).callvega = vega; 
% chain_struct_unique(j).putvega = vega; 
% % Vega = blsvega(Price, Strike, Rate, Time, Volatility, Yield)
% 
% [chain_struct_unique(j).calltheta,chain_struct_unique(j).puttheta] = blstheta(price_ul,strike,rate,time,implied_volatility); % theta
% % [CallTheta, PutTheta] = blstheta(Price, Strike, Rate, Time, Volatility, Yield)
% 
% gamma = blsgamma(price_ul,strike,rate,time,implied_volatility); % theta
% chain_struct_unique(j).callgamma = gamma; 
% chain_struct_unique(j).putgamma = gamma; 