function [info] = ammo_tradeopps_build(info)
try
%% Tradeopps Test
for i = 1:size(info.ammo.stage,2)
    try
        % Signal Condition
        if (info.ammo.stage(i).strat_indicators.trigger.sell_call(1,1) == 1 || info.ammo.stage(i).strat_indicators.trigger.sell_put(1,1) == 1)
        %% Store Tradeopps from Stage
            info.ammo.tradeopps(i) = info.ammo.stage(i);
        end
    catch
        continue
    end
end

%% Build Tradeopps
i = [];
for i = 1:size(info.ammo.tradeopps,2)
    try
%% Actions
        info.ammo.tradeopps(i).pleg.pleg_action = 'SELL'; % primary leg Action
        info.ammo.tradeopps(i).sleg.sleg_action = 'BUY'; % secondary leg Action
        
%% Expiry and DTE
        [info] = ammo_tradeopps_expiration(info,i); % finds closest thursday to dte and outputs formatted date string and actual DTE value
        
%% Rights
        if info.ammo.stage(i).strat_indicators.trigger.sell_call == 1 % If signal to sell call, primary leg is 'c', secondary is 's'
            info.ammo.tradeopps(i).pleg.pleg_right = 'CALL'; % Primary leg Right
            info.ammo.tradeopps(i).sleg.sleg_right = 'PUT'; % Secondary leg Right
        elseif info.ammo.stage(i).strat_indicators.trigger.sell_put == 1 % If signal to sell put, primary leg is 's', secondary is 'c'
            info.ammo.tradeopps(i).pleg.pleg_right = 'PUT'; % Primary leg Right
            info.ammo.tradeopps(i).sleg.sleg_right = 'CALL'; % Secondary leg Right
        else
            info.ammo.error.tradeopps.error = 'Error: trigger pull error'; 
        end
        
%% Tradetype
% has to be after right and action building

        if (strcmp(info.ammo.tradeopps(i).pleg.pleg_right,'CALL') && strcmp(info.ammo.tradeopps(i).pleg.pleg_action,'SELL')) % bear call spread
            info.ammo.tradeopps(i).tradetype = 'bearcall';
        elseif (strcmp(info.ammo.tradeopps(i).pleg.pleg_right,'CALL') && strcmp(info.ammo.tradeopps(i).pleg.pleg_action,'BUY')) % bull call spread
            info.ammo.tradeopps(i).tradetype = 'bullcall';
        elseif (strcmp(info.ammo.tradeopps(i).pleg.pleg_right,'PUT') && strcmp(info.ammo.tradeopps(i).pleg.pleg_action,'SELL')) % bull put spread
            info.ammo.tradeopps(i).tradetype = 'bullput';
        elseif (strcmp(info.ammo.tradeopps(i).pleg.pleg_right,'PUT') && strcmp(info.ammo.tradeopps(i).pleg.pleg_action,'BUY')) % bear put spread
            info.ammo.tradeopps(i).tradetype = 'bearput';
        else
            info.ammo.tradeopps(i).error.tradestrategy = 0;
        end
     
    
    catch
        continue
    end
end


catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_tradeopps_build',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
