%%% AROON.M FUNCTION
% STRAT RUN OF AROON FUNCTION

%%%EVALUATES AROON AND ITS OSCILLATOR
function [info] = aroon(info)

aroon_period = info.params.aroon_period;
aroon_high_thres = info.params.aroon_high_thres;
aroon_low_thres = info.params.aroon_low_thres;
aroon_trendup = info.params.aroon_trendup;
aroon_trenddn = info.params.aroon_trenddn;

%High Price
high = info.ul.ul_x{:,3};
%Low Price
low = info.ul.ul_x{:,4};
   
%Preallocation Vectors
aroon_up = zeros(size(high,1),1);
aroon_dn = zeros(size(high,1),1);
aroon_signalcross = zeros(size(high,1),1);
aroon_trend = zeros(size(high,1),1);
      
%Flip Down Right
high = flipud(high);
low = flipud(low);
   
%Aroon Calcultation
i=0;
for i = aroon_period+1:size(high,1)
    try
    %Aroon Up Calculation
    [value, highest] = max(high((i-aroon_period):i,1));
    aroon_up(i,1) = (((aroon_period - (aroon_period - (highest - 1))))/aroon_period)*100;
    %Aroon Down Calculation
    [value, lowest] = min(low((i-aroon_period):i,1));
    aroon_dn(i,1) = (((aroon_period - (aroon_period - (lowest - 1))))/aroon_period)*100;
    catch ME
    end
end

%Aroon Oscillator
aroon_oscillator = aroon_up - aroon_dn;

%Average Trend Strength
aroon_avgoscillator = mean(aroon_oscillator);

%Aroon CrossOvers, Shows when Aroon up & down cross each other
i=0;
for i = 1:size(high,1)
try
    if aroon_oscillator(i,1) < 0 && aroon_oscillator(i-1,1) > 0
    aroon_signalcross (i,1) = -1;
    elseif aroon_oscillator(i,1) > 0 && aroon_oscillator(i-1,1) < 0
    aroon_signalcross (i,1) = 1;
    else aroon_signalcross (i,1) = 0;
    end
catch ME
end
end

%Basic Trend Indicator. Shows when aroon is above/below loose criteria.
[row] = find(aroon_oscillator > aroon_trendup);
aroon_trend(row,1) = 1;
[row] = find(aroon_oscillator < aroon_trenddn);
aroon_trend(row,1) = -1;

%High Trend Strength. Shows when aroon is above/below tight criteria.
[row] = find(aroon_oscillator > aroon_high_thres);
aroon_trend(row,1) = 2;
[row] = find(aroon_oscillator < aroon_low_thres);
aroon_trend(row,1) = -2;

%Flip Up Right
aroon_up = flipud(aroon_up);
aroon_dn = flipud(aroon_dn);
aroon_signalcross = flipud(aroon_signalcross);
aroon_oscillator = flipud(aroon_oscillator);
aroon_trend = flipud(aroon_trend);

%Aroon Structure Build
info.aroon.aroon_oscillator = aroon_oscillator;
info.aroon.aroon_trend = aroon_trend;

end