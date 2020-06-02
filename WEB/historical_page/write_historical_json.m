function [info] = write_historical_json(info)


%have to reformat this entire function and comment out.
%Clean up!

%Create a function that calculates info


% Make this a function
%here you can either save the values as number or strings, with strings you
%can format how you like
% Possible solution to below problem %a = {'account';int2str(6000)}

% This should be stored in a .mat file that gets appened to everytime a
% trade is closed. Need to create a callback function that does this
info.web_historical.json_historical.json_historical_tradeid = {'Trade ID';'tsla22062014';'tsla22062015';'tsla22062016';'tsla22062017';'tsla22062018';'tsla22062019';'tsla22062020';'tsla22062021';'tsla22062022';'tsla22062023';'tsla22062024';'tsla22062025';'tsla22062026';'tsla22062027';'tsla22062028';'tsla22062029';'tsla22062030';'tsla22062031';'tsla22062032';'tsla22062033';'tsla22062034';'tsla22062035';'tsla22062036';'tsla22062037'};
info.web_historical.json_historical.json_historical_ticker = {'Ticker';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla'};
info.web_historical.json_historical.json_historical_date_closed = {'date_closed';'06/22/2014';'06/23/2014';'06/24/2014';'06/25/2014';'06/26/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/12/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/22/2014';'06/12/2014';'06/22/2014';'06/22/2014';'06/05/2014'};
info.web_historical.json_historical.json_historical_pl = {'P/L';100;150;111;-50;-60;-75;25;32;45;46;47;29;17;16;-50;-49;-48;-200;100;11;111;123;154;164};
%these have to be named differently than the other variables used in
%open_trades
info.web_historical.json_historical.json_historical_max_profit = {'Max_Profit';200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200};
info.web_historical.json_historical.json_historical_max_loss = {'Max_Loss';-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300};

%Convert structure into a cell array for printing purposes
% info = {info.json.historical.json_historical_tradeid  info.json.historical.json_historical_ticker info.json.historical.json_historical_date_closed info.json.historical.json_historical_pl info.json.historical.json_historical_max_profit info.json.historical.json_historical_max_loss};
% file_historical_json = 'C:/inetpub/ammoroot/json/historical.json';
% info.json.json_encode.json_encode_historical = savejson('',var,file_historical_json);

end
