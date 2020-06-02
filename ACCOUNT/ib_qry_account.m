function [info] = ib_qry_account(info)
try
%% Hard Code Parameters
clientid = info.params.ibconnection.clientid;
port = info.params.ibconnection.port;

%% Run

info.ib.ib_account = IBMatlab('action','account','AccountName','REDACTED','ClientID',clientid,'Port',port); % Paper Trade Account Pull
% info.ib.ib_account = IBMatlab('action','ACCOUNT_DATA','AccountName','REDACTED','ClientID',clientid,'Port',port); % Real Money Account Pull

%% Error Handling
if isempty(info.ib.ib_account) % empty data � try to re-request the same data
    [info.ib.ib_account, ibConnectionObject] = IBMatlab('action','account','AccountName','REDACTED','ClientID',clientid,'Port',port); % Paper Trade Account Pull
end
if isempty(info.ib.ib_account) % still empty data � try to disconnect/reconnect
    ibConnectionObject.disconnectFromTWS; % disconnect from IB
    pause(1); % let IB cool down a bit
    [info.ib.ib_account, ibConnectionObject] = IBMatlab('action','account','AccountName','REDACTED','ClientID',clientid,'Port',port); % Paper Trade Account Pull
    % will automatically reconnect
end

%% Store In Ammo
info.ammo.ammo_account = info.ib.ib_account; % Store IB pulled info into ammo structure

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ib_qry_account',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
