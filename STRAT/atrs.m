%%% ATRS.M FUNCTION
% STRAT RUN OF ATRS.M FUNCTION

function [info] = atrs(info,close_prices,high_prices,low_prices,p)
try
%% Load Params
atr_period = info.params.strat_params.atr_period;

%% Prealllocation Vectors
hl = zeros(size(close_prices,1),1);
hc = zeros(size(close_prices,1),1);
lc = zeros(size(close_prices,1),1);
tr = zeros(size(close_prices,1),1);
atr = zeros(size(close_prices,1),1);
avg_atr = zeros(size(close_prices,1),1);

%% Period variable
lag_period = atr_period - 1;
   
   
%% Flip Down Right
high_prices = flipud(high_prices);
low_prices = flipud(low_prices);
close_prices = flipud(close_prices);
   
%% HL HC LC calculation
hl = high_prices - low_prices;
hc(2:end,1) = abs(high_prices(2:end,1) - close_prices(1:end-1,1));
lc(2:end,1) = abs(low_prices(2:end,1) - close_prices(1:end-1,1));
   
%% Combine for evaluation
hlc = [hl hc lc];
   
%% TR calculation. Finds max from HL HC LC for each row. 
for i = 1:size(hl,1)
    try
        tr(i,1) = max(hlc(i,:));
    catch
        continue
    end
end

%% ATR average calculation. 14 day average of TR
atr(14,1) = mean(tr(1:14,1));

%% ATR calculation
for i = 15:size(atr,1)
    try
    atr(i,1) = ((atr(i-1,1)*lag_period) + tr(i,1))/atr_period;
    catch 
        continue
    end
end

%% Flip Up Right
atr = flipud(atr);
tr = flipud(tr);

for i = 1:size(atr,1)
    try
   avg_atr(i,1) = mean(atr(i:i+89));   
    catch ME
    end
end

%% Store ATR Structure Build
info.ammo.stage(p).strat_indicators.atr.atr = atr;
info.ammo.stage(p).strat_indicators.atr.avg_atr = avg_atr;
info.ammo.stage(p).strat_indicators.atr.tr = tr;

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: atrs',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end