function [info] = ib_qry_opentrades_current_ul(info,i)

symbol = info.ammo.opentrades(i).symbol; % define symbol and pass through

% IB PULL FOR CURRENT MARKET INFO; This should always be the first column due to it being a structure
   info.ib.opentrades(i).ib_current_ul = IBMatlab('action','query','symbol',symbol,'ClientID',2666,'Port',4001); %Have to figure out Expiration variable, maybe some conversion needed
  
   info.ammo.opentrades(i).ammo_current_ul = info.ib.opentrades(i).ib_current_ul; % store in ammo structure

end