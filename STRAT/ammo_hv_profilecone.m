function [info] = ammo_hv_profilecone(info,historical_volatility_annual,p)
try
%% Hard Code Params
hv_lookback_period = info.params.strat_params.hv_lookback_period;

%% Store Annual and Current IV
profile.historical_volatility_annual =  historical_volatility_annual; % store historical volatility
current_hv = historical_volatility_annual(1); % first element is the current
info.ammo.stage(p).historical_volatility.current_hv = current_hv; % store current

%% HV percentile
hv_pvector = historical_volatility_annual(1:hv_lookback_period); % define data set with lookback
hv_pvector = sort(hv_pvector); % sort in ascending
[r,c] = find(hv_pvector == current_hv); % find the row index of the current_iv
hv_percentile = r/size(hv_pvector,1); % divide that row index by the total size of the data set

info.ammo.stage(p).historical_volatility.hv_percentile = hv_percentile; % store in ammo

%% HV Rank
hv_rvector = historical_volatility_annual(1:hv_lookback_period); % define data set with lookback
hv_min = min(hv_rvector); % find the minimum
hv_max = max(hv_rvector); % find the maximum
hv_rank = (current_hv - hv_min) / (hv_max - hv_min); % where does the current iv fall within the high/low range

info.ammo.stage(p).historical_volatility.hv_rank = hv_rank; % store in ammo
info.ammo.stage(p).historical_volatility.hv_min = hv_min; % store min in ammo
info.ammo.stage(p).historical_volatility.hv_max = hv_max; % store max in ammo
 

%% Mean and Stdev of HV
% This is a quick and custom version of below
hv_statvector = historical_volatility_annual(1:hv_lookback_period); % define data set with lookback

hv_average = mean(hv_statvector); % find the average over lookback period
hv_stdev = std(hv_statvector); % find the standard deviation
hv_stdev_high = hv_average + hv_stdev; % high hv vol
hv_stdev_low = hv_average - hv_stdev; % low hv vol
hv_pctv = (current_hv - hv_stdev_low) / (hv_stdev_high - hv_stdev_low); % relative positions from one stdev


info.ammo.stage(p).historical_volatility.hv_lookback_period = hv_lookback_period; % store lookback in ammo
info.ammo.stage(p).historical_volatility.hv_stdev = hv_stdev; % store stdev in ammo
info.ammo.stage(p).historical_volatility.hv_stdev_high = hv_stdev_high; % store high in ammo
info.ammo.stage(p).historical_volatility.hv_stdev_low = hv_stdev_low; % store low in ammo
info.ammo.stage(p).historical_volatility.hv_pctv = hv_pctv; % store low in ammo

%% Calculate Daily Historical Volatility
 daily_hv_vol = historical_volatility_annual ./ sqrt(252); %Back out daily historical volatility; assumption on trading days may need to be changed

%% Store Daily Historical Volatility
profile.daily_hv_vol = daily_hv_vol;
info.ammo.stage(p).historical_volatility.daily_hv_vol = daily_hv_vol;

%% Convert Volatility into N days terms

    profile.historical_volatility_180 = daily_hv_vol * sqrt(180); 
    profile.historical_volatility_90 = daily_hv_vol * sqrt(90);
    profile.historical_volatility_80 = daily_hv_vol * sqrt(80);
    profile.historical_volatility_70 = daily_hv_vol * sqrt(70);
    profile.historical_volatility_60 = daily_hv_vol * sqrt(60);
    profile.historical_volatility_56 = daily_hv_vol * sqrt(56);
    profile.historical_volatility_45 = daily_hv_vol * sqrt(45);
    profile.historical_volatility_35 = daily_hv_vol * sqrt(35);
    profile.historical_volatility_30 = daily_hv_vol * sqrt(30);
    profile.historical_volatility_20 = daily_hv_vol * sqrt(20);
    profile.historical_volatility_14 = daily_hv_vol * sqrt(14);
    profile.historical_volatility_10 = daily_hv_vol * sqrt(10); %2 weeks
    profile.historical_volatility_8 = daily_hv_vol * sqrt(8);
    profile.historical_volatility_5 = daily_hv_vol * sqrt(5); %1 week


%% Average Volatility per Lookback period

i=0;
for i = 1:size(historical_volatility_annual,1)
    try
        cone.historical_volatility_annual_1(i,1) = mean(historical_volatility_annual(i:i));
        cone.historical_volatility_annual_2(i,1) = mean(historical_volatility_annual(i:1+i));
        cone.historical_volatility_annual_3(i,1) = mean(historical_volatility_annual(i:2+i));
        cone.historical_volatility_annual_5(i,1) = mean(historical_volatility_annual(i:4+i));
        cone.historical_volatility_annual_10(i,1) = mean(historical_volatility_annual(i:9+i));
        cone.historical_volatility_annual_20(i,1) = mean(historical_volatility_annual(i:19+i));%4 weeks
        cone.historical_volatility_annual_30(i,1) = mean(historical_volatility_annual(i:29+i));%6 weeks
        cone.historical_volatility_annual_40(i,1) = mean(historical_volatility_annual(i:39+i));%8 weeks
        cone.historical_volatility_annual_50(i,1) = mean(historical_volatility_annual(i:49+i));%10 weeks
        cone.historical_volatility_annual_100(i,1) = mean(historical_volatility_annual(i:99+i));%20 weeks
        cone.historical_volatility_annual_130(i,1) = mean(historical_volatility_annual(i:129+i));%26 weeks
        cone.historical_volatility_annual_190(i,1) = mean(historical_volatility_annual(i:189+i));%38 weeks
        cone.historical_volatility_annual_250(i,1) = mean(historical_volatility_annual(i:249+i));%50 weeks
    catch
        continue
    end
