function [info] = ammo_portfolio_assesment(info)
try
%% Portfolio Setup
    option_array = cell2mat(transpose({info.ammo.opentrades(:).secType})); % security type array
    secType_index = strcmp(option_array,'OPT'); % find only OPT type securities
    portfolio = info.ammo.opentrades(secType_index); % soft store options trades into portfolio

%% Build Arrays
symbol_array = transpose({portfolio(:).symbol}); % symbol array
localsymbol_array = transpose({portfolio(:).localSymbol}); % localsymbol array
exchange_array = transpose({portfolio(:).exchange}); % exchange array
secType_array = transpose({portfolio(:).secType}); % secType array
currency_array = transpose({portfolio(:).currency}); % currency array

right_array = (transpose({portfolio(:).right})); % right array
expiry_array = (transpose({portfolio(:).expiry})); % expiry array
strike_array = cell2mat(transpose({portfolio(:).strike})); % strike array

position_array = cell2mat(transpose({portfolio(:).position})); % position array
marketValue_array = cell2mat(transpose({portfolio(:).marketValue})); % marketValue array
marketPrice_array = cell2mat(transpose({portfolio(:).marketPrice})); % marketPrice array
averageCost_array = cell2mat(transpose({portfolio(:).averageCost})); % averageCost array
pl_array = cell2mat(transpose({portfolio(:).pl})); % pl array

dte_array = cell2mat(transpose({portfolio(:).dte})); % dte array
days_held_array = cell2mat(transpose({portfolio(:).days_held})); % days_held array


optPrice_array = cell2mat(transpose({portfolio(:).optPrice})); % optPrice array
impliedVol_array = cell2mat(transpose({portfolio(:).impliedVol})); % impliedVol array

delta_array = cell2mat(transpose({portfolio(:).delta})); % delta array
gamma_array = cell2mat(transpose({portfolio(:).gamma})); % gamma array
theta_array = cell2mat(transpose({portfolio(:).theta})); % theta array
vega_array = cell2mat(transpose({portfolio(:).vega})); % vega array


%% Group

% parse out for dte structs first; convert those structs into seperate
% cell arrays struct2cell, then run below for each one
a = struct2cell(data_portfolio);
unique_symbol = unique(transpose({portfolio(:).symbol}));
dte_array = cell2mat(transpose({portfolio(:).dte})); % expiry array



 symbol.(str{1}) = data_portfolio;
 a=transpose({symbol.(str{1}).symbol});
 
 
 
for i = 1:size(unique_array)
try
    symbol(i).long_puts = (strcmp(a(1,:,:),unique_symbol(i))) & (ge(cell2mat(a(9,:,:)),1)) & (strcmp(a(6,:,:),'P')); % symbol (string), position (num), right (string)
    symbol(i).long_calls = (strcmp(a(1,:,:),unique_symbol(i))) & (ge(cell2mat(a(9,:,:)),1)) & (strcmp(a(6,:,:),'C')); % symbol (string), position (num), right (string)
    symbol(i).short_puts = (strcmp(a(1,:,:),unique_symbol(i))) & (le(cell2mat(a(9,:,:)),-1)) & (strcmp(a(6,:,:),'P')); % symbol (string), position (num), right (string)
    symbol(i).long_calls = (strcmp(a(1,:,:),unique_symbol(i))) & (le(cell2mat(a(9,:,:)),-1)) & (strcmp(a(6,:,:),'P')); % symbol (string), position (num), right (string)
catch ME
end
end

for j = 1:size(unique_sright_array,1)
            try



            catch ME
            end
        end

    catch ME
    end
end


 a=[b{6,:,:}]=='P';
data_portfolio(a);


%% Calculate Account P/L
info.ammo.portfolio.portfolio_pl = sum(cell2mat(transpose({portfolio(:).pl}))); % calculate account pl and store in ammo; sum of all opentrades pl

    
catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_portfolio_assessment',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end