%%% STOCHASTIC.M FUNCTION
% STRAT RUN OF STOCHASTIC.M FUNCTION
%%% Current look back parameters are (15,5,5)   

%%%Sequences
%1) Fast/Slow calculations

function [info] = stochastic(info)

% Params
so_fk_period = info.params.so_fk_period;
so_sk_period = info.params.so_sk_period;
so_sd_period = info.params.so_sd_period;
so_above_thres = info.params.so_above_thres;
so_below_thres = info.params.so_below_thres;

%Lag period variable
so_fk_period_lag = so_fk_period - 1;

%Counter for size of array
length = info.ul.ul_x{:,7};
             
%Close Price Vector
close = info.ul.ul_x{1,5};
%High Price Vector
high = info.ul.ul_x{1,3};
%Low Price Vector
low = info.ul.ul_x{1,4};
             
%Preallocation vectors
lowestlow = zeros(size(length,1),1);
highesthigh = zeros(size(length,1),1);
so_fastpctk = zeros(size(length,1),1);
             
%%%K/D calculations fast,slow
i=0;
for i =  1:size(length,1)
  try 
  lowestlow(i,1) = min(low(i:i+so_fk_period_lag,1));
  highesthigh(i,1) = max(high(i:i+so_fk_period_lag,1));
  so_fastpctk(i,1) = ((close(i,1)-lowestlow(i,1))/(highesthigh(i,1)-lowestlow(i,1)))*100;
  catch ME
  end
end
             
