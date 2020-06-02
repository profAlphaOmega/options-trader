function [info] = ib_qry_portfolio(info)
try
%% Hard Code Parameters
clientid = info.params.ibconnection.clientid; % clientId
port = info.params.ibconnection.port; % port

%% Query Portfolio Information
    
    info.ib.opentrades = IBMatlab('action','portfolio','ClientID',clientid,'Port',port);
    %error handle
    if isempty(info.ib.opentrades) % empty data – try to re-request the same data
        [info.ib.opentrades, ibConnectionObject] = IBMatlab('action','portfolio','ClientID',clientid,'Port',port);
    end
    if isempty(info.ib.opentrades) % still empty data – try to disconnect/reconnect
        ibConnectionObject.disconnectFromTWS; % disconnect from IB
        pause(1); % let IB cool down a bit
        info.ib.opentrades = IBMatlab('action','portfolio','ClientID',clientid,'Port',port); % will automatically reconnect
    end

%% Store IB opentrades pull into ammo
info.ammo.opentrades = info.ib.opentrades; 

%% Delete Closed Positions
    index = (cell2mat(transpose({info.ammo.opentrades(:).position})) == 0);
    info.ammo.opentrades(index) = [];

%% bring conId forward
        for i = 1:size(info.ammo.opentrades,2)
            try
                info.ammo.opentrades(i).conId = info.ammo.opentrades(i).contract.m_conId;
            catch
                continue
            end
        end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ib_qry_portfolio',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
