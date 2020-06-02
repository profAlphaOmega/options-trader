function [info] = write_tradeopp_json(info)


%have to reformat this entire function and comment out.
%Clean up!

%Create a function that calculates info


% Possible new structure based on tradeid iteration
% info.web_tradeopp.[tradeid[i]].json.json_tradeopp_date_ul


% Make this a function
%here you can either save the values as number or strings, with strings you
%can format how you like
% Possible solution to below problem %a = {'account';int2str(6000)}
info.web_tradeopp.json_tradeopp.json_tradeopp_date_ul = {'date_ul';'07/07/2014';'07/07/2014';'07/07/2014';'07/07/2014';'07/07/2014';'07/07/2014';'07/07/2014';'07/07/2014';'07/07/2014';'07/07/2014';'07/27/2014';'07/17/2014';};
info.web_tradeopp.json_tradeopp.json_tradeopp_price_ul = {'price_ul';40;50;60;70;45;50;27;94;86;23;44;51};
info.web_tradeopp.json_tradeopp.json_tradeopp_strike = {'strike';40;41;42;43;44;45};
info.web_tradeopp.json_tradeopp.json_tradeopp_pl = {'pl';-300;-200;-100;0;100;200};
info.web_tradeopp.json_tradeopp.json_tradeopp_dte = {'dte';45};
info.web_tradeopp.json_tradeopp.json_tradeopp_current_ul = {'current_ul';42.5};
info.web_tradeopp.json_tradeopp.json_tradeopp_breakeven = {'breakeven';43};
info.web_tradeopp.json_tradeopp.json_tradeopp_pos = {'pos';84};
info.web_tradeopp.json_tradeopp.json_tradeopp_delta = {'delta';82};
info.web_tradeopp.json_tradeopp.json_tradeopp_iv_rank = {'iv_rank';.53};
info.web_tradeopp.json_tradeopp.json_tradeopp_percent_b = {'percent_b';87};
info.web_tradeopp.json_tradeopp.json_tradeopp_stoch_value = {'stoch_value';73};
info.web_tradeopp.json_tradeopp.json_tradeopp_aroon_value = {'aroon_value';83};
info.web_tradeopp.json_tradeopp.json_tradeopp_kelly = {'kelly';.06};
info.web_tradeopp.json_tradeopp.json_tradeopp_amount_risked = {'amount_risked';84};
info.web_tradeopp.json_tradeopp.json_tradeopp_current_pl = {'current_pl';-50};
info.web_tradeopp.json_tradeopp.json_tradeopp_max_profit = {'max_profit';200};
info.web_tradeopp.json_tradeopp.json_tradeopp_max_loss = {'max_loss';-300};
info.web_tradeopp.json_tradeopp.json_tradeopp_short_strike = {'short_strike';45};
info.web_tradeopp.json_tradeopp.json_tradeopp_short_price = {'short_price';300};
info.web_tradeopp.json_tradeopp.json_tradeopp_long_strike = {'long_strike';40};
info.web_tradeopp.json_tradeopp.json_tradeopp_long_price = {'long_price';-100};


%Convert structure into a cell array for printing purposes
% test = {test.json.tradeopp.json_tradeopp_date_ul test.json.tradeopp.json_tradeopp_price_ul test.json.tradeopp.json_tradeopp_strike test.json.tradeopp.json_tradeopp_pl test.json.tradeopp.json_tradeopp_dte test.json.tradeopp.json_tradeopp_current_ul test.json.tradeopp.json_tradeopp_breakeven test.json.tradeopp.json_tradeopp_pos test.json.tradeopp.json_tradeopp_delta test.json.tradeopp.json_tradeopp_iv_rank test.json.tradeopp.json_tradeopp_percent_b test.json.tradeopp.json_tradeopp_stoch_value test.json.tradeopp.json_tradeopp_aroon_value test.json.tradeopp.json_tradeopp_kelly test.json.tradeopp.json_tradeopp_amount_risked test.json.tradeopp.json_tradeopp_current_pl test.json.tradeopp.json_tradeopp_max_profit test.json.tradeopp.json_tradeopp_max_loss test.json.tradeopp.json_tradeopp_short_strike test.json.tradeopp.json_tradeopp_short_price test.json.tradeopp.json_tradeopp_long_strike test.json.tradeopp.json_tradeopp_long_price};
% file_tradeopp_json = 'C:/inetpub/ammoroot/json/tradeopp.json';
% test.json.json_encode.json_encode_tradeopp = savejson('',test,file_tradeopp_json);

end
