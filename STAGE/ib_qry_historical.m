function [info] = ib_qry_historical(info)

try
%% IB Matlab pull for historical closing prices

%% Hard Code Values
durationvalue = info.params.strat_params.durationvalue; % hard code look back period for bars
clientid = info.params.ibconnection.clientid; % hard code clientid settings
port = info.params.ibconnection.port; % hard code port settings

for i = 1:size(info.ammo.stage,2) % this could be an array, might just need to take size(info.ammo.stage,1); could be the same thing essentially
    try
%% Hard Code Variables
        symbol = info.ammo.stage(i).symbol; % get symbol and store it for IBMatlab pull
        info.ib.stage(i).symbol = symbol; % Store symbol in ib_historical structure
        
        if ~isempty(find(transpose(0:17:size(info.ammo.stage,2))==i,1)) % Pause for 10 mins after every 15(3x) tickers
            pause(610);
        end
        
%% IB Pulls
        % POSSIBLY A HOLD TO MAKE SURE YOU DON'T GO OVER ANY TIME PARAMETERS
        % Query Historical Trades, historical vol, and implied vol
        
%% Historical Bars
        % historical bars IB pull
        pause(1);
        info.ib.stage(i).historical_bars = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'whatToshow','Trades','ClientID',clientid,'Port',port); % This is a Structure
        
        % error handle
        %     if isempty(info.ib.stage(i).historical_bars) % empty data – try to re-request the same data
        %         [info.ib.stage(i).historical_bars, ibConnectionObject] = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'whatToshow','Trades','ClientID',clientid,'Port',port);
        %     end
        %     if isempty(info.ib.stage(i).historical_bars) % still empty data – try to disconnect/reconnect
        %         ibConnectionObject.disconnectFromTWS; % disconnect from IB
        %         pause(1); % let IB cool down a bit
        %         info.ib.stage(i).historical_bars = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'whatToshow','Trades','ClientID',clientid,'Port',port); % will automatically reconnect
        %     end
        
%% Historical Volatility
        % historical iv IB pull
        pause(1);
        info.ib.stage(i).hv_bars = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'WhatToShow','Historical_Volatility','ClientID',clientid,'Port',port); % Historical Volatility Pull
        
        % error handle
        %     if isempty(info.ib.stage(i).hv_bars) % empty data – try to re-request the same data
        %         [info.ib.stage(i).hv_bars, ibConnectionObject] = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'WhatToShow','Historical_Volatility','ClientID',clientid,'Port',port); % Historical Volatility Pull
        %     end
        %     if isempty(info.ib.stage(i).hv_bars) % still empty data – try to disconnect/reconnect
        %         ibConnectionObject.disconnectFromTWS; % disconnect from IB
        %         pause(1); % let IB cool down a bit
        %         info.ib.stage(i).hv_bars = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'WhatToShow','Historical_Volatility','ClientID',clientid,'Port',port); % Historical Volatility Pull
        %     end
        
%% Implied Volatility
        pause(1);
        info.ib.stage(i).iv_bars = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'WhatToShow','Option_Implied_Volatility','ClientID',clientid,'Port',port); % Implied Volatility Pull
        
        % error handle
        %     if isempty(info.ib.stage(i).iv_bars) % empty data – try to re-request the same data
        %         [info.ib.stage(i).iv_bars, ibConnectionObject] = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'WhatToShow','Option_Implied_Volatility','ClientID',clientid,'Port',port); % Implied Volatility Pull
        %     end
        %     if isempty(info.ib.stage(i).iv_bars) % still empty data – try to disconnect/reconnect
        %         ibConnectionObject.disconnectFromTWS; % disconnect from IB
        %         pause(1); % let IB cool down a bit
        %         info.ib.stage(i).iv_bars = IBMatlab('action','HISTORY_DATA', 'symbol',symbol,'DurationValue',durationvalue,'DurationUnits','Y', 'barSize','1 day', 'useRTH',1,'WhatToShow','Option_Implied_Volatility','ClientID',clientid,'Port',port); % Implied Volatility Pull
        %     end
        
