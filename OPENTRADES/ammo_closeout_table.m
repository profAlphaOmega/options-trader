function [info] = ammo_closeout_table(info)
try
%% Run
for i = 1:size(info.ammo.opentrades,2)
    try
%% Soft Code Variables
        days_held = info.ammo.opentrades(i).days_held; % days held
        pct_profit = info.ammo.opentrades(i).pomax; % percentage of profit

%% Closeout Check
        if (info.ammo.opentrades(i).position == -1) % if short position
            
            switch days_held
                
                case le(days_held,3)
                    if ge(pct_profit,.10)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,5)
                    if ge(pct_profit,.20)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,10)
                    if ge(pct_profit,.30)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,15)
                    if ge(pct_profit,.40)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,19)
                    if ge(pct_profit,.50)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,24)
                    if ge(pct_profit,.60)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,28)
                    if ge(pct_profit,.70)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,32)
                    if ge(pct_profit,.80) % check this figure
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,35)
                    if ge(pct_profit,90)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                case le(days_held,40)
                    if ge(pct_profit,95)
                        closeout = 1;
                    else
                        closeout = 0;
                    end
                    
                otherwise
                    closeout = 0;
            end
            
        else closeout = 0; % if position is a long; sleg
        end

%% Store Closeout In AMMO
        info.ammo.opentrades(i).closeout = closeout;
        
    catch
        continue
    end
end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_closeout_table',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

%%Table 
% 10 - 3
% 20 - 6
% 30 - 10
% 40 - 15
% 50 - 19
% 60 - 24
% 70 - 28
% 80 - 32
% 90 - 35
% 100 - expiration

