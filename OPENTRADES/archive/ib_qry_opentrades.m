  function [info] = ib_qry_opentrades(info)
%% Hard Code Parameters
  
clientid = info.params.ibconnection.clientid;
port = info.params.ibconnection.port;

%% Run

info.ib.opentrades = IBMatlab('action','query', 'type','open','ClientID',clientid,'Port',port); % Pull Opentrades from IB

info.ammo.opentrades = info.ib.opentrades; % Store IB opentrades pull into ammo

end