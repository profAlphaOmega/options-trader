function [info] = ALERTS(info)
try

    [info] = alerts_dte(info); % days to expiration notification
    
catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ALERTS',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end