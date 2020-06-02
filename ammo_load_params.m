function [info] = ammo_load_params(info)
try
%% Run

load C:/Users/Zato/Desktop/Master/AMMO/~mat/params.mat;%Loading strat parameters
info.params = params; %Store in info structure
clear params % delete redundant rogue params variable
    

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_load_params',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end