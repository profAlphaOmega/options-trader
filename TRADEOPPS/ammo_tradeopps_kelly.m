function [info] = ammo_tradeopps_kelly(info)

prob_put_OTM;
credit;
long_strike;
short_strike;

%Kelly general
%p(b+1) - 1 / b

%Kelly for short verticals
%Change name of pct_bank variable to something more like kelly_indicator
% Might be able to get away with using the delta value and not POS
pct_bank = (credit - (1 - prob_put_OTM) * (long_strike - short_strike)) / credit; % might need to put abs(long_strike - short_strike) for both put and call trades

end

