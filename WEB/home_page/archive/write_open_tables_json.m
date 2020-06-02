function [] = write_open_tables_json()


%have to reformat this entire function and comment out.
%Clean up!

%Create a function that calculates info


% Make this a function
%here you can either save the values as number or strings, with strings you
%can format how you like
% Possible solution to below problem %a = {'account';int2str(6000)}
test.name = {'account_name';'ammo_test'};
test.funds = {'availalbe_funds';6000};
test.bp = {'buying_power';'8000'};
test.netliq = {'net_liq';'11,000'};
test.stack = {'stack_risked';'.40'};
test.pos = {'pos';'.84'};
test.open_trades = {'open_trades';'25'};
test.pl = {'current_pl';'2000'};
test.max = {'max_profit';'2500'};
test.loss = {'max_loss';'5000'};

test.tradeid = {'Trade ID';'tsla22062014';'tsla22062015';'tsla22062016';'tsla22062017';'tsla22062018';'tsla22062019';'tsla22062020';'tsla22062021';'tsla22062022';'tsla22062023';'tsla22062024';'tsla22062025';'tsla22062026';'tsla22062027';'tsla22062028';'tsla22062029';'tsla22062030';'tsla22062031';'tsla22062032';'tsla22062033';'tsla22062034';'tsla22062035';'tsla22062036';'tsla22062037'};
test.tradepos = {'POS';84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84};
test.dte = {'DTE';1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;25};
test.current_pl = {'Current P/L';100;150;111;-50;-60;-75;25;32;45;46;47;29;17;16;-50;-49;-48;-200;100;11;111;123;154;164};
test.max_profit = {'Max_Profit';200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200};
test.max_loss = {'Max_Loss';-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300};

%Convert structure into a cell array for printing purposes
test = {test.name test.funds test.bp test.netliq test.stack test.pos test.open_trades test.pl test.max test.loss test.tradeid test.tradepos test.dte test.current_pl test.max_profit test.max_loss};
file_home_json = 'C:/inetpub/ammoroot/json/home.json';
json = savejson('',test,file_home_json);

end
