%%% ATRS.M FUNCTION
% STRAT RUN OF ATRS.M FUNCTION

function [info] = atrs(info)

%Param
atr_period = info.params.atr_period;

%Period variable
lag_period = atr_period - 1;
   
%High Price
high = info.ul.ul_x{:,3};
%Low Price
low = info.ul.ul_x{:,4};
%Close Price
close = info.ul.ul_x{:,5};
   
%Prealllocation Vectors
hl = zeros(size(close,1),1);
hc = zeros(size(close,1),1);
lc = zeros(size(close,1),1);
tr = zeros(size(close,1),1);
atr = zeros(size(close,1),1);
   
%Flip Down Right
high = flipud(high);
low = flipud(low);
close = flipud(close);
   
%HL HC LC calculation
hl = high - low;
hc(2:end,1) = abs(high(2:end,1) - close(1:end-1,1));
lc(2:end,1) = abs(low(2:end,1) - close(1:end-1,1));
   
%Combine for evaluation
hlc = [hl hc lc];
   
%TR calculation. Finds max from HL HC LC for each row. 
for i = 1:size(hl,1)
    try
    tr(i,1) = max(hlc(i,:));        
    catch ME
    end
end

%ATR average calculation. 14 day average of TR
atr(14,1) = mean(tr(1:14,1));

%ATR calculation
for i = 15:size(atr,1)
    try
    atr(i,1) = ((atr(i-1,1)*lag_period) + tr(i,1))/atr_period;
    catch ME
    end
end

%Flip Up Right
atr = flipud(atr);
tr = flipud(tr);

%ATR Structure Build
info.atr.atr = atr;
info.atr.tr = tr;

end