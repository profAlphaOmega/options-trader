%%% MOVEAVG.M FUNCTION
% STRAT RUN FOR MOVING AVERAGE FUNCTION

function [info] = moveavg(info)
      
% Params
ma_iii_value = info.params.ma_iii_value;
ma_c_value = info.params.ma_c_value;
ma_cc_value = info.params.ma_cc_value;
ma_c_short = info.params.ma_c_short;
ma_cc_short = info.params.ma_cc_short;
ma_tslope_value = info.params.ma_tslope_value;

%Close Price Vector
close = info.ul.ul_x{:,5};
pkey = info.counter.pkey;

%Preallocation
ma_tslope = zeros(size(close,1),1);

%Calculates moving averages
if size(close,1) > 100
   ma_iii = flipud(tsmovavg(flipud(close),'s',ma_iii_value,1)); 
   ma_c = flipud(tsmovavg(flipud(close),'s',ma_c_value,1)); 
   ma_cc = flipud(tsmovavg(flipud(close),'s',ma_cc_value,1));  
   ma_oscillator = ma_iii - ma_cc;
else
       ma_iii = flipud(tsmovavg(flipud(close),'s',3,1)); 
       ma_c = flipud(tsmovavg(flipud(close),'s',ma_c_short,1));
       ma_cc = flipud(tsmovavg(flipud(close),'s',ma_cc_short,1));
       ma_oscillator = ma_iii - ma_cc;
end

%Calculates moving average 200 day slope
   for i = 1:size(ma_cc,1)
       try
           ma_tslope(i,1) = (ma_cc(i,1) - ma_cc(i+ma_tslope_value,1))/(pkey(i,1)-pkey(i+ma_tslope_value,1));
       catch ME
       end
   end

%Moving Average Structure Build
info.moveavg.ma_c = ma_c;
info.moveavg.ma_iii = ma_iii;
info.moveavg.ma_oscillator = ma_oscillator;
info.moveavg.ma_tslope = ma_tslope;


end
            
       %5-Day Moving Average    
       %fiveday(i,1) = sum(ul{1,5}(i:i+4,1))/5;