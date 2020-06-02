function [info] = ACCOUNT(info)
try
%ACCOUNT High Structure Account Function
%   All functions to pull and calculate account information goes on here

 [info] = ib_qry_account(info);%Query account data

catch ME
sendmail('REDACTED', 'ERROR: ACCOUNT',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]); 
end
end

