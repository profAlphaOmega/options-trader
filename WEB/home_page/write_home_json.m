function [info] = write_home_json(info)
%% Write JSON to Web
%% Account info section
    account_name = {{info.ammo.ammo_account.accountName}}; % Account Name {'account_name';info.ammo.account.AccountCode}; 
    account_available_funds = ['$' sprintf('%.2f',info.ammo.ammo_account.AvailableFunds.value)]; % Available Funds {'available_funds';info.ammo.account.AvailabileFunds}; % info.ib_account.AvailableFunds
    account_bp = ['$' sprintf('%.2f',info.ammo.ammo_account.BuyingPower.value)]; % Buying Power {'buying_power';info.ammo.account.BuyingPower}; % info.ib_account.BuyingPower
    account_netliq = ['$' sprintf('%.f',info.ammo.ammo_account.NetLiquidation.value)]; % Net Liq {'net_liq';info.ammo.account.NetLiquidation}; % info.ib_account.accountName
    account_stack_risked = {{sprintf('%.3f',100 * (1-(info.ammo.ammo_account.AvailableFunds.value/info.ammo.ammo_account.NetLiquidation.value)))}}; % Stack Risked {'stack_risked';(1-(info.ammo.account.AvailabileFunds/info.ammo.account.NetLiquidation))}; % info.ib_account.AvailableFunds / info.ib_account.NetLiquidation 
    account_pos = {{'UC'}}; %see function POS; have to create new var currently
    account_opentrades = {size(info.ammo.opentrades,2)}; % Open Trades Count {'open_trades';'UC'}; % length(info.ib_portfolio(:)) CAN TAKE OUT THIS IN THE JS
    account_pl = {{sprintf('%.f',info.ammo.ammo_account.UnrealizedPnL(2).value)}}; % Current P/L {'current_portfolio_pl';'UC'}; % sum of all individual trades P/L 
    account_maxprofit = {sprintf('%.2f',sum(transpose([info.ammo.opentrades(le([info.ammo.opentrades(:).position],-1)).averageCost]) .* transpose(abs([info.ammo.opentrades(le([info.ammo.opentrades(:).position],-1)).position]))) - sum(transpose([info.ammo.opentrades(ge([info.ammo.opentrades(:).position],1)).averageCost]) .* transpose(abs([info.ammo.opentrades(ge([info.ammo.opentrades(:).position],1)).position]))))}; % (Average Cost of all short positions * abs(position size)) - (Average Cost of all long positions * abs(position size)) 
    account_max_loss = {{'UC'}}; % sum of all opentrade max losses
    last_updated = {{info.start_time_str}}; % last update time

%% Open Trades section
[info] = web_home_ot_table(info); % build open trades table

    ot_table = info.web.home.json.ot_table; % soft code table
    ot_table = struct2table(ot_table); % convert to table
    ot_table = table2cell(ot_table); % convert to cell array
    ot_table = sortrows(ot_table,2); % sort cell array

  % soft code columns
    tradename = ot_table(:,1);
    dte = ot_table(:,2);
    current_ul = ot_table(:,3);
    comp_long_strike = ot_table(:,4);
    comp_premium_paid = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,5))))};
    comp_short_strike = ot_table(:,6);
    comp_credit_recieved = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,7))))};
    comp_ncr = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,8))))};
    comp_breakeven = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,9))))};
    comp_maxprofit = ot_table(:,10);
    comp_maxloss = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,11))))};
    comp_pl = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,12))))};
    comp_pop = {str2num(sprintf('%.2f ',cell2mat(ot_table(:,13))))};


%% Open Trades Graph
% ot_graph = info.ammo.opentrades(le(transpose([info.ammo.opentrades(:).position]),-1)); % pull all short open trades
    ot_graph = info.ammo.opentrades; % store opentrades in ot_graph
    ot_graph(end+1).localSymbol = 'PORTFOLIO'; % create portfolio symbol
    ot_graph(end).dte = 0; % create portfolio dte
    ot_graph(end).pl = info.ammo.portfolio.pl; % create portfolio pl

    ot_graph_cell = struct2table(ot_graph); % convert to table
    ot_graph = table2cell(ot_graph_cell); % convert to cell array
    ot_graph = sortrows(ot_graph,25); % sort cell array ascending by dte

    ot_localsymbol =  ot_graph(:,2);  %transpose({ot_graph(:).localSymbol});
    ot_dte = ot_graph(:,25); %transpose([ot_graph(:).dte]);
    ot_pl = ot_graph(:,26); %transpose([ot_graph(:).pl]);

