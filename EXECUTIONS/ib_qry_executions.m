function [info] = ib_qry_executions(info)
try
%% Hard Code Params
clientid = info.params.ibconnection.clientid;
port = info.params.ibconnection.port;

%% Query Portfolio Information
  info.ib.executions = IBMatlab('action','query','type','executions','ClientID',clientid,'Port',port);
    % error handle
    if isempty(info.ib.executions) % empty data – try to re-request the same data
        pause(1);
        [info.ib.executions, ibConnectionObject] = IBMatlab('action','query','type','executions','ClientID',clientid,'Port',port);
    end

    
info.ammo.executions = info.ib.executions; % Store IB opentrades pull into ammo



catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ib_qry_executions',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

% %% Bring Forward Elements
% if(~isempty(info.ammo.executions)) % skip if no executions have occured that day
% for i = 1:size(info.ammo.executions,2)
%     try
%         info.ammo.executions(i).conId = info.ammo.executions(i).contract.m_conId; % bring foward contract ID
%         info.ammo.executions(i).localsymbol = info.ammo.executions(i).contract.m_localSymbol; % bring foward localsymbol
%         
%         date_string = info.ammo.executions(i).time(1:8); % find date placed
%         data_string(isspace(date_string)) = []; % Get rid of spaces
%         info.ammo.executions(i).date_placed = datenum(date_string,'yyyymmdd'); % store serial number date placed for calculations
%         
%         info.ammo.executions(i).class = 'unclassified'; % intialize classification
%         
%     catch
%         continue
%     end
% end
% end