function [info] = ib_qry_current_ul(info)
try
%% Hard Code Parameters

clientid = info.params.ibconnection.clientid; % client id
port = info.params.ibconnection.port; % port


%% Run
for i = 1:size(info.ammo.stage,2)
    try
    
   symbol = info.ammo.stage(i).symbol; % soft code symbol
   
   % Current Market IB Pull
   info.ib.stage(i).current_ul = IBMatlab('action','query','symbol',symbol,'ClientID',clientid,'Port',port); % current ul pull
   % error handling
   if (info.ib.stage(i).current_ul.bidPrice == -1) || isempty(info.ib.stage(i).current_ul) % empty data – try to re-request the same data
       [info.ib.stage(i).current_ul, ibConnectionObject] = IBMatlab('action','query','symbol',symbol,'ClientID',clientid,'Port',port); % current ul pull
   end
   if (info.ib.stage(i).current_ul.bidPrice == -1) || isempty(info.ib.stage(i).current_ul) % still empty data – try to disconnect/reconnect
       ibConnectionObject.disconnectFromTWS; % disconnect from IB
       pause(1); % let IB cool down a bit
       info.ib.stage(i).current_ul = IBMatlab('action','query','symbol',symbol,'ClientID',clientid,'Port',port); % current ul pull
   end
   
 
%% Store In Ammo
   info.ammo.stage(i).current_ul = info.ib.stage(i).current_ul; % store in ammo structure
      
    catch
        continue
    end
end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ib_qry_current_ul',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end