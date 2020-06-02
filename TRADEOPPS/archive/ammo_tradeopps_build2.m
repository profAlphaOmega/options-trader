function [info] = ammo_tradeopps_build2(info)
%% AMMO_tradeops Construct potential trades
% Notes

% have to change opentrades(i) vars to trigger to pull correct information

%   Iterate through what was deemed as an potential trade

% Potential Global Variables
% for some variable you may be able to just query ib for relevant
% information on a ticker; currently it is assuming that these global
% variables are for the same ticker

% prob_put_OTM, potentially Delta;
% credit;
% long_strike;
% short_strike;
% Delta, IB qry or blsdelta()
% Current UL Price, IB qry
% Current Long Price, IB qry
% Current Short Price, IB qry

% Primary strike
% Primary price
% Secondary strike
% Secondary price

i=0;
for i = 1:size(info.ammo.tradeopps,2)% go off of 2nd dimension for a structure
    try
%% Pulled info; some are caclulated, may want to seperate from the others        
  % THIS WILL PROBABLY ALREADY BE STORE IN THE OPTIONS CHAIN FUNCTION
% Get this from analyze_options_chain function
   info.ammo.tradeopps(i).pleg_strike = ;
   info.ammo.tradeopps(i).pleg_price = ; % possibly another ib_current market query
   info.ammo.tradeopps(i).sleg_strike = ;
   info.ammo.tradeopps(i).sleg_price = ; % possibly another ib_current market query
   
   
%% Max Profit/Loss/Breakeven
   [info] = ammo_tradeopps_traderisk(info,i); % calculate breakeven, max profit, and max loss for trade type
   
%% Kelly
   [info] = kelly(info); %MAY ONLY NEED THIS FUNCTION IN TRADE OPPS, UNLESS YOU WANT TO TRACK KELLY OVER COURSE OF CONTRACT LIFE; 
%    put in necessary input as sudo-global vars in this function (outside the loop), and then delete inputs once done so trade opps can input them in there
    info.ammo.tradeopps(i).ammo_kelly = somekellyfunction; % Kelly, this needs some work   
  

    catch ME
    end
   
end
% Insert header rows in info.ammo.ammo_opentrades matrix

end