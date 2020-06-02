function IBCallbackFullChain(ibConnectionObject, eventData)
% IBCallbackContractDetails
% global chain


contract = eventData.contractDetails.m_summary;

localsymbol = char(contract.m_localSymbol);
secType = char(contract.m_secType);
symbol = char(contract.m_symbol);
expiry = char(contract.m_expiry);
right = char(contract.m_right);
multiplier = char(contract.m_multiplier);
strike = num2str(contract.m_strike);

%% Create File name
filename = ['C:\Users\Zato\Desktop\Master\AMMO\TRADEOPPS\options_chain\chain_' expiry '_' symbol '_' date '.csv'];  

%% Store data into string
csvline = sprintf('%s,%s,%s,%s,%s,%s,%s\n', localsymbol, secType, symbol, expiry, right, multiplier, strike); % file 

%% Append this comma-separated string to the CSV file
fid = fopen(filename, 'at'); % 'at' = append text
fprintf(fid, csvline);
fclose(fid);



end

% cellstr()
% 
% contract = eventData.contractDetails.m_summary;
% fprintf([char(contract.m_localSymbol) '\t' ...
% char(contract.m_secType) '\t' ...
% char(contract.m_symbol) '\t' ...
% char(contract.m_expiry) '\t' ...
% char(contract.m_right) '\t' ...
% char(contract.m_multiplier) '\t' ...
% num2str(contract.m_strike) '\n']);