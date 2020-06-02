function [info] = write_tradeopps_json(info)


%have to reformat this entire function and comment out.
%Clean up!

%Create a function that calculates info

% This should be built in a function that appends individual trade opp info
% to it
info.web_tradeopps.json_tradeopps.json_tradeopps_tradeid = {'Trade ID';'tsla22062014';'tsla22062015';'tsla22062016';'tsla22062017';'tsla22062018';'tsla22062019';'tsla22062020';'tsla22062021';'tsla22062022';'tsla22062023';'tsla22062024';'tsla22062025';'tsla22062026';'tsla22062027';'tsla22062028';'tsla22062029';'tsla22062030';'tsla22062031';'tsla22062032';'tsla22062033';'tsla22062034';'tsla22062035';'tsla22062036';'tsla22062037'};
info.web_tradeopps.json_tradeopps.json_tradeopps_ticker = {'Ticker';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla';'tsla'};
info.web_tradeopps.json_tradeopps.json_tradeopps_dte = {'dte';1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;25};
info.web_tradeopps.json_tradeopps.json_tradeopps_pos = {'pos';84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84;84};
info.web_tradeopps.json_tradeopps.json_tradeopps_max_profit = {'Max_Profit';200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200;200};
info.web_tradeopps.json_tradeopps.json_tradeopps_max_loss = {'Max_Loss';-500;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300;-300};


%Convert structure into a cell array for printing purposes
% test = {test.json.tradeopps.json_tradeopps_tradeid test.json.tradeopps.json_tradeopps_ticker test.json.tradeopps.json_tradeopps_dte test.json.tradeopps.json_tradeopps_pos test.json.tradeopps.json_max_profit test.json.tradeopps.json_max_loss};
% file_tradeopps_json = 'C:/inetpub/ammoroot/json/tradeopps.json';
% test.json.json_encode.json_encode_tradeopps = savejson('',test,file_tradeopps_json);

end
