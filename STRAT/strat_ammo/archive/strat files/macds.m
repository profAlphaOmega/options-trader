%%% MACDS.M FUNCTION
% STRAT RUN OF MACD

function [info] = macds(info)

%Price Vector
close = inf.ul.ul_x{:,5};
        
%MACD & Signal Line Calculations
[macdline macd_signalline] = macd(flipud(close));
macdline = flipud(macdline);
macd_signalline = flipud(macd_signalline);

%MACD_histogram
macd_histogram = macdline - macd_signalline;
        
%Preallocation
macd_signalcross = zeros(size(macd_histogram,1),1);
macd_centercross = zeros(size(macd_histogram,1),1);
        
%Flip Down Right
macd_histogram = flipud(macd_histogram);
macdline = flipud(macdline);
        
%CrossOver Loop
for i =  1:size(macd_histogram,1)
try 
        
%Signal Line CrossOver
if macd_histogram(i,1) < 0 && macd_histogram(i-1,1) > 0
macd_signalcross(i,1) = -1;
elseif macd_histogram(i,1) > 0 && macd_histogram(i-1,1) < 0
macd_signalcross(i,1) = 1;
else macd_signalcross(i,1) = 0;
end
        
%MACD Line CrossOver
if macdline(i,1) < 0 && macdline(i-1,1) > 0
macd_centercross(i,1) = -1;
elseif macdline(i,1) > 0 && macdline(i-1,1) < 0
macd_centercross(i,1) = 1;
else macd_centercross(i,1) = 0;
end
        
catch ME
end
end
        
%Flip Up Right
macd_histogram = flipud(macd_histogram);
macd_signalcross = flipud(macd_signalcross);
macdline = flipud(macdline);
macd_centercross = flipud(macd_centercross);
        
%Fast MACD
ma_six = flipud(tsmovavg(flipud(close),'e',6,1));
ma_twelve = flipud(tsmovavg(flipud(close),'e',12,1));
macd_fast = ma_six - ma_twelve;
 
%MACD Structure Build
info.macd.macdline = macdline;
info.macd.macd_fast = macd_fast;
info.macd.macd_historgram = macd_historgram;       

end
            
     