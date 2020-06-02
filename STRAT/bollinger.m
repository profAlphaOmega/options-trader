    %%% BOLLINGER.M FUNCTION
% STRAT RUN OF BOLLINGER.M FUNCTION

function [info] = bollinger(info,close_prices,p)  
try
%% Preallocation Vectors
bb_bandwidth = zeros(size(close_prices,1),1);
bb_stdhigh = zeros(size(close_prices,1),1);
bb_stdlow = zeros(size(close_prices,1),1);
diff = zeros(size(close_prices,1),1);
bb_highcross = zeros(size(close_prices,1),1);
bb_lowcross = zeros(size(close_prices,1),1);
bb_percentb = zeros(size(close_prices,1),1);
bb_avg_bandwidth = zeros(size(close_prices,1),1);    
%% Simple moving average 20 day
bb_sma = flipud(tsmovavg(flipud(close_prices),'s',30,1)); %middle line
        
%% Run Bollinger Band
for i = 1:size(close_prices,1)
    try       
%% band setup
        stdev = 2*std(close_prices(i:i+29,1)); % 2 standard deviations
        bb_stdhigh(i,1) = bb_sma(i,1) + stdev; % high band
        bb_stdlow(i,1) = bb_sma(i,1) - stdev; % low band
        
%% bb_bandwidth calculation
% Because Bollinger Bands are based on the standard deviation, 
%   falling BandWidth reflects decreasing volatility and rising BandWidth reflects increasing volatility

    diff(i,1) = bb_stdhigh(i,1) - bb_stdlow(i,1); % difference in band price
    bb_bandwidth(i,1) = 100 * (diff(i,1)/bb_sma(i,1)); % bandwidth measures the percentage difference between the upper band and the lower band
            
%% Percent b calculation
        bb_percentb(i,1) = ((close_prices(i,1)-bb_stdlow(i,1))/(bb_stdhigh(i,1)-bb_stdlow(i,1)));
        
        % high cross
        if close_prices(i,1) > bb_stdhigh(i,1)
            bb_highcross(i,1) = 1;
        else
            bb_highcross(i,1) = 0;
        end
        
        % low cross
        if close_prices(i,1) < bb_stdlow(i,1)
            bb_lowcross(i,1) = 1;
        else
            bb_lowcross(i,1) = 0;
        end
        
        
    catch 
        continue
    end
        
end
   
%% Average Bandwidth Calculation
for i = 1:size(bb_bandwidth,1)
    try
        bb_avg_bandwidth(i,1) = mean(bb_bandwidth(i:i+info.params.strat_params.bb_avgbandwidth),1); % bandwidth avg param has to be offset by 1 
    catch ME
    end
end

%% Absolute Width and Percentage Change for Bolinger Bands     
bb_abschange = bb_bandwidth(1:end-1,1)-bb_bandwidth(2:end,1); % physical band difference between the n day and n-1 day
bb_pctchange = (bb_bandwidth(1:end-1,1)-bb_bandwidth(2:end,1))./bb_bandwidth(2:end,1); % percentage difference of bands between the n day and n-1 day
         
%% Store in Ammo
info.ammo.stage(p).strat_indicators.bollinger.bb_percentb = bb_percentb;
info.ammo.stage(p).strat_indicators.bollinger.bb_abschange = bb_abschange;
info.ammo.stage(p).strat_indicators.bollinger.bb_pctchange = bb_pctchange;
info.ammo.stage(p).strat_indicators.bollinger.bb_bandwidth = bb_bandwidth;
info.ammo.stage(p).strat_indicators.bollinger.bb_highband = bb_stdhigh;
info.ammo.stage(p).strat_indicators.bollinger.bb_middleband = bb_sma;
info.ammo.stage(p).strat_indicators.bollinger.bb_lowband = bb_stdlow;
info.ammo.stage(p).strat_indicators.bollinger.bb_avg_bandwidth = bb_avg_bandwidth;
 
catch ME
    sendmail('ammodono@gmail.com', 'ERROR: bollinger',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
            
   
     