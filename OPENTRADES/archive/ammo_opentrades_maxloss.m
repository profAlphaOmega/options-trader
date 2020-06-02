function [info] = ammo_maxloss(info)
%AMMO_MAXLOSS finds max loss of short vertical


%Inputs
short_strike =;
long_strike =;
short_credit =;
long_debit =;

max_loss = -((short_strike - long_strike) - (short_credit - long_debit)); % - (width of the strikes - net credit)

info.tradeopp.max_loss(1) = max_loss;

end
