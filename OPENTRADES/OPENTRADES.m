function [info] = OPENTRADES(info)
try
% OPEN_TRADES

[info] = ib_qry_portfolio(info); % query portfolio information and store in ammo opentrades
[info] = ammo_opentrades_build(info); % append stage data to opentrades
[info] = ammo_portfolio_trades(info); % parse out open trades
% [info] = ammo_closeout_table(info)

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: OPENTRADES',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

