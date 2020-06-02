function [info] = ammo_iv_profilecone(info,implied_volatility_annual,p)
try
%% Hard Code Params
iv_lookback_period = info.params.strat_params.iv_lookback_period;

%% Store Annual and Current IV
profile.implied_volatility_annual = implied_volatility_annual; % store iv 
current_iv = implied_volatility_annual(1); % first element is the current
info.ammo.stage(p).implied_volatility.current_iv = current_iv; % store current

%% IV percentile
iv_pvector = implied_volatility_annual(1:iv_lookback_period); % define data set with lookback
iv_pvector = sort(iv_pvector); % sort in ascending
[r,c] = find(iv_pvector == current_iv); % find the row index of the current_iv
iv_percentile = r/size(iv_pvector,1); % divide that row index by the total size of the data set

info.ammo.stage(p).implied_volatility.iv_percentile = iv_percentile; % store in ammo

%% IV Rank
iv_rvector = implied_volatility_annual(1:iv_lookback_period); % define data set with lookback
iv_min = min(iv_rvector); % find the minimum
iv_max = max(iv_rvector); % find the maximum
iv_rank = (current_iv - iv_min) / (iv_max - iv_min); % where does the current iv fall within the high/low range

info.ammo.stage(p).implied_volatility.iv_rank = iv_rank; % store rank in ammo
info.ammo.stage(p).implied_volatility.iv_min = iv_min; % store min in ammo
info.ammo.stage(p).implied_volatility.iv_max = iv_max; % store max in ammo

%% Mean and Stdev of IV
% This is a quick and custom version of below

iv_statvector = implied_volatility_annual(1:90); % define data set with lookback

iv_average = mean(iv_statvector); % find the average over lookback period
iv_stdev = std(iv_statvector); % find the standard deviation
iv_stdev_high = iv_average + iv_stdev; % high iv vol
iv_stdev_low = iv_average - iv_stdev; % low iv vol
iv_pctv = (current_iv - iv_stdev_low) / (iv_stdev_high - iv_stdev_low); % relative positions from one stdev

info.ammo.stage(p).implied_volatility.iv_look_back_period = iv_lookback_period; % store lookback in ammo
info.ammo.stage(p).implied_volatility.iv_stdev = iv_stdev; % store stdev in ammo
info.ammo.stage(p).implied_volatility.iv_stdev_high = iv_stdev_high; % store high in ammo
info.ammo.stage(p).implied_volatility.iv_stdev_low = iv_stdev_low; % store low in ammo
info.ammo.stage(p).implied_volatility.iv_pctv = iv_pctv; % store low in ammo


%% Calculate Daily implied Volatility
 daily_iv_vol = implied_volatility_annual  ./ sqrt(252); %Back out daily implied volatility; assumption on trading days may need to be changed
 info.ammo.stage(p).implied_volatility.daily_iv_vol = daily_iv_vol;
 
%% Store Daily implied Volatility
 profile.daily_iv_vol = daily_iv_vol;

%% Convert Volatility into N days terms

   profile.implied_volatility_180 = daily_iv_vol * sqrt(180); 
   profile.implied_volatility_90 = daily_iv_vol * sqrt(90);
   profile.implied_volatility_80 = daily_iv_vol * sqrt(80);
   profile.implied_volatility_70 = daily_iv_vol * sqrt(70);
   profile.implied_volatility_60 = daily_iv_vol * sqrt(60);
   profile.implied_volatility_56 = daily_iv_vol * sqrt(56);
   profile.implied_volatility_45 = daily_iv_vol * sqrt(45);
   profile.implied_volatility_35 = daily_iv_vol * sqrt(35);
   profile.implied_volatility_30 = daily_iv_vol * sqrt(30);
   profile.implied_volatility_20 = daily_iv_vol * sqrt(20);
   profile.implied_volatility_14 = daily_iv_vol * sqrt(14);
   profile.implied_volatility_10 = daily_iv_vol * sqrt(10);
   profile.implied_volatility_8 = daily_iv_vol * sqrt(8);
   profile.implied_volatility_5 = daily_iv_vol * sqrt(5);
    

%% Average Volatility per Lookback period

i=0;
for i = 1:size(implied_volatility_annual,1)
    try
        cone.implied_volatility_annual_1(i,1) = mean(implied_volatility_annual(i:i));
        cone.implied_volatility_annual_2(i,1) = mean(implied_volatility_annual(i:1+i));
        cone.implied_volatility_annual_3(i,1) = mean(implied_volatility_annual(i:2+i));
        cone.implied_volatility_annual_5(i,1) = mean(implied_volatility_annual(i:4+i));
        cone.implied_volatility_annual_10(i,1) = mean(implied_volatility_annual(i:9+i));
        cone.implied_volatility_annual_20(i,1) = mean(implied_volatility_annual(i:19+i));%4 weeks
        cone.implied_volatility_annual_30(i,1) = mean(implied_volatility_annual(i:29+i));%6 weeks
        cone.implied_volatility_annual_40(i,1) = mean(implied_volatility_annual(i:39+i));%8 weeks
        cone.implied_volatility_annual_50(i,1) = mean(implied_volatility_annual(i:49+i));%10 weeks
        cone.implied_volatility_annual_100(i,1) = mean(implied_volatility_annual(i:99+i));%20 weeks
        cone.implied_volatility_annual_130(i,1) = mean(implied_volatility_annual(i:129+i));%26 weeks
        cone.implied_volatility_annual_190(i,1) = mean(implied_volatility_annual(i:189+i));%38 weeks
        cone.implied_volatility_annual_250(i,1) = mean(implied_volatility_annual(i:249+i));%50 weeks
    catch
        continue
    end
