function [info] = alerts_dte(info)
try
 % catch statment for no opentrades held %%info.ammo.opentrades ~= 0
    %% Hard Code Params
  dte_alert = info.params.alerts.dte;    
    
%% DTE Alerts
    vector_dte = cell2mat(transpose({info.ammo.opentrades(:).dte})); % dte opentrades vector
    
    index_dte = le(vector_dte,dte_alert); % logical array; find where dte is less than alert value
    index_test = index_dte; % create test variable
    index_test(index_test==0) = []; % delete all zeros
    if(~isempty(index_test))
        info.alerts.dte.count = size(info.ammo.opentrades(index_dte),2); % count of how many dte alerts there are
        %sendmail('ammodono@gmail.com', 'ALERTS: alerts_dte',['You have ' num2str(alert_count) ' number of trades that will expire soon' 10 10 'conId: ' ]);
    else
        info.alerts.dte.count = 0;
    end
    

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: alerts_dte',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
