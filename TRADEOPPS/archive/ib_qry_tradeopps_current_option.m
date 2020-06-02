function [info] = ib_qry_tradeopps_current_option(info,i)

 symbol = info.ammo.tradeopps(i).symbol;
 expiry = '20141107';
 
 pleg_strike = info.ammo.tradeopps(i).pleg_strike;
 pleg_right = info.ammo.tradeopps(i).pleg_right;
 
 sleg_strike = info.ammo.tradeopps(i).sleg_strike;
 sleg_right = info.ammo.tradeopps(i).sleg_right;
 
 % Primary Leg Option information pull
   info.ib.tradeopps(i).ib_current_pleg_option = IBMatlab('action','query','symbol',symbol,'secType','opt',...
                         'expiry','201202','strike',pleg_strike,'right',pleg_right,'ClientID',2666,'Port',4001); %Have to figure out Expiration variable, maybe some conversion needed
   
   info.ammo.tradeopps(i).ammo_current_pleg_option = info.ib.tradeopps(i).ib_current_pleg_option; % store in ammo structure
   
   
 % Secondary Leg Option information pull
   info.ib.tradeopps(i).ib_current_sleg_option = IBMatlab('action','query','symbol',symbol,'secType','opt',...
                         'expiry','201202','strike',sleg_strike,'right',sleg_right,'ClientID',2666,'Port',4001); %Have to figure out Expiration variable, maybe some conversion needed
   
   info.ammo.tradeopps(i).ammo_current_sleg_option = info.ib.tradeopps(i).ib_current_sleg_option; % store in ammo structure
   
   
   
end