end

%% Build Cone

% Initialize
avgmean = [];
high = [];
low = [];


    avgmean(1,1) = mean(cone.historical_volatility_annual_1);
    high(1,1) = avgmean(1,1) + std(cone.historical_volatility_annual_1);
    low(1,1) = avgmean(1,1) - std(cone.historical_volatility_annual_1);

    avgmean(2,1) = mean(cone.historical_volatility_annual_2);
    high(2,1) = avgmean(2,1) + std(cone.historical_volatility_annual_2);
    low(2,1) = avgmean(2,1) - std(cone.historical_volatility_annual_2);

    avgmean(3,1) = mean(cone.historical_volatility_annual_3);
    high(3,1) = avgmean(3,1) + std(cone.historical_volatility_annual_3);
    low(3,1) = avgmean(3,1) - std(cone.historical_volatility_annual_3);

    avgmean(4,1) = mean(cone.historical_volatility_annual_5);
    high(4,1) = avgmean(4,1) + std(cone.historical_volatility_annual_5);
    low(4,1) = avgmean(4,1) - std(cone.historical_volatility_annual_5);

    avgmean(5,1) = mean(cone.historical_volatility_annual_10);
    high(5,1) = avgmean(5,1) + std(cone.historical_volatility_annual_10);
    low(5,1) = avgmean(5,1) - std(cone.historical_volatility_annual_10);

    avgmean(6,1) = mean(cone.historical_volatility_annual_20);
    high(6,1) = avgmean(6,1) + std(cone.historical_volatility_annual_20);
    low(6,1) = avgmean(6,1) - std(cone.historical_volatility_annual_20);

    avgmean(7,1) = mean(cone.historical_volatility_annual_30);
    high(7,1) = avgmean(7,1) + std(cone.historical_volatility_annual_30);
    low(7,1) = avgmean(7,1) - std(cone.historical_volatility_annual_30);

    avgmean(8,1) = mean(cone.historical_volatility_annual_40);
    high(8,1) = avgmean(8,1) + std(cone.historical_volatility_annual_40);
    low(8,1) = avgmean(8,1) - std(cone.historical_volatility_annual_40);

    avgmean(9,1) = mean(cone.historical_volatility_annual_50);
    high(9,1) = avgmean(9,1) + std(cone.historical_volatility_annual_50);
    low(9,1) = avgmean(9,1) - std(cone.historical_volatility_annual_50);

    avgmean(10,1) = mean(cone.historical_volatility_annual_100);
    high(10,1) = avgmean(10,1) + std(cone.historical_volatility_annual_100);
    low(10,1) = avgmean(10,1) - std(cone.historical_volatility_annual_100);

    avgmean(11,1) = mean(cone.historical_volatility_annual_130);
    high(11,1) = avgmean(11,1) + std(cone.historical_volatility_annual_130);
    low(11,1) = avgmean(11,1) - std(cone.historical_volatility_annual_130);

    avgmean(12,1) = mean(cone.historical_volatility_annual_190);
    high(12,1) = avgmean(12,1) + std(cone.historical_volatility_annual_190);
    low(12,1) = avgmean(12,1) - std(cone.historical_volatility_annual_190);

    avgmean(13,1) = mean(cone.historical_volatility_annual_250);
    high(13,1) = avgmean(13,1) + std(cone.historical_volatility_annual_250);
    low(13,1) = avgmean(13,1) - std(cone.historical_volatility_annual_250);


%% Volatility cone
cone.historical_vol_cone = 100 * [low avgmean high];

%% Store variable into ammo structure
info.ammo.stage(p).historical_volatility.profile = profile;
info.ammo.stage(p).historical_volatility.cone = cone;

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_hv_profilecone',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

%% NOTES
% DOUBLE CHECK Calculations
% Checked against excel file, it is accurate.

% To get a real time historical vol cone you need to put in a for loop to
% iterate through each price vector and you will be able to do this for
% each snapshot. The formula will be more complicated than this. Might be
% easier to start at one year back, have another year for lag, then run all
% the way up to present capturing each days new X-day hv. That way you will
% be able to capture % difference between those


% Daily Volatility 1 Standard deviation based on 1 years worth of data
%       The high/low range that occurs 68.2% of the time

% Redundant storage of historical_volatility_annual; easier to pick out and
% is stored in .profile.

%X-axis needs to be changed when adding more days(weeks) to expirations
% x_axis = [1;2;3;5;10;20;30;40;50;100;130;190;250];
% plot(x_axis,historical_vol_cone);
% Works!

%This is the variable formula
% close = [536.86;537.46;539.78;544.99;539.19;532.87;528.7;531.26;526.74];
% historical_volatility = std(log(close(2:end)./close(1:end-1))*100) * sqrt(hv_lookback);

% From there we have to build the vol cone.
% Store the avg, stdev high, and stdev low matrix least DTE to greatest
% DEFINE: how much volatility narrows or reverts to its mean the further out from
%   expiration you go.
%Have to think about capping this range
%%%%%%%% avgmean(1,1) = mean(historical_volatility_annual_1(1:1000));


