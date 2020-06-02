function[info] = historical_page(info)

% [info] = write_historical_trades_csv(info);
% [info] = write_grabhistorical_trades_php(info);
[info] = write_historical_trades_json(info);
[info] = write_historical_trades_js(info);
[info] = write_historical_trades_php(info);

end