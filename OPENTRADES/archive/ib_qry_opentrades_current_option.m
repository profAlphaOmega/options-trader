function [info] = ib_qry_opentrades_current_option(info,i)


symbol = info.ib_opentrades(i).contract.m_symbol;
expiry = ;
strike = info.ib_opentrades(i).contract.m_strike;
right = info.ib_opentrades(i).contract.m_right;




 symbol = info.ammo.opentrades(i).symbol;
 expiry = '20141107';
 
 pleg_strike = info.ammo.opentrades(i).pleg_strike;
 pleg_right = info.ammo.opentrades(i).pleg_right;
 
 sleg_strike = info.ammo.opentrades(i).sleg_strike;
 sleg_right = info.ammo.opentrades(i).sleg_right;
 
 % Primary Leg Option information pull
   info.ib.opentrades(i).ib_current_pleg_option = IBMatlab('action','query','symbol',symbol,'secType','opt',...
                         'expiry','201202','strike',pleg_strike,'right',pleg_right,'ClientID',2666,'Port',4001); %Have to figure out Expiration variable, maybe some conversion needed
   
   info.ammo.opentrades(i).ammo_current_pleg_option = info.ib.opentrades(i).ib_current_pleg_option; % store in ammo structure
   
   
 % Secondary Leg Option information pull
   info.ib.opentrades(i).ib_current_sleg_option = IBMatlab('action','query','symbol',symbol,'secType','opt',...
                         'expiry','201202','strike',sleg_strike,'right',sleg_right,'ClientID',2666,'Port',4001); %Have to figure out Expiration variable, maybe some conversion needed
   
   info.ammo.opentrades(i).ammo_current_sleg_option = info.ib.opentrades(i).ib_current_sleg_option; % store in ammo structure
   
   
   
end