%% Store Bars,HV,IV into Stage
        info.ammo.stage(i).historical_bars = info.ib.stage(i).historical_bars; % store historical trade prices
        info.ammo.stage(i).historical_volatility.hv_bars = info.ib.stage(i).hv_bars; % store historical volatility
        info.ammo.stage(i).implied_volatility.iv_bars = info.ib.stage(i).iv_bars; % store implied volatility
        
        
%% Transpose, Flip, and Convert Data
        
%% Trade bars
        info.ammo.stage(i).historical_bars.dateNum = cellstr(flipud(datestr(info.ammo.stage(i).historical_bars.dateNum))); % Convert serial to date str; flipud; no need to transpose; parse out strig to cell array
        info.ammo.stage(i).historical_bars.dateTime = flipud(transpose(info.ammo.stage(i).historical_bars.dateTime)); % YYYYMMDD; transpose;flipud
        info.ammo.stage(i).historical_bars.open = flipud(transpose(info.ammo.stage(i).historical_bars.open));
        info.ammo.stage(i).historical_bars.high = flipud(transpose(info.ammo.stage(i).historical_bars.high));
        info.ammo.stage(i).historical_bars.low = flipud(transpose(info.ammo.stage(i).historical_bars.low));
        info.ammo.stage(i).historical_bars.close = flipud(transpose(info.ammo.stage(i).historical_bars.close));
        info.ammo.stage(i).historical_bars.volume = flipud(transpose(info.ammo.stage(i).historical_bars.volume));
        info.ammo.stage(i).historical_bars.count = flipud(transpose(info.ammo.stage(i).historical_bars.count));
        info.ammo.stage(i).historical_bars.WAP = flipud(transpose(info.ammo.stage(i).historical_bars.WAP));
        info.ammo.stage(i).historical_bars.hasGaps = flipud(transpose(info.ammo.stage(i).historical_bars.hasGaps));
        
%% Historical Volatility
        info.ammo.stage(i).historical_volatility.hv_bars.dateNum = cellstr(flipud(datestr(info.ammo.stage(i).historical_volatility.hv_bars.dateNum))); % Convert serial to date str; flipud; no need to transpose; parse out strig to cell array
        info.ammo.stage(i).historical_volatility.hv_bars.dateTime = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.dateTime)); % YYYYMMDD; transpose;flipud
        info.ammo.stage(i).historical_volatility.hv_bars.open = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.open));
        info.ammo.stage(i).historical_volatility.hv_bars.high = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.high));
        info.ammo.stage(i).historical_volatility.hv_bars.low = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.low));
        info.ammo.stage(i).historical_volatility.hv_bars.close = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.close));
        info.ammo.stage(i).historical_volatility.hv_bars.volume = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.volume));
        info.ammo.stage(i).historical_volatility.hv_bars.count = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.count));
        info.ammo.stage(i).historical_volatility.hv_bars.WAP = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.WAP));
        info.ammo.stage(i).historical_volatility.hv_bars.hasGaps = flipud(transpose(info.ammo.stage(i).historical_volatility.hv_bars.hasGaps));
        
%% Implied Volatility
        info.ammo.stage(i).implied_volatility.iv_bars.dateNum = cellstr(flipud(datestr(info.ammo.stage(i).implied_volatility.iv_bars.dateNum))); % Convert serial to date str; flipud; no need to transpose; parse out strig to cell array
        info.ammo.stage(i).implied_volatility.iv_bars.dateTime = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.dateTime)); % YYYYMMDD; transpose;flipud
        info.ammo.stage(i).implied_volatility.iv_bars.open = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.open));
        info.ammo.stage(i).implied_volatility.iv_bars.high = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.high));
        info.ammo.stage(i).implied_volatility.iv_bars.low = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.low));
        info.ammo.stage(i).implied_volatility.iv_bars.close = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.close));
        info.ammo.stage(i).implied_volatility.iv_bars.volume = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.volume));
        info.ammo.stage(i).implied_volatility.iv_bars.count = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.count));
        info.ammo.stage(i).implied_volatility.iv_bars.WAP = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.WAP));
        info.ammo.stage(i).implied_volatility.iv_bars.hasGaps = flipud(transpose(info.ammo.stage(i).implied_volatility.iv_bars.hasGaps));
        
    catch
        continue
    end
