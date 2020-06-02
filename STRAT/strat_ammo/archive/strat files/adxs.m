%%% ADXS.M FUNCTION
% STRAT RUN OF ADXS.M FUNCTION

function [info] = adxs(info)    

adx_period = info.params.adx_period;
adx_thres = info.params.adx_thres;


%Create TR Variable from info structure
tr = info.atr.tr;

%Period variable
lag_period = adx_period - 1;

%High Price
high = info.ul.ul_x{:,3};
%Low Price
low = info.ul.ul_x{:,4};
      
%Preallocation Vectors
dmup = zeros(size(high,1),1);
dmdn = zeros(size(high,1),1);
smtr = zeros(size(high,1),1);
smdmup = zeros(size(high,1),1);
smdmdn = zeros(size(high,1),1);
zros = zeros(size(high,1),1);
zerohigh = zeros(size(high,1),1);
zerolow = zeros(size(high,1),1);
highdiff = zeros(size(high,1),1);
lowdiff = zeros(size(high,1),1);
diup = zeros(size(high,1),1);
didn = zeros(size(high,1),1);
didiff = zeros(size(high,1),1);
disum = zeros(size(high,1),1);
dx = zeros(size(high,1),1);
adx = zeros(size(high,1),1);
adx_dihistogram = zeros(size(high,1),1);
adx_disignalcross = zeros(size(high,1),1);
adx_levelcross = zeros(size(high,1),1);
adx_ditrend = zeros(size(high,1),1);  
   
%%%ADX Calculations
   
%Flip Down Right
high = flipud(high);
low = flipud(low);
tr = flipud(tr);
   
%High and Low Subtraction Vectors DM+
highdiff(2:end,1) = high(2:end,1)-high(1:end-1,1);
lowdiff(2:end,1) = low(1:end-1,1)-low(2:end,1);
   
%DM+ Calculation
[row] = find(highdiff > lowdiff);
zerohigh = max(highdiff,zros);
dmup(row,1) = zerohigh(row,1);
   
%DM- Calculation
[row] = find(lowdiff > highdiff);
zerolow = max(lowdiff,zros);
dmdn(row,1) = zerolow(row,1);
   
%Initalizing first smoothed value
smtr(15,1) = sum(tr(2:15,1));
smdmup(15,1) = sum(dmup(2:15,1));
smdmdn(15,1) = sum(dmdn(2:15,1));

%First value for Di up/down
diup(15,1) = ((smdmup(15,1)/smtr(15,1))*100);
didn(15,1) = ((smdmdn(15,1)/smtr(15,1))*100);
%First value of Di diff/sum
didiff(15,1) = abs(diup(15,1) - didn(15,1));
disum(15,1) = diup(15,1) + didn(15,1);
%First value of Dx
dx(15,1) = (didiff(15,1)/disum(15,1))*100;

%Smoothing Calculation: tr,dm+,dm-,di+,di-,di diff,di sum, dx
i=0;
for i = 16:size(high,1)
    try
        smtr(i,1) = smtr(i-1,1)-(smtr(i-1,1)/14)+ tr(i,1);
        smdmup(i,1) = smdmup(i-1,1)-(smdmup(i-1,1)/14)+ dmup(i,1);
        smdmdn(i,1) = smdmdn(i-1,1)-(smdmdn(i-1,1)/14)+ dmdn(i,1);
        
        diup(i,1) = ((smdmup(i,1)/smtr(i,1))*100);
        didn(i,1) = ((smdmdn(i,1)/smtr(i,1))*100);
        
        didiff(i,1) = abs(diup(i,1) - didn(i,1));
        disum(i,1) = diup(i,1) + didn(i,1);
        
        dx(i,1) = (didiff(i,1)/disum(i,1))*100;        
    catch ME
    end
end

%First value for adx
adx(28,1) = mean(dx(15:28,1),1);

i=0;
for i = 29:size(high,1)
    try
    adx(i,1) = ((adx(i-1,1)*lag_period) + dx(i,1))/adx_period;
    catch ME
    end
end

%DI crossover signal indicator
adx_dihistogram = diup - didn;

%DI crossover
i=0;
for i = 1:size(high,1)
    try  
        %DI crossover
        if adx_dihistogram(i,1) < 0 && adx_dihistogram(i-1,1) > 0
        adx_disignalcross(i,1) = -1;
        elseif adx_dihistogram(i,1) > 0 && adx_dihistogram(i-1,1) < 0
        adx_disignalcross(i,1) = 1;
        else adx_disignalcross(i,1) = 0;
        end
    catch ME
    end
end

%Indicator Calculations
%Allocation Signal Above Holders
abholder = zeros(size(high,1),1);
crossholder = zeros(size(high,1),1);
holder = zeros(size(high,1),1);

%Down Cross Signal
[row] = find(adx > adx_thres);
abholder(row,1) = 1;
[row]= find(adx_disignalcross == -1);
crossholder(row,1) = 1;
holder = abholder + crossholder;
[row] = find(holder == 2);
adx_levelcross(row,1) = -1;

%Reset Holders
abholder = zeros(size(high,1),1);
crossholder = zeros(size(high,1),1);
holder = zeros(size(high,1),1);

%Up Cross Signal
[row] = find(adx > adx_thres);
abholder(row,1) = 1;
[row]= find(adx_disignalcross == 1);
crossholder(row,1) = 1;
holder = abholder + crossholder;
[row] = find(holder == 2);
adx_levelcross(row,1) = 1;

%Reset Holders
abholder = zeros(size(high,1),1);
crossholder = zeros(size(high,1),1);
holder = zeros(size(high,1),1);

%DI- Trend Indicator
[row] = find(adx > adx_thres);
abholder(row,1) = 1;
[row]= find(adx_dihistogram < 0);
crossholder(row,1) = 1;
holder = abholder + crossholder;
[row] = find(holder == 2);
adx_ditrend(row,1) = -1;

%Reset Holders
abholder = zeros(size(high,1),1);
crossholder = zeros(size(high,1),1);
holder = zeros(size(high,1),1);

%DI+ Trend Indicator
[row] = find(adx > adx_thres);
abholder(row,1) = 1;
[row]= find(adx_dihistogram > 0);
crossholder(row,1) = 1;
holder = abholder + crossholder;
[row] = find(holder == 2);
adx_ditrend(row,1) = 1;

%Flip Up Right
tr =  flipud(tr);
adx = flipud(adx);
diup =  flipud(diup);
didn = flipud(didn);
adx_levelcross =  flipud(adx_levelcross);
adx_dihistogram = flipud(adx_dihistogram);
adx_disignalcross = flipud(adx_disignalcross);
adx_ditrend =  flipud(adx_ditrend);

%ADX Structure Build
info.adx.adx = adx;
info.adx.adx_dihistogram = adx_dihistogram;
info.adx.adx_disignalcross = adx_disignalcross;
info.adx.adx_levelcross = adx_levelcross;
info.adx.adx_ditrend = adx_ditrend;

end