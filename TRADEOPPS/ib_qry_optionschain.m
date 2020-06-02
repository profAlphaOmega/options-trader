function [info] = ib_qry_optionschain(info)
try
%% Hard Code Params
clientid = info.params.ibconnection.clientid;
port = info.params.ibconnection.port;

%% Run
for i = 1:size(info.ammo.tradeopps,2)
    try  
%% Soft Code Variables for IBMatlab Pull
    symbol = info.ammo.tradeopps(i).symbol; % ticker with expiry
    info.ammo.tradeopps(i).expiry = '20141114'; % testing purposes
    expiry = info.ammo.tradeopps(i).expiry; % '201306'
    right = ''; % blank value
    strike = 0.0; % 0.0 value
    
%% Clear Existing Options Chain File
filename = ['C:\Users\Zato\Desktop\Master\AMMO\TRADEOPPS\options_chain\chain_' expiry '_' symbol '_' date '.csv'];
fid = fopen(filename,'w');
fprintf(fid,'localsymbol,secType,symbol,expiry,right,multiplier,strike\n');
fclose(fid);

%% IB Options Chain function
% Null due to it returning data not relevant; data is stored in .csv file
info.ib.tradeopps(i).ib_optionschain_null = IBMatlab('action','query','symbol',symbol,'secType','opt','currency','USD','expiry',expiry,'right',right, 'strike',strike,'ClientID',clientid,'Port',port,'CallbackContractDetails',@IBCallbackFullChain);
   
    catch
        continue
    end
end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ib_qry_optionschain',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
%% Potential Output; must test


% Now we ask IB for the current market data of the contract with empty Right and
% Strike. We can safely ignore the IB warning about ambiguous or missing security
% definition:

% [API.msg2] The contract description specified for CL is ambiguous;
% you must specify the multiplier. {286356018, 200}

% LOM3 P6650 FOP CL 20130516 P 1000 66.5
% LOM3 P8900 FOP CL 20130516 P 1000 89
% LOM3 P11150 FOP CL 20130516 P 1000 111.5
% LOM3 C6400 FOP CL 20130516 C 1000 64
% LOM3 C8650 FOP CL 20130516 C 1000 86.5
% LOM3 C10900 FOP CL 20130516 C 1000 109
% LOM3 C6650 FOP CL 20130516 C 1000 66.5
% LOM3 C8900 FOP CL 20130516 C 1000 89
% ... (
