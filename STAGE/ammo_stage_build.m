function [info] = ammo_stage_build(info)
try
%% Run

for i = 1:size(info.params.tickers,2)
    try
%% Store Parameters as Varaiables
info.ammo.stage(i).symbol = info.params.tickers(i).symbol; % Build symbols and exchange
info.ammo.stage(i).call_atmexpiry = info.params.tickers(i).call_atmexpiry; % Build symbols and exchange
info.ammo.stage(i).put_atmexpiry = info.params.tickers(i).put_atmexpiry; % Build symbols and exchange

    catch
        continue
    end
end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_stage_build',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end