%% Convert into a cell array for JSON writing purposes
json_array = {account_name account_available_funds account_bp ...
    account_netliq account_stack_risked account_pos account_opentrades account_pl ... 
    account_maxprofit account_max_loss ...
    tradename dte ...
    comp_long_strike comp_short_strike ... 
    current_ul comp_breakeven  ...
    comp_premium_paid  comp_credit_recieved comp_ncr ...
    comp_maxloss comp_pl comp_pop ...
    ot_localsymbol ot_dte ot_pl last_updated};

%% Write JSON
file_home_json = 'F:/inetpub/ammoroot/json/home.json';
info.web.home.json.home_encoded_array = savejson('',json_array,file_home_json);

end



% tradename = transpose({ot_table(:).comp_name});
% dte = transpose({ot_table(:).comp_dte});
% current_ul = transpose({ot_table(:).current_ul});
% comp_long_strike = transpose({ot_table(:).comp_long_strike});
% comp_premium_paid = transpose({ot_table(:).comp_premium_paid});
% comp_short_strike = transpose({ot_table(:).comp_short_strike});
% comp_credit_recieved = transpose({ot_table(:).comp_credit_recieved});
% comp_ncr = transpose({ot_table(:).comp_ncr});
% comp_breakeven = transpose({ot_table(:).comp_breakeven});
% comp_maxprofit = transpose({ot_table(:).comp_maxprofit});
% comp_maxloss = transpose({ot_table(:).comp_maxloss});
% comp_pl = transpose({ot_table(:).comp_pl});


% Need to build structure that parses this information out
% info.web.home.json.json_home_tradeid = {'Trade ID';'tsla22062014';'tsla22062015';'tsla22062016';'tsla22062017';'tsla22062018';'tsla22062019';'tsla22062020';'tsla22062021';'tsla22062022';'tsla22062023';'tsla22062024';'tsla22062025';'tsla22062026';'tsla22062027';'tsla22062028';'tsla22062029';'tsla22062030';'tsla22062031';'tsla22062032';'tsla22062033';'tsla22062034';'tsla22062035';'tsla22062036';'tsla22062037'};
% info.web.home.json.json_home_tradepos = {'POS';84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84}; %
% info.web.home.json.json_home_dte = {'DTE';1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;25}; %info.ib_portfolio.expiry(:)
% info.web.home.json.json_home_current_pl = {'Current P/L';100;150;111;-50;-60;-75;25;32;45;46;47;29;17;16;-50;-49;-48;-200;100;11;111;123;154;164};
% info.web.home.json.json_home_max_profit = {'Max_Prof    it';200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200};
% info.web.home.json.json_home_max_loss = {'Max_Loss';-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300};




% name = {'account_name';'ammo_test'};
% funds = {'availalbe_funds';'6000'};
% bp = {'buying_power';'8000'};
% netliq = {'net_liq';'11000'};
% stack = {'stack_risked';'.40'};
% pos = {'pos';'.84'};
% open_trades = {'open_trades';'25'};
% pl = {'current_pl';'2000'};
% max = {'max_profit';'2500'};
% loss = {'max_loss';'5000'};
% test = {name funds bp netliq stack pos open_trades pl max loss};
% filename = 'C:/Users/Zato/Desktop/home.json';
% savejson('',test,filename);
% 
% test.name = {'account_name';'ammo_test'};
% test.funds = {'availalbe_funds';'6000'};
% test.bp = {'buying_power';'8000'};
% test.netliq = {'net_liq';'11000'};
% test.stack = {'stack_risked';'.40'};
% test.pos = {'pos';'.84'};
% test.open_trades = {'open_trades';'25'};
% test.pl = {'current_pl';'2000'};
% test.max = {'max_profit';'2500'};
% test.loss = {'max_loss';'5000'};
% % test = {name funds bp netliq stack pos open_trades pl max loss};
% filename = 'C:/Users/Zato/Desktop/home.php';
% json = savejson('',test,filename);