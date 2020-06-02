function [info] = ib_qry_tradeopps_current_ul(info,i)

symbol = info.ammo.tradeopps(i).symbol; % define symbol and pass through

% IB PULL FOR CURRENT MARKET INFO; This should always be the first column due to it being a structure
   info.ib.tradeopps(i).ib_current_ul = IBMatlab('action','query','symbol',symbol,'ClientID',2666,'Port',4001); %Have to figure out Expiration variable, maybe some conversion needed
  
   info.ammo.tradeopps(i).ammo_current_ul = info.ib.tradeopps(i).ib_current_ul; % store in ammo structure

end