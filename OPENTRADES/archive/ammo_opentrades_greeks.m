function [info] = ammo_opentrades_greeks(info)
%AMMO_GREEKS Calculates all greeks for option

% List of Inputs needed

info.trade(1).theoretical_price = blsprice();
info.trade(1).vega = blsvega();
info.trade(1).theta = blstheta();
info.trade(1).gamma = blsgamma();
info.trade(1).delta = blsdelta();
info.trade(1).IV = blsimprv();

end