end


%% Build Cone

% Initialize
avgmean = [];
high = [];
low = [];


    avgmean(1,1) = mean(cone.implied_volatility_annual_1);
    high(1,1) = avgmean(1,1) + std(cone.implied_volatility_annual_1);
    low(1,1) = avgmean(1,1) - std(cone.implied_volatility_annual_1);

    avgmean(2,1) = mean(cone.implied_volatility_annual_2);
    high(2,1) = avgmean(2,1) + std(cone.implied_volatility_annual_2);
    low(2,1) = avgmean(2,1) - std(cone.implied_volatility_annual_2);

    avgmean(3,1) = mean(cone.implied_volatility_annual_3);
    high(3,1) = avgmean(3,1) + std(cone.implied_volatility_annual_3);
    low(3,1) = avgmean(3,1) - std(cone.implied_volatility_annual_3);

    avgmean(4,1) = mean(cone.implied_volatility_annual_5);
    high(4,1) = avgmean(4,1) + std(cone.implied_volatility_annual_5);
    low(4,1) = avgmean(4,1) - std(cone.implied_volatility_annual_5);

    avgmean(5,1) = mean(cone.implied_volatility_annual_10);
    high(5,1) = avgmean(5,1) + std(cone.implied_volatility_annual_10);
    low(5,1) = avgmean(5,1) - std(cone.implied_volatility_annual_10);

    avgmean(6,1) = mean(cone.implied_volatility_annual_20);
    high(6,1) = avgmean(6,1) + std(cone.implied_volatility_annual_20);
    low(6,1) = avgmean(6,1) - std(cone.implied_volatility_annual_20);

    avgmean(7,1) = mean(cone.implied_volatility_annual_30);
    high(7,1) = avgmean(7,1) + std(cone.implied_volatility_annual_30);
    low(7,1) = avgmean(7,1) - std(cone.implied_volatility_annual_30);

    avgmean(8,1) = mean(cone.implied_volatility_annual_40);
    high(8,1) = avgmean(8,1) + std(cone.implied_volatility_annual_40);
    low(8,1) = avgmean(8,1) - std(cone.implied_volatility_annual_40);

    avgmean(9,1) = mean(cone.implied_volatility_annual_50);
    high(9,1) = avgmean(9,1) + std(cone.implied_volatility_annual_50);
    low(9,1) = avgmean(9,1) - std(cone.implied_volatility_annual_50);

    avgmean(10,1) = mean(cone.implied_volatility_annual_100);
    high(10,1) = avgmean(10,1) + std(cone.implied_volatility_annual_100);
    low(10,1) = avgmean(10,1) - std(cone.implied_volatility_annual_100);

    avgmean(11,1) = mean(cone.implied_volatility_annual_130);
    high(11,1) = avgmean(11,1) + std(cone.implied_volatility_annual_130);
    low(11,1) = avgmean(11,1) - std(cone.implied_volatility_annual_130);

    avgmean(12,1) = mean(cone.implied_volatility_annual_190);
    high(12,1) = avgmean(12,1) + std(cone.implied_volatility_annual_190);
    low(12,1) = avgmean(12,1) - std(cone.implied_volatility_annual_190);

    avgmean(13,1) = mean(cone.implied_volatility_annual_250);
    high(13,1) = avgmean(13,1) + std(cone.implied_volatility_annual_250);
    low(13,1) = avgmean(13,1) - std(cone.implied_volatility_annual_250);


%% Volatility cone
cone.implied_vol_cone = 100 * [low avgmean high];

%% Store variable into ammo structure
info.ammo.stage(p).implied_volatility.cone = cone;
info.ammo.stage(p).implied_volatility.profile = profile;

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_iv_profilecone',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end


%% NOTES
% DOUBLE CHECK Calculations
% Checked against excel file, it is accurate.

% To get a real time implied vol cone you need to put in a for loop to
% iterate through each price vector and you will be able to do this for
% each snapshot. The formula will be more complicated than this. Might be
% easier to start at one year back, have another year for lag, then run all
% the way up to present capturing each days new X-day iv. That way you will
% be able to capture % difference between those

% Daily Volatility 1 Standard deviation based on 1 years worth of data
%       The high/low range that occurs 68.2% of the time

% Redundant storage of implied_volatility_annual; easier to pick out and
% is stored in .profile.

% From there we have to build the vol cone.
% Store the avg, stdev high, and stdev low matrix least DTE to greatest
% DEFINE: how much volatility narrows or reverts to its mean the further out from
%   expiration you go.
%Have to think about capping this range
%%%%%%%% avgmean(1,1) = mean(implied_volatility_annual_1(1:1000));

%X-axis needs to be changed when adding more days(weeks) to expirations
% x_axis = [1;2;3;5;10;20;30;40;50;100;130;190;250];
% plot(x_axis,implied_vol_cone);
% Works!

%This is the variable formula
% close = [536.86;537.46;539.78;544.99;539.19;532.87;528.7;531.26;526.74];
% implied_volatility = std(log(close(2:end)./close(1:end-1))*100) * sqrt(iv_lookback);