function [info] = ammo_executions_trades(info)
try
%% Run 
% trades and executions need to have the same fields

%% Load trades
load('C:\Users\Zato\Desktop\Master\AMMO\~mat\trades.m'); % load in openmat

%% Construct ConID Arrays
if(~isempty(info.ammo.executions))
    executions_conId = cell2mat(transpose({info.ammo.executions(:).conId})); % create execution contract ID array
    trades_conId = cell2mat(transpose({trades(:).conId})); % create trades contract ID array

    %% Executions Check
    % is executed trade in trades file already, if so = do nothing; if not = append
    for i = 1:size(executions_conId,1)
        try

            value = executions_conId(i) == trades_conId; % find logical array
            value(value==0) = []; % delete all zeros

            % check to see if it was found
            if (isempty(value)) % if not found
            trades(end+1) = info.ammo.executions(i); % append execution in openmat if not found
            end

            % if found, do nothing, skip onto the next

        catch
            continue
        end
    end

%% Store trades In AMMO
info.ammo.trades = trades; % store openmat in ammo

%% Save trades
save('C:\Users\Zato\Desktop\Master\AMMO\~mat\trades.m','trades'); % save mat
save('C:\Users\Zato\Desktop\Master\AMMO\~mat\archive\trades_archive.m','trades'); % save archive mat
end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_executions_trades',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end