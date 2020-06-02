%%% LEVEL.M FUNCTION
% STRAT RUN OF LEVEL.M

%%%Finds levels of support and resistance depending on look back period of
%%%mins and maxs.
function [info] = level(info,high_prices,low_prices,p)
try
%% Load Params
level_period = info.params.strat_params.level_period;
   
%% Preallocation vectors
resistance = zeros(size(high_prices,1),1);
support = zeros(size(high_prices,1),1);

%% Period for look back period
lag_period = level_period - 1;


%% Support and Resistance Levels
i=0;
for i = 1:size(high_prices,1)
    try
        resistance(i,1) = max(high_prices(i:lag_period+i));
        support(i,1) = min(low_prices(i:lag_period+i));
    catch
        continue
    end
end

%% Store Level Structure Build
info.ammo.stage(p).strat_indicators.level.resistance = resistance;
info.ammo.stage(p).strat_indicators.level.support = support;
   
catch ME
    sendmail('ammodono@gmail.com', 'ERROR: level',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end