%Fast %D/Slow %K
so_fastpctd = flipud(tsmovavg(flipud(so_fastpctk),'s',so_sk_period,1));
%Slow %D
so_slowpctd = flipud(tsmovavg(flipud(so_fastpctd),'s',so_sd_period,1));             
%Slow K&D Difference
so_histogram = so_fastpctd - so_slowpctd;
            
             %{
             %Fast K & S Cross Over Staging 
             so_fkupcross = zeros(size(so_fastpctk,1),1);
             so_fkdncross = zeros(size(so_fastpctk,1),1);
             so_skupcross = zeros(size(so_fastpctd,1),1);
             so_skdncross = zeros(size(so_fastpctd,1),1);
             so_pullback = zeros(size(so_fastpctd,1),1);
             so_pushback = zeros(size(so_fastpctd,1),1);
             so_slow_signalcross = zeros(size(so_fastpctd,1),1);
             
             
             %Flip Down Right
             so_fastpctk = flipud(so_fastpctk);
             so_fastpctd = flipud(so_fastpctd);
             so_histogram = flipud(so_histogram);
             
             %CrossOver Loop
             i=0;
             for i =  1:size(so_fastpctk,1)
             try 
        
             %Fast K Up Cross
             if so_fastpctk(i,1) < so_above_thres && so_fastpctk(i-1,1) > so_above_thres
             so_fkupcross(i-1,1) = -1;
             elseif so_fastpctk(i,1) > so_above_thres && so_fastpctk(i-1,1) < so_above_thres
             so_fkupcross(i-1,1) = 1;
             else so_fkupcross(i-1,1) = so_fastpctk(i-1,1) - 50;
             end
             
             %Fast K Down Cross
             if so_fastpctk(i,1) < so_below_thres && so_fastpctk(i-1,1) > so_below_thres
             so_fkdncross(i-1,1) = 1;
             elseif so_fastpctk(i,1) > so_below_thres && so_fastpctk(i-1,1) < so_below_thres
             so_fkdncross(i-1,1) = -1;
             else so_fkdncross(i-1,1) = 50 - so_fastpctk(i-1,1);
             end
             
             %Slow K Up Cross
             if so_fastpctd(i,1) < so_above_thres && so_fastpctd(i-1,1) > so_above_thres
             so_skupcross(i-1,1) = -1;
             elseif so_fastpctd(i,1) > so_above_thres && so_fastpctd(i-1,1) < so_above_thres
             so_skupcross(i-1,1) = 1;
             else so_skupcross(i-1,1) = so_fastpctd(i-1,1) - 50;
             end
             
             %Slow K Down Cross
             if so_fastpctd(i,1) < so_below_thres && so_fastpctd(i-1,1) > so_below_thres
             so_skdncross(i-1,1) = 1;
             elseif so_fastpctd(i,1) > so_below_thres && so_fastpctd(i-1,1) < so_below_thres
             so_skdncross(i-1,1) = -1;
             else so_skdncross(i-1,1) = 50 - so_fastpctd(i-1,1);
             end
             
             %Slow %K&%D Crossover
             if so_histogram(i,1) < 0 && so_histogram(i-1,1) > 0
                so_slow_signalcross(i,1) = -1;
             elseif so_histogram(i,1) > 0 && so_histogram(i-1,1) < 0
                so_slow_signalcross(i,1) = 1;
             else so_slow_signalcross(i,1) = 0;
             end             
             
             
             catch ME
             end
             end
            
             
             
             
             %Signal Indicator for Slow %K Up Crosses
             i=0;
             j=0;
             for i = 1:size(so_skupcross,1)
             try
           
                if so_skupcross(i,1) == -1
                 j=0; %resets evaluation cell 
                     for j = 1:size(so_skupcross,1)
                     try
                         if so_skupcross(i+j,1) == 1,break %back to -1 eval
                         elseif so_pullback(i+j-1,1) == 1,break %back to -1 eval
                         elseif so_skupcross(i+j,1) < 0
                             so_pullback(i+j,1) = 1; break %back to -1 eval                         
                         end
                    catch ME
                    end
                    end
                end
             
             catch ME
             end
             end
             
             %Signal Indicator for Slow %K Down Crosses
             i=0;
             j=0;
             for i = 1:size(so_skdncross,1)
             try
           
             if so_skdncross(i,1) == -1
                 j=0; %resets evaluation cell 
                 for j = 1:size(so_skdncross,1)
                 try
                    if so_skdncross(i+j,1) == 1,break %back to -1 eval
                         elseif so_pushback(i+j-1,1) == 1,break %back to -1 eval
                         elseif so_skdncross(i+j,1) < 0
                             so_pushback(i+j,1) = 1; break %back to -1 eval                         
                    end
                 catch ME
                 end
                 end
             end
             
             catch ME
             end
             end
             
             %Flip Up Right
             so_fastpctk = flipud(so_fastpctk);
             so_fkupcross = flipud(so_fkupcross);
             so_fkdncross = flipud(so_fkdncross);
             so_fastpctd = flipud(so_fastpctd);
             so_skupcross = flipud(so_skupcross);
             so_skdncross = flipud(so_skdncross);
             so_pullback = flipud(so_pullback);
             so_pushback = flipud(so_pushback);
             so_histogram = flipud(so_histogram);
             so_slow_signalcross = flipud(so_slow_signalcross);
             
             
             %Signal Above Holders
             abholder = zeros(size(so_fastpctd,1),1);
             crossholder = zeros(size(so_fastpctd,1),1);
             holder = zeros(size(so_fastpctd,1),1);
             so_levelcross = zeros(size(so_fastpctd,1),1);
             
             %Down Signal
             [row] = find(so_fastpctd > so_above_thres);
             abholder(row,1) = 1;
             [row]= find(so_slow_signalcross == -1);
             crossholder(row,1) = 1;
             holder = abholder + crossholder;
             [row] = find(holder == 2);
             so_levelcross(row,1) = -1;
             
             %Reset Signal Below Holders
             abholder = zeros(size(so_fastpctd,1),1);
             crossholder = zeros(size(so_fastpctd,1),1);
             holder = zeros(size(so_fastpctd,1),1);
             
             %Above Signal
             [row] = find(so_fastpctd < so_below_thres);
             abholder(row,1) = 1;
             [row]= find(so_slow_signalcross == 1);
             crossholder(row,1) = 1;
             holder = abholder + crossholder;
             [row] = find(holder == 2);
             so_levelcross(row,1) = 1;
             %}

%Stochastic Structure Build
info.stochastic.so_fastpctd = so_fastpctd;

end
            
   
     