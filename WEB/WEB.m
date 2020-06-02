function [info] = WEB(info)
%% Write Home Page
[info] = home_page(info);
%% Write Open Trades Page
[info] = opentrades_page(info);
%% Write Trade Opp Page
[info] = tradeopps_page(info);
end

