function [info] = write_home_json(info)

%% Get Field Names
info.ammo.account.fieldnames = fieldnames(info.ammo.account);



% Account info section
info.web.home.json.json_home_account_name = {'account_name';'ammo_info'}; % info.ib_account.accountName
info.web.home.json.json_home_account_available_funds = {'available_funds';6000}; % info.ib_account.AvailableFunds
info.web.home.json.json_home_account_bp = {'buying_power';'8000'}; % info.ib_account.BuyingPower
info.web.home.json.json_home_account_netliq = {'net_liq';'11,000'}; % info.ib_account.accountName
info.web.home.json.json_home_account_stack_risked = {'stack_risked';'.40'}; % info.ib_account.AvailableFunds / info.ib_account.NetLiquidation 
info.web.home.json.json_home_account_pos = {'pos';'.84'}; %see function POS; have to create new var currently
info.web.home.json.json_home_account_open_trades = {'open_trades';'25'}; % length(info.ib_portfolio(:)) CAN TAKE OUT THIS IN THE JS
info.web.home.json.json_home_account_pl = {'current_portfolio_pl';'2000'}; 
info.web.home.json.json_home_account_max_profit = {'portfolio_max_profit';'2500'};
info.web.home.json.json_home_account_max_loss = {'portfolio_loss';'5000'};

% Open Trades section
% Need to build structure that parses this information out
info.web.home.json.json_home_tradeid = {'Trade ID';'tsla22062014';'tsla22062015';'tsla22062016';'tsla22062017';'tsla22062018';'tsla22062019';'tsla22062020';'tsla22062021';'tsla22062022';'tsla22062023';'tsla22062024';'tsla22062025';'tsla22062026';'tsla22062027';'tsla22062028';'tsla22062029';'tsla22062030';'tsla22062031';'tsla22062032';'tsla22062033';'tsla22062034';'tsla22062035';'tsla22062036';'tsla22062037'};
info.web.home.json.json_home_tradepos = {'POS';84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84}; %
info.web.home.json.json_home_dte = {'DTE';1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;25}; %info.ib_portfolio.expiry(:)
info.web.home.json.json_home_current_pl = {'Current P/L';100;150;111;-50;-60;-75;25;32;45;46;47;29;17;16;-50;-49;-48;-200;100;11;111;123;154;164};
info.web.home.json.json_home_max_profit = {'Max_Profit';200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200};
info.web.home.json.json_home_max_loss = {'Max_Loss';-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300};

%Convert structure into a cell array for printing purposes
% info = {info.json.home.json_home_account_name info.json.home.json_home_account_available_funds info.json.home.json_home_account_bp info.json.home.json_home_account_netliq info.json.home.json_home_account_stack_risked info.json.home.json_home_account_pos info.json.home.json_home_account_open_trades info.json.home.json_home_account_pl info.json.home.json_home_account_max_profit info.json.home.json_home_account_max_loss info.json.home.json_home_tradeid info.json.home.json_home_tradepos info.json.home.json_home_dte info.json.home.json_home_current_pl info.json.home.json_home_max_profit info.json.home.json_home_max_loss};
% file_home_json = 'C:/inetpub/ammoroot/json/home.json';
% info.json.json_encode.json_encode_home = savejson('',var,file_home_json);

end





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