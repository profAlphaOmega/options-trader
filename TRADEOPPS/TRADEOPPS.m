function [info] = TRADEOPPS(info)
try
%TRADEOPPS High Structure TRADEOPPS Function
%   All functions to pull and calculate potential trade information goes on here

    [info] = ammo_trigger(info); % trigger.m function; determine new trades based on strat indicators ONLY
    [info] = ammo_tradeopps_build(info); % Start building tradeopps from trigger signals
%     [info] = ib_qry_optionschain(info); % Query the options chain to identify if the price is right
%     [info] = ammo_tradeopps_build_optionschain(info); % Figures out what symbols to trade for combo leg
%     [info] = ammo_tradeopps_legs(info); % Find strikes for legs
%     [info] = ammo_tradeopps_traderisk(info); % find basic risk metrics BE/maxprofit/maxloss
%     
catch ME
    sendmail('ammodono@gmail.com', 'ERROR: TRADEOPPS',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

