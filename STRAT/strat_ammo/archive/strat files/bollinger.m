%%% BOLLINGER.M FUNCTION
% STRAT RUN OF BOLLINGER.M FUNCTION

%%%This function runs the bollinger band indicator. 20 day sma with 2
%%%standard deviation bands. It also calculates bollinger band percent b
%%%and band width changes.

function [info] = bollinger(info)


%Close Price Vector
close = info.ul.ul_x{:,5};
    
%Preallocation Vectors
bb_bandwidth = zeros(size(close,1),1);
bb_stdhigh = zeros(size(close,1),1);
bb_stdlow = zeros(size(close,1),1);
diff = zeros(size(close,1),1);
bb_highcross = zeros(size(close,1),1);
bb_lowcross = zeros(size(close,1),1);
bb_percentb = zeros(size(close,1),1);
    
%Simple moving average 20 day
bb_sma = flipud(tsmovavg(flipud(close),'s',20,1));
        
%Bollinger band calculations. SMA, percentb, bands, band crosses, abs change, and pct
%change
for i = 1:size(close,1)
try 

%Band setup
stdev = 2*std(ul{1,5}(i:i+19,1));
bb_stdhigh(i,1) = bb_sma(i,1) + stdev;
bb_stdlow(i,1) = bb_sma(i,1) - stdev;
diff(i,1) = 2*stdev;
                
%bb_bandwidth calculation
bb_bandwidth(i,1) = diff(i,1)/bb_sma(i,1);
                
% %b calculation
bb_percentb(i,1) = ((close(i,1)-bb_stdlow(i,1))/(bb_stdhigh(i,1)-bb_stdlow(i,1)));
                
%Crossover test
    %High cross
    if close(i,1) > bb_stdhigh(i,1)
    bb_highcross(i,1) = 1;
    else
    bb_highcross(i,1) = 0;
    end
    %Low cross            
    if close(i,1) < bb_stdlow(i,1)
    bb_lowcross(i,1) = 1;
    else
    bb_lowcross(i,1) = 0;
    end

catch ME
end
end
             
%Width and Change for Bolinger Bands     
bb_abschange = bb_bandwidth(1:end-1,1)-bb_bandwidth(2:end,1);
bb_pctchange = (bb_bandwidth(1:end-1,1)-bb_bandwidth(2:end,1))./bb_bandwidth(2:end,1);
         
%Bollinger Structure Build
info.bollinger.bb_percentb = bb_percentb;


end
            
   
     