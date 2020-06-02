%MASTER.M
function [] = MASTER()
try
%% Run Setup
info = [];% Initialize info structure
info.run_type = 'normal'; % Create run_type variable
info.start_time_str = datestr(now); % Create run_time variable; %datestr(floor(now)); % date function without clock time
info.start_time_serial = now; % for run saving purposes only
%% Load Params
[info] = ammo_load_params(info); % Load strat params

%% Hard Code Parameters
clientid = info.params.ibconnection.clientid; % clientId
port = info.params.ibconnection.port; % port
%% ACCOUNT
[info] = ACCOUNT(info);
   
%% STAGE
[info] = STAGE(info);
    
%% STRAT
[info] = STRAT(info);  

%% TRADEOPPS
% [info] = TRADEOPPS(info);
  
%% EXECUTIONS
[info] = EXECUTIONS(info);

%% OPEN TRADES
if ~isempty(IBMatlab('action','portfolio','ClientID',clientid,'Port',port)) % Catch statement when no opentrades held
[info] = OPENTRADES(info);
else 
    info.ammo.opentrades = 0;
end

%% Alerts
[info] = ALERTS(info); 

%% WEB
[info] = WEB(info);

%% Finish Time
info.finish_time_str = datestr(now); % Document finish run time

 %% Save Mat File
[y,m,d,h,mn,s]=datevec(info.start_time_serial);
% if (size(d)~=2)
%     d = ['0' d];
% end
save(['C:\Users\Zato\Desktop\Master\AMMO\~mat\archive\info_' num2str(y) num2str(m) num2str(d) num2str(h) num2str(mn)],'info');

%% Send Completion Email
sendmail('REDACTED', 'RUN_COMPLETE:',['Run Successful:' 10 10 ...
    'Start Time ' info.start_time_str 10 ...
    'End Time ' info.finish_time_str 10 10 ...
    'Go To Site REDACTED' 10 ...
     ]); 
%     'P/L = ' sprintf('%.f',info.ammo.ammo_account.UnrealizedPnL(2).value) 10 10 ...
%     'Account Balance = ' num2str(info.ammo.ammo_account.NetLiquidation.value) 10 ...   
    % 'OpenTrades = ' num2str(size(info.ammo.opentrades,2)) 10 10 ...
    % 'Alerts = DTE (' num2str(info.params.alerts.dte) ') trades: ' num2str(info.alerts.dte.count) 10 10 ...
    % Send out email; 'TradeOpps = ' num2str(size(info.ammo.tradeopps,2)) 10 ...

%% Close and Exit
fclose all; %Close all open file handles
exit

%% Error Handle
catch ME
    sendmail('REDACTED', 'ERROR: MASTER',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

%% Notes


%% Old Functions%%

% %% Save Info Archive .Mat Files
% load('C:\Users\Zato\Desktop\Master\AMMO\~mat\info_stack.mat','info_stack') % load info archive
% info_stack = insertrows(info_stack,info); % Append info into archive
% save('C:\Users\Zato\Desktop\Master\AMMO\~mat\info_stack.mat','info_stack'); % save file down
% save('C:\Users\Zato\Desktop\Master\AMMO\~mat\archive\info_archive.mat','info_stack'); % save file down to archive

%% TRADES
% NEW & CLOSING

% [info] = TRADE(info); % Aggregate trade function

%     [info] = closeout_table(info);% Check to determine if any trades can be closed
% Create vector for ib_qry_placetrade.m function; new and closing
%     [info] = ib_qry_placetrade(info);% Query for trade

% Trade Execution
%Build out inputs
% symbol = info.ammo.symbol; % For instance

% Use to track and build open trades table
%         data = IBMatlab('action','sell','symbol',info.ammo.symbol,'quantity',info.ammo.tradeopps/opentrades.quantity,'query','type','executions','AccountName',info.ammo.account.id);

%% HISTORICAL TRADES
% [info] = HISTORICAL_TABLE(info);
% load C:/Users/Zato/Desktop/Master/AMMO/IB_stage/mat/historical_trades.mat;%Loading historical trades information 
%%% Most of this data should be in the open trades table already


% Use ibMatlab's execution feature to determine if you have made any
% closing trades for the day. If yes then append to Historical trades table



%% Notes
% Time Zone declaration
% The time-zone part is also optional, but we strongly recommend specifying it, to
% prevent ambiguities. Not all of the world�s time zones are accepted, but some of the
% major ones are, and you can always convert a time to one of these time zones. The
% full list of time-zones supported by IB is given below: 61
% Time zone supported by IB Description
% GMT Greenwich Mean Time
% EST Eastern Standard Time
% MST Mountain Standard Time
% PST Pacific Standard Time
% AST Atlantic Standard Time
% JST Japan Standard Time
% AET Australian Standard Time



%% LAND OF LOST FUNCTIONS
% OBSOLETE VIA .MAT FILE PARAMS [info] = parse_params(info); % ALWAYS keep this function before any strat function

% Create "run_start_time" variable
% run_start_time = fix(clock);
% run_start_time = strcat(num2str(run_start_time(1:5)));
% run_start_time(isspace(run_start_time)) = [];

% Create "run_finish_time" variable
% run_finish_time = fix(clock);
% run_finish_time = strcat(num2str(run_finish_time(1:5)));
% run_finish_time(isspace(run_finish_time)) = [];  

