function [info] = ammo_opentrades_traderisk(info,i)
%AMMO_BREAKEVEN finds breakeven price of short vertical
%   Detailed explanation goes here

% have to figure out how price is read in; might need to multply by
% contract size

pleg_strike = info.ammo.tradeopps(i).pleg_strike; % short strike
pleg_price = info.ammo.tradeopps(i).pleg_price; % short price
pleg_action = info.ammo.tradeopps(i).pleg_action; % short action
pleg_right = info.ammo.tradeopps(i).pleg_right; % short right

sleg_strike = info.ammo.tradeopps(i).sleg_strike; % long strike
sleg_price = info.ammo.tradeopps(i).sleg_price; % long price
sleg_action = info.ammo.tradeopps(i).sleg_action; % long action
sleg_right = info.ammo.tradeopps(i).sleg_right; % long right

tradetype = info.ammo.tradeopps(i).tradetype; % hard code trade type

switch tradetype
    
    case'bullput'
        info.ammo.tradeopps(i).ncr = pleg_price - sleg_price; % net credit recieved
        info.ammo.tradeopps(i).breakeven = pleg_strike - ncr; % breakeven price
        info.ammo.tradeopps(i).maxprofit = ncr; % max profit
        info.ammo.tradeopps(i).maxloss = breakeven - sleg_strike; % max loss
    
    case 'bearcall'
        info.ammo.tradeopps(i).ncr = pleg_price - sleg_price; % net credit recieved
        info.ammo.tradeopps(i).breakeven = pleg_strike + ncr; % breakeven price
        info.ammo.tradeopps(i).maxprofit = ncr; % max profit
        info.ammo.tradeopps(i).maxloss = sleg_strike - breakeven; % max loss
    
    case 'bearput'
        info.ammo.tradeopps(i).npp = sleg_price - pleg_price; % net premium paid
        info.ammo.tradeopps(i).breakeven = sleg_strike - npp; % breakeven price
        info.ammo.tradeopps(i).maxprofit = breakeven - pleg_strike; % max profit
        info.ammo.tradeopps(i).maxloss = npp; % max loss
        
    case 'bullcall'
        info.ammo.tradeopps(i).npp = sleg_price - pleg_price; % net premium paid
        info.ammo.tradeopps(i).breakeven = sleg_strike + npp; % breakeven price
        info.ammo.tradeopps(i).maxprofit = pleg_strike - breakeven; % max profit
        info.ammo.tradeopps(i).maxloss = npp; % max loss
        
    otherwise
        %sendmail()
        info.ammo.tradeopps(i).error.tradetype = 'inputs missing'; % error messaging
end


end

