function [info] = EXECUTIONS(info)
try
    
[info] = ib_qry_executions(info); % query executed trades for the day

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: EXECUTIONS',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
