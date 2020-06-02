function [info] = ib_qry_current_market(info,p)
%% Notes

%% Load Parameters

clientid = info.params.ibconnection.clientid;
port = info.params.ibconnection.port;
%% Run

symbol = info.ammo.stage(p).symbol; % Hard code variable

info.ib.stage(p).current_market = IBMatlab('action','query','symbol',symbol,'ClientID',clientid,'Port',port); % Pull current market structure from IB

info.ammo.stage(p).current_market = info.ib.stage(p).current_market; % Store current market structure into ammo

end
