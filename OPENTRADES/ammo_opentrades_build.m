function [info] = ammo_opentrades_build(info)
try
%% Run

i=0;
    for i = 1:size(info.ammo.opentrades,2)% find how many open trades there are; go off of 2nd dimension for a structure
        try   
if(strcmp(info.ammo.opentrades(i).secType,'OPT')) % only if it is an option
%% Store Stage Information

    row = []; % initialize row var
    [row] = find(strcmp({info.ammo.stage.symbol},info.ammo.opentrades(i).symbol)); % find what row the opentrades symbol is located in stage
    info.ammo.opentrades(i).stage = info.ammo.stage(row); % store stage

    %% Current UL
    info.ammo.opentrades(i).current_ul = info.ammo.opentrades(i).stage.current_ul.bidPrice;
    
    %% Pull current Option details
     [info] = ib_qry_opentrades_current_option(info,i);

    %% DTE
    info.ammo.opentrades(i).dte = datenum(info.ammo.opentrades(i).expiry,'yyyymmdd') - datenum(date); % subtract expiration from todays date 

    %% Current P/L

    if (le(info.ammo.opentrades(i).position,-1))
        info.ammo.opentrades(i).pl = (info.ammo.opentrades(i).averageCost * abs(info.ammo.opentrades(i).position)) + info.ammo.opentrades(i).marketValue; % for short positions; cost of the trade plus the marketValue in negative terms   
    elseif (ge(info.ammo.opentrades(i).position,1))
        info.ammo.opentrades(i).pl = info.ammo.opentrades(i).marketValue - (info.ammo.opentrades(i).averageCost * abs(info.ammo.opentrades(i).position)); % for long positions; marketValue - averageCost
    else info.ammo.opentrades(i).pl = -.2828;
    end

    %% Percentage of Max
    info.ammo.opentrades(i).pomax = (info.ammo.opentrades(i).pl/(info.ammo.opentrades(i).averageCost * abs(info.ammo.opentrades(i).position))); % for short positions; value between -inf and 1; if positive, % of max profit; if negative, % of cost;; % for short positions; value between -1 and inf; if positive, % of cost; if negative, % of max loss
   
%     %% Average Cost
%     info.ammo.opentrades(i).averageCost = sprintf('%.2f',info.ammo.opentrades(i).averageCost); % reformatting purposes
%     
    %% Market Value
    info.ammo.opentrades(i).marketValue = sprintf('%.2f',info.ammo.opentrades(i).marketValue); % reformatting purposes
    
end % if statement end
        catch 
            continue
        end
    end % for loop statement end
    
    
    
   
catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_opentrades_build',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

% 
%     %% Days Held
%     % load in opentrades.mat table
% 
%     opentrade_conId = info.ammo.opentrades(i).conId; % soft code contract ID
% 
%     index = opentrade_conId == cell2mat(transpose({info.ammo.trades(:).conId})); % find contract ID in trades mat file; logical array
% 
%     info.ammo.opentrades(i).date_placed = info.ammo.trades(index).date_placed; % grab the date placed serial value
% 
%     info.ammo.opentrades(i).days_held = datenum(date) - info.ammo.opentrades(i).date_placed; % Determine days held
%    datenum(date_string,'yyyymmdd')

%% Structure of current Market Query

% reqId: 22209874
% reqTime: '02-Dec-2010 00:47:23'
% dataTime: '02-Dec-2010 00:47:24'
% dataTimestamp: 734474.032914491
% ticker: 'GOOG'
% bidPrice: 563.68
% askPrice: 564.47
% open: 562.82
% close: 555.71
% low: 562.4
% high: 571.57
% lastPrice: -1
% volume: 36891
% tick: 0.01
% bidSize: 3
% askSize: 3
% lastSize: 0
% contract: [1x1 struct]
% contractDetails: [1x1 struct]


%% Structure of open_trades query
% >> data(2)
% ans =
% orderId: 154410311
% contract: [1x1 struct]
% order: [1x1 struct]
% orderState: [1x1 struct]
% status: 'PreSubmitted'
% filled: 0
% remaining: 100
% avgFillPrice: 0
% permId: 989560928
% parentId: 154410310
% lastFillPrice: 0
% clientId: 8981
% whyHeld: 'child,trigger'
% message: [1x182 char]

% data(2).contract
% ans =
% m_conId: 30351181
% m_symbol: 'GOOG'
% m_secType: 'STK'
% m_expiry: []
% m_strike: 0
% m_right: '?'
% m_multiplier: []
% m_exchange: 'SMART'
% m_currency: 'USD'
% m_localSymbol: 'GOOG'
% m_primaryExch: []
% m_includeExpired: 0
% m_secIdType: []
% m_secId: []
% m_comboLegsDescrip: []
% m_comboLegs: '[]'
% m_underComp: []

% >> data(1).order
% ans =
% CUSTOMER: 0
% FIRM: 1
% OPT_UNKNOWN: '?'
% OPT_BROKER_DEALER: 'b'
% OPT_CUSTOMER: 'c'
% OPT_FIRM: 'f'
% OPT_ISEMM: 'm'
% OPT_FARMM: 'n'
% OPT_SPECIALIST: 'y'
% AUCTION_MATCH: 1
% AUCTION_IMPROVEMENT: 2
% AUCTION_TRANSPARENT: 3
% EMPTY_STR: ''
% m_orderId: 154410311
% m_clientId: 8981
% m_permId: 989560928
% m_action: 'SELL'
% m_totalQuantity: 100
% m_orderType: 'STP'
% m_lmtPrice: 580
% m_auxPrice: 0
% m_tif: 'GTC'
% m_ocaGroup: '989560927'
% m_ocaType: 3
% m_transmit: 1
% m_parentId: 154410310



% data.contractDetails
% ans =
% m_summary: [1x1 com.ib.client.Contract]
% m_marketName: 'LO'
% m_tradingClass: 'LO'
% m_minTick: 0.01
% m_priceMagnifier: 1
% m_orderTypes: [1x205 char]
% m_validExchanges: 'NYMEX'
% m_underConId: 43635367
% m_longName: 'Light Sweet Crude Oil'
% m_contractMonth: '201306'
% m_industry: []
% m_category: []
% m_subcategory: []
% m_timeZoneId: 'EST'
% m_tradingHours: '20130430:1800-1715;20130501:1800-1715'
% m_liquidHours: '20130430:0000-1715,1800-2359;20130501:0000-
% 1715,1800-2359'
