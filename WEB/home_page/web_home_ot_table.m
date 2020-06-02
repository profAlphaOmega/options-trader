function [info] = web_home_ot_table(info)
%% Create Open Trades Table for JSON Parsing
%% Intitalize Structure
% fields MUST match the output of ammo_portfolio_trades
ot_table.comp_name = [];
ot_table.comp_dte = [];
ot_table.current_ul = [];
ot_table.comp_long_strike = [];
ot_table.comp_premium_paid = [];
ot_table.comp_short_strike = [];
ot_table.comp_credit_received = [];
ot_table.comp_ncr = [];
ot_table.comp_breakeven = [];
ot_table.comp_maxprofit = [];
ot_table.comp_maxloss = [];
ot_table.comp_pl = [];
ot_table.comp_pop = [];
ot_table.comp_ror = [];

%% Loop Through Symbol Index
for i = 1:size(info.ammo.portfolio.symbol_index,1)
    try
       %% Puts
        if ~isempty(info.ammo.portfolio.trades.(info.ammo.portfolio.symbol_index{i}).([info.ammo.portfolio.symbol_index{i} '_puts_udva'])) % empty value test
            
            for j = 1:size(info.ammo.portfolio.trades.(info.ammo.portfolio.symbol_index{i}).([info.ammo.portfolio.symbol_index{i} '_puts_udva']),1) % loop through dte array
                try
                    ot_table(end+1) = info.ammo.portfolio.trades.(info.ammo.portfolio.symbol_index{i}).([info.ammo.portfolio.symbol_index{i} '_puts_' num2str(info.ammo.portfolio.trades.(info.ammo.portfolio.symbol_index{i}).([info.ammo.portfolio.symbol_index{i} '_puts_udva'])(j)) '_weighted']); % find all the weighted put positions
                catch ME 
                end
            end
        end
        
        %% Calls
        if ~isempty(info.ammo.portfolio.trades.(info.ammo.portfolio.symbol_index{i}).([info.ammo.portfolio.symbol_index{i} '_calls_udva'])) % empty value test
            
            for j = 1:size(info.ammo.portfolio.trades.(info.ammo.portfolio.symbol_index{i}).([info.ammo.portfolio.symbol_index{i} '_calls_udva']),1) % loop through dte array
                try
                    ot_table(end+1) = info.ammo.portfolio.trades.(info.ammo.portfolio.symbol_index{i}).([info.ammo.portfolio.symbol_index{i} '_calls_' num2str(info.ammo.portfolio.trades.(info.ammo.portfolio.symbol_index{i}).([info.ammo.portfolio.symbol_index{i} '_calls_udva'])(j)) '_weighted']); % find all the weighted call positions
                catch ME
                    
                end
            end
        end
        
    catch
        continue
    end
end

ot_table(1) = []; % delete initialized row

%% Store AMMO
info.web.home.json.ot_table = ot_table;

end
