function [info] = ammo_tradeopps_expiration(info,i)
try
%% AMMO EXPIRATION

% Given the number of days you want you set for DTE, this function finds
% the closest thursday in the future month. The limitaion on added days is
% 2 months due to standard option expiration cycles. There will always be 2
% months for any given underlying, but expiration months greater than 2 months vary by
% underlying. This function also calculates the actual DTE after it finds
% the correct thrusday.

%% Run
% negative number to subtract
add_days = info.params.strat_params.dte; % set the number of days you want to add

%% Determine Current and Future Dates
current_date = datenum(datestr(clock)); % convert current date/time to num
future_date = addtodate(current_date,add_days,'day'); % add days function; returns future_date in num
[y,m,d,h,mn,s] = datevec(future_date); % convert future_date into vector form

%% Load Future Calendar
future_calendar = calendar(y,m); % load calendar for future_date

%% Load Future Thursday Vector
future_calendar_thursday = future_calendar(:,5); % isolate thursdays due to standard expiration day for most symobls
future_calendar_thursday(future_calendar_thursday == 0) = []; % eliminate other month days

%% Compare Future to Actual Thursday
future_calendar_thursday_adjusted = abs(future_calendar_thursday - d); % subtract to find largest differential in absolute terms 

%% Find and Replace Future Date with Actual Date and Store as String for IBMatlab formatting
[value,index] = min(future_calendar_thursday_adjusted); % find the closest differential and its index

actual_day = future_calendar_thursday(index); % use index to identify which actual_day value it is

expiration_num = [y m actual_day]; % store actual date in vector form
expiration_str = num2str(expiration_num); % convert num to str


%% Format for IBMatlab; 'YYYYMMDD'
% test month to see if it has 2 characters; insert when necessary
if m < 10
    expiration_str(9) = '0';
end

% test day to see if it has 2 characters; insert when necessary
if actual_day < 10
    expiration_str(end-1) = '0';
end

expiration_str(isspace(expiration_str)) = []; % remove spaces



%% Calculate Actual DTE
dte = add_days + (actual_day - d); % calculate days to expiration


%% Store in AMMO Structure

info.ammo.tradeopps(i).expiry = expiration_str;
info.ammo.tradeopps(i).dte = dte;

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_tradeopps_expiration',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
