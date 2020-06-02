%%% AROON.M FUNCTION
% STRAT RUN OF AROON FUNCTION

%%%EVALUATES AROON AND ITS OSCILLATOR
function [info] = aroon(info,high_prices,low_prices,p)
try
%% Load Params
aroon_period = info.params.strat_params.aroon_period;
aroon_high_thres = info.params.strat_params.aroon_high_thres;
aroon_low_thres = info.params.strat_params.aroon_low_thres;
aroon_trendup = info.params.strat_params.aroon_trendup;
aroon_trenddn = info.params.strat_params.aroon_trenddn;

%% Preallocation Vectors
aroon_up = zeros(size(high_prices,1),1);
aroon_dn = zeros(size(high_prices,1),1);
aroon_signalcross = zeros(size(high_prices,1),1);
aroon_trend = zeros(size(high_prices,1),1);
      
%% Flip Down Right
high_prices = flipud(high_prices);
low_prices = flipud(low_prices);
   
%% Aroon Calcultation
i=0;
for i = aroon_period+1:size(high_prices,1)
    try
      % Aroon Up Calculation
        [value, highest] = max(high_prices((i-aroon_period):i,1));
        aroon_up(i,1) = (((aroon_period - (aroon_period - (highest - 1))))/aroon_period)*100;
      % Aroon Down Calculation
        [value, lowest] = min(low_prices((i-aroon_period):i,1));
        aroon_dn(i,1) = (((aroon_period - (aroon_period - (lowest - 1))))/aroon_period)*100;
    catch
        continue
    end
end

%% Aroon Oscillator
aroon_oscillator = aroon_up - aroon_dn; % difference between up trend strength and down trend strength

%% Average Trend Strength
aroon_avgoscillator = mean(abs(aroon_oscillator)); % typical value in abs terms; shows the average strength of the swings

%% Aroon CrossOvers, Flag for when Aroon up & down cross each other
i=0;
for i = 1:size(high_prices,1)
    try
        if aroon_oscillator(i,1) < 0 && aroon_oscillator(i-1,1) > 0
            aroon_signalcross (i,1) = -1;
        elseif aroon_oscillator(i,1) > 0 && aroon_oscillator(i-1,1) < 0
            aroon_signalcross (i,1) = 1;
        else aroon_signalcross (i,1) = 0;
        end
    catch
        continue
    end
end

%% Basic Trend Indicator. Shows when aroon is above/below a certain parameter (weak).
[row] = find(aroon_oscillator > aroon_trendup);
aroon_trend(row,1) = 1;
[row] = find(aroon_oscillator < aroon_trenddn);
aroon_trend(row,1) = -1;

%% High Trend Strength. Shows when aroon is above/below certain parameter (strong).
[row] = find(aroon_oscillator > aroon_high_thres);
aroon_trend(row,1) = 2;
[row] = find(aroon_oscillator < aroon_low_thres);
aroon_trend(row,1) = -2;

%% Flip Up Right
aroon_up = flipud(aroon_up);
aroon_dn = flipud(aroon_dn);
aroon_signalcross = flipud(aroon_signalcross);
aroon_oscillator = flipud(aroon_oscillator);
aroon_trend = flipud(aroon_trend);

%% Store Aroon Structure Build
info.ammo.stage(p).strat_indicators.aroon.aroon_oscillator = aroon_oscillator; % shows value of trend
info.ammo.stage(p).strat_indicators.aroon.aroon_trend = aroon_trend; % shows threshold signals for trend
info.ammo.stage(p).strat_indicators.aroon.aroon_signalcross = aroon_signalcross; % shows trend crossover
info.ammo.stage(p).strat_indicators.aroon.aroon_avgoscillator = aroon_avgoscillator; % shows average trend strength

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: aroon',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end