end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ib_qry_historical',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

%% Notes

% if looping through tickers function [info] = IB_qry_historical(symbol,j)
% info.historical.data_bar = IBMatlab('action','history','symbol', symbol{1,1}{j,1},'duration','1Y','barSize','1 day','useRTH',1,'whatToshow','Trades');
% info.historical.data_bid = IBMatlab('action','history','symbol', symbol{1,1}{j,1},'duration','1Y','barSize','1 day','useRTH',1,'whatToshow','bid');
% info.historical.data_ask = IBMatlab('action','history','symbol', symbol{1,1}{j,1},'duration','1Y','barSize','1 day','useRTH',1,'whatToshow','ask');
% info.historical.data_hv = IBMatlab('action','history','symbol', symbol{1,1}{j,1},'duration','1Y','barSize','1 day','useRTH',1,'whatToshow','Historical_Volatility');
% info.historical.data_iv = IBMatlab('action','history','symbol', symbol{1,1}{j,1},'duration','1Y','barSize','1 day','useRTH',1,'whatToshow','Option_Implied_Volatility');





%HISTORICAL QUERY LIMITATIONS 
% Historical data is limited to 2000 results (data bars) – if more than that is
% requested, the entire request is dropped.
% 2. Historical data can by default only be requested for the past year. If you have
% purchased additional concurrent real-time market data-lines from IB, then you
% can ask for historical data up to 4 years back. If you request data older than
% your allowed limit, the entire request is dropped.
% 3. Historical data requests that use a bar size of 30 seconds or less can only go
% back six months. If older data is requested, the entire request is dropped.
% 4. Requesting identical historical data requests within 15 seconds is prohibited.
% IB-Matlab will automatically return the previous results in such a case.
% 5. Requesting 6+ historical data requests for the same Contract, Exchange and
% Tick Type within 2 seconds is prohibited – the entire request will be dropped.
% 6. Requesting 60+ historical data requests of any type within 10-minutes is
% prohibited – the entire request will be dropped.
% 7. Only certain combinations of bar Duration and Size are supported:
% Duration Bar Size
% 1 Y 1 day
% 6 M 1 day
% 3 M 1 day
% 1 M 1 day, 1 hour
% 1 W 1 day, 1 hour, 30 mins, 15 mins
% 2 D 1 hour, 30 mins, 15 mins, 3 mins, 2 mins, 1 min
% 1 D 1 hour, 30 mins, 15 mins, 5 mins, 3 mins, 2 mins, 1 min, 30 secs
% 14400 S (4 hours)
% 1 hour, 30 mins, 15 mins, 5 mins, 3 mins, 2 mins, 1 min, 30 secs,
% 15 secs
% 7200 S (2 hours)
% 1 hour, 30 mins, 15 mins, 5 mins, 3 mins, 2 mins, 1 min, 30 secs,
% 15 secs, 5 secs
% 3600 S (1 hour) 15 mins, 5 mins, 3 mins, 2 mins, 1 min, 30 secs, 15 secs, 5 secs
% 1800 S (30 mins)
% 15 mins, 5 mins, 3 mins, 2 mins, 1 min, 30 secs, 15 secs, 5 secs,
% 1 sec
% 960 S (15 mins) 5 mins, 3 mins, 2 mins, 1 min, 30 secs, 15 secs, 5 secs, 1 sec
% 300 S (5 mins) 3 mins, 2 mins, 1 min, 30 secs, 15 secs, 5 secs, 1 sec
% 60 S (1 min) 30 secs, 15 secs, 5 secs, 1 sec