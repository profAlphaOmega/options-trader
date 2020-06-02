function [info] = ammo_tradeopps(info)

[info] = ammo_trigger(info); % trigger.m function; determine new trades based on strat indicators ONLY
[info] = ammo_tradeopps_build(info); % Start building tradeopps from trigger signals
[info] = ib_qry_optionschain(info); % Query the options chain to identify if the price is right
[info] = ammo_analyze_optionschain(info); % Figures out what symbols to trade for combo leg
[info] = ammo_tradeopps_build2(info); % Rename, this is the second iteration after options chain queries

end
