function [info] = ammo_opentrades_trades(info)
try
%% Load trades
load('C:\Users\Zato\Desktop\Master\AMMO\~mat\trades.m'); % load in openmat

%% Construct ConID Arrays
trades_conId = cell2mat(transpose({trades(:).conId})); % create trades contract ID array
opentrades_conId = cell2mat(transpose({info.ammo.opentrades(:).conId})); % create trades contract ID array

%% Opentrades Check and trades Classification
% is trades trade an opentrade, if so = 'open'; if not = 'historical'
    for i = 1:size(trades_conId,1)
        try

            value = trades_conId(i) == opentrades_conId; % find logical array

            value(value==0) = []; % delete all zeros

            % check to see if it was found
            if (value == 1) % if found
                trades(i).class = 'open'; % open trade classification
            else trades(i).class = 'historical'; % historical classification
            end

        catch
            continue
        end
    end

info.ammo.trades = trades; % overwrite and store trades

save('C:\Users\Zato\Desktop\Master\AMMO\~mat\trades.m','trades'); % save down open mat
save('C:\Users\Zato\Desktop\Master\AMMO\~mat\trades_archive\trades.m','trades'); % save down open mat

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_opentrades_trades',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end