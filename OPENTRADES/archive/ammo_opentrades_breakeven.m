function [info] = ammo_breakeven(info)
%AMMO_BREAKEVEN finds breakeven price of short vertical
%   Detailed explanation goes here

%Inputs
short_strike =;
short_credit =;
long_price =;

break_even = short_strike - (short_credit - long_price);


info.ammo.tradeopp(i).breakeven = break_even;

end

