%%% MACDS.M FUNCTION
% STRAT RUN OF MACD

function [info] = macds(info,close_prices,p)
try
%% Preallocation
macd_osmacross = zeros(size(close_prices,1),1);
macd_centercross = zeros(size(close_prices,1),1);
avg_macd = zeros(size(close_prices,1),1);

%% MACD & Signal Line Calculations
[macdline,macd_signalline] = macd(flipud(close_prices));
macdline = flipud(macdline);
macd_signalline = flipud(macd_signalline);

%% MACD_histogram
macd_osma = macdline - macd_signalline;
        
        
%% Flip Down Right
macd_osma = flipud(macd_osma);
macdline = flipud(macdline);
   
%% CrossOver Loop
for i =  1:size(macd_osma,1)
    try
        
      % Signal Line CrossOver
        if macd_osma(i,1) < 0 && macd_osma(i-1,1) > 0
            macd_osmacross(i,1) = -1;
        elseif macd_osma(i,1) > 0 && macd_osma(i-1,1) < 0
            macd_osmacross(i,1) = 1;
        else macd_osmacross(i,1) = 0;
        end
        
      % MACD Line CrossOver
        if macdline(i,1) < 0 && macdline(i-1,1) > 0
            macd_centercross(i,1) = -1;
        elseif macdline(i,1) > 0 && macdline(i-1,1) < 0
            macd_centercross(i,1) = 1;
        else macd_centercross(i,1) = 0;
        end
        
    catch 
        continue
    end
end
        
%% Flip Up Right
macd_osma = flipud(macd_osma);
macd_osmacross = flipud(macd_osmacross);
macdline = flipud(macdline);
macd_centercross = flipud(macd_centercross);
        
%% Average MACD
for i = 1:size(macdline,1)
    try
        avg_macd(i,1) = mean(macdline(i:i+info.params.strat_params.avg_macd_lookback),1);
    catch
        continue
    end
end
%% Fast MACD
% ma_six = flipud(tsmovavg(flipud(close_prices),'e',6,1));
% ma_twelve = flipud(tsmovavg(flipud(close_prices),'e',12,1));
% macd_fast = ma_six - ma_twelve;
 
%% MACD Structure Build
info.ammo.stage(p).strat_indicators.macd.macdline = macdline; % (12-day EMA - 26-day EMA); higher(lower) the value the faster prices are moving up(down)
info.ammo.stage(p).strat_indicators.macd.macd_osma = macd_osma; % difference between macdline and signal line, above(below) up(down) trend
info.ammo.stage(p).strat_indicators.macd.macd_osmacross = macd_osmacross; % flag for when osma goes positive(negative)
info.ammo.stage(p).strat_indicators.macd.macd_centercross = macd_centercross; % positive(negative) shows when 12-day goes above(below) the 26-day
info.ammo.stage(p).strat_indicators.macd.avg_macd = avg_macd; % average macd
% info.ammo.stage(p).strat_indicators.macd.macd_fast = macd_fast;

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: macds',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
            
     