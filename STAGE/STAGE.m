function [info] = STAGE(info)
try
%% Build Run List
[info] = ammo_stage_build(info); % Build a run list
    
%% Historical Data Pull
[info] = ib_qry_historical(info); % Query historical data

%% Current Market Pull
[info] = ib_qry_current_ul(info); % Current market data

%% ATM Option Pull
[info] = ib_atm_option(info); % Current market data

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: STAGE',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
