function [info] = ammo_tradeopps_traderisk(info)
try

for i = 1:size(info.ammo.tradeopps,2)
    try
%% Hard Code Variables
    pleg_strike = info.ammo.tradeopps(i).pleg.option.strike; % short strike
    pleg_price = 100 * (info.ammo.tradeopps(i).pleg.option.optPrice); % short price; multiply by 100 for calculations

    sleg_strike = info.ammo.tradeopps(i).sleg.option.strike; % long strike
    sleg_price = 100 * (info.ammo.tradeopps(i).sleg.option.optPrice); % long price; multiply by 100 for calculations 

    tradetype = info.ammo.tradeopps(i).tradetype; % hard code trade type

%% Risk Calculations

switch tradetype
    
    case'bullput'
        ncr = pleg_price - sleg_price; % net credit recieved
        info.ammo.tradeopps(i).ncr = ncr;
        
        breakeven = pleg_strike - ncr; % breakeven price
        info.ammo.tradeopps(i).breakeven = breakeven;
        
        info.ammo.tradeopps(i).maxprofit = ncr; % max profit
        info.ammo.tradeopps(i).maxloss = breakeven - sleg_strike; % max loss
    
    case 'bearcall'
        ncr = pleg_price - sleg_price; % net credit recieved
        info.ammo.tradeopps(i).ncr = ncr;
        
        breakeven = pleg_strike + ncr; % breakeven price
        info.ammo.tradeopps(i).breakeven = breakeven;
        
        info.ammo.tradeopps(i).maxprofit = ncr; % max profit
        info.ammo.tradeopps(i).maxloss = sleg_strike - breakeven; % max loss
    
    case 'bearput'
        npp = sleg_price - pleg_price; % net premium paid
        info.ammo.tradeopps(i).npp = npp;
        
        breakeven = sleg_strike - npp; % breakeven price
        info.ammo.tradeopps(i).breakeven = breakeven;
        
        info.ammo.tradeopps(i).maxprofit = breakeven - pleg_strike; % max profit
        info.ammo.tradeopps(i).maxloss = npp; % max loss
        
    case 'bullcall'
        npp = sleg_price - pleg_price; % net premium paid
        info.ammo.tradeopps(i).npp = npp;
        
        breakeven = sleg_strike + npp; % breakeven price
        info.ammo.tradeopps(i).breakeven = breakeven; 
        
        info.ammo.tradeopps(i).maxprofit = pleg_strike - breakeven; % max profit
        info.ammo.tradeopps(i).maxloss = npp; % max loss
        
    otherwise
        continue
end

    catch 
        continue
    end
end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_tradeopps_traderisk',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

