function [info] = ammo_historical_vol(info,close_prices,p)
%% NOTES
% DOUBLE CHECK Calculations
% Checked against excel file, it is accurate.

% To get a real time historical vol cone you need to put in a for loop to
% iterate through each price vector and you will be able to do this for
% each snapshot. The formula will be more complicated than this. Might be
% easier to start at one year back, have another year for lag, then run all
% the way up to present capturing each days new X-day hv. That way you will
% be able to capture % difference between those



%% Prealloaction
    historical_volatility_annual = zeros(size(close_prices,1),1);
    historical_volatility_180 = zeros(size(close_prices,1),1);
    historical_volatility_90 = zeros(size(close_prices,1),1);
    historical_volatility_80 = zeros(size(close_prices,1),1);
    historical_volatility_70 = zeros(size(close_prices,1),1);
    historical_volatility_60 = zeros(size(close_prices,1),1);
    historical_volatility_56 = zeros(size(close_prices,1),1);
    historical_volatility_45 = zeros(size(close_prices,1),1);
    historical_volatility_30 = zeros(size(close_prices,1),1);
    historical_volatility_20 = zeros(size(close_prices,1),1);
    historical_volatility_10 = zeros(size(close_prices,1),1);
    historical_volatility_8 = zeros(size(close_prices,1),1);
    historical_volatility_5 = zeros(size(close_prices,1),1);
    historical_volatility_1 = zeros(size(close_prices,1),1);
    historical_volatility_annual_1 = zeros(size(close_prices,1),1);
    historical_volatility_annual_2 = zeros(size(close_prices,1),1);
    historical_volatility_annual_3 = zeros(size(close_prices,1),1);
    historical_volatility_annual_5 = zeros(size(close_prices,1),1);
    historical_volatility_annual_10 = zeros(size(close_prices,1),1);
    historical_volatility_annual_20 = zeros(size(close_prices,1),1);
    historical_volatility_annual_30 = zeros(size(close_prices,1),1);
    historical_volatility_annual_40 = zeros(size(close_prices,1),1);
    historical_volatility_annual_50 = zeros(size(close_prices,1),1);
    historical_volatility_annual_100 = zeros(size(close_prices,1),1);
    historical_volatility_annual_130 = zeros(size(close_prices,1),1);
    historical_volatility_annual_190 = zeros(size(close_prices,1),1);
    historical_volatility_annual_250 = zeros(size(close_prices,1),1);

%% Storing historical vol based on time frames

for i = 1:size(close_prices,1)
 try

% Daily Volatility 1 Standard deviation based on 1 years worth of data
%       The high/low range that occurs 68.2% of the time
 daily_hv_vol = std(log(close_prices(i:((251+i)-1))./close_prices((i+1):(251+i))*100));
  
% Convert daily vol into below time frames
    historical_volatility_annual(i,1) = daily_hv_vol * sqrt(252);
    historical_volatility_180(i,1) = daily_hv_vol * sqrt(180);
    historical_volatility_90(i,1) = daily_hv_vol * sqrt(90);
    historical_volatility_80(i,1) = daily_hv_vol * sqrt(80);
    historical_volatility_70(i,1) = daily_hv_vol * sqrt(70);
    historical_volatility_60(i,1) = daily_hv_vol * sqrt(60);
    historical_volatility_56(i,1) = daily_hv_vol * sqrt(56);
    historical_volatility_45(i,1) = daily_hv_vol * sqrt(45);
    historical_volatility_30(i,1) = daily_hv_vol * sqrt(30);
    historical_volatility_20(i,1) = daily_hv_vol * sqrt(20);
    historical_volatility_10(i,1) = daily_hv_vol * sqrt(10);
    historical_volatility_8(i,1) = daily_hv_vol * sqrt(8);
    historical_volatility_5(i,1) = daily_hv_vol * sqrt(5);
    historical_volatility_1(i,1) = daily_hv_vol;
    
 catch ME
 end
end

% Historical Volatilty Time Profile
% Try to reshape to see what you have to put it in when reshaping back
   historical_vol_profile = 100 * [historical_volatility_annual historical_volatility_180 historical_volatility_90 historical_volatility_80 historical_volatility_70 historical_volatility_60 historical_volatility_56 historical_volatility_45 historical_volatility_30 historical_volatility_20 historical_volatility_10 historical_volatility_8 historical_volatility_5 historical_volatility_1];


% Finding average volatility for any given lookback period for the length
% of the annualized vol vector
i=0;
for i = 1:size(historical_volatility_annual,1)
 try  
    historical_volatility_annual_1(i,1) = mean(historical_volatility_annual(i:i));
    historical_volatility_annual_2(i,1) = mean(historical_volatility_annual(i:1+i));
    historical_volatility_annual_3(i,1) = mean(historical_volatility_annual(i:3+i));
    historical_volatility_annual_5(i,1) = mean(historical_volatility_annual(i:4+i));
    historical_volatility_annual_10(i,1) = mean(historical_volatility_annual(i:9+i));
    historical_volatility_annual_20(i,1) = mean(historical_volatility_annual(i:19+i));%4 weeks
    historical_volatility_annual_30(i,1) = mean(historical_volatility_annual(i:29+i));%6 weeks
    historical_volatility_annual_40(i,1) = mean(historical_volatility_annual(i:39+i));%8 weeks
    historical_volatility_annual_50(i,1) = mean(historical_volatility_annual(i:49+i));%10 weeks
    historical_volatility_annual_100(i,1) = mean(historical_volatility_annual(i:99+i));%20 weeks
    historical_volatility_annual_130(i,1) = mean(historical_volatility_annual(i:129+i));%26 weeks
    historical_volatility_annual_190(i,1) = mean(historical_volatility_annual(i:189+i));%38 weeks
    historical_volatility_annual_250(i,1) = mean(historical_volatility_annual(i:249+i));%50 weeks
 catch ME
 end
end


%---------------------------------------------------------------------------
% From there we have to build the vol cone.
% Store the avg, stdev high, and stdev low matrix least DTE to greatest

% DEFINE: how much volatility narrows or reverts to its mean the further out from
%   expiration you go.
%Have to think about capping this range

%%%%%%%% avgmean(1,1) = mean(historical_volatility_annual_1(1:1000));
avgmean(1,1) = mean(historical_volatility_annual_1);
high(1,1) = avgmean(1,1) + std(historical_volatility_annual_1);
low(1,1) = avgmean(1,1) - std(historical_volatility_annual_1);

avgmean(2,1) = mean(historical_volatility_annual_2);
high(2,1) = avgmean(2,1) + std(historical_volatility_annual_2);
low(2,1) = avgmean(2,1) - std(historical_volatility_annual_2);

avgmean(3,1) = mean(historical_volatility_annual_3);
high(3,1) = avgmean(3,1) + std(historical_volatility_annual_3);
low(3,1) = avgmean(3,1) - std(historical_volatility_annual_3);

avgmean(4,1) = mean(historical_volatility_annual_5);
high(4,1) = avgmean(4,1) + std(historical_volatility_annual_5);
low(4,1) = avgmean(4,1) - std(historical_volatility_annual_5);

avgmean(5,1) = mean(historical_volatility_annual_10);
high(5,1) = avgmean(5,1) + std(historical_volatility_annual_10);
low(5,1) = avgmean(5,1) - std(historical_volatility_annual_10);

avgmean(6,1) = mean(historical_volatility_annual_20);
high(6,1) = avgmean(6,1) + std(historical_volatility_annual_20);
low(6,1) = avgmean(6,1) - std(historical_volatility_annual_20);

avgmean(7,1) = mean(historical_volatility_annual_30);
high(7,1) = avgmean(7,1) + std(historical_volatility_annual_30);
low(7,1) = avgmean(7,1) - std(historical_volatility_annual_30);

avgmean(8,1) = mean(historical_volatility_annual_40);
high(8,1) = avgmean(8,1) + std(historical_volatility_annual_40);
low(8,1) = avgmean(8,1) - std(historical_volatility_annual_40);

avgmean(9,1) = mean(historical_volatility_annual_50);
high(9,1) = avgmean(9,1) + std(historical_volatility_annual_50);
low(9,1) = avgmean(9,1) - std(historical_volatility_annual_50);
 
avgmean(10,1) = mean(historical_volatility_annual_100);
high(10,1) = avgmean(10,1) + std(historical_volatility_annual_100);
low(10,1) = avgmean(10,1) - std(historical_volatility_annual_100);
 
avgmean(11,1) = mean(historical_volatility_annual_130);
high(11,1) = avgmean(11,1) + std(historical_volatility_annual_130);
low(11,1) = avgmean(11,1) - std(historical_volatility_annual_130);

avgmean(12,1) = mean(historical_volatility_annual_190);
high(12,1) = avgmean(12,1) + std(historical_volatility_annual_190);
low(12,1) = avgmean(12,1) - std(historical_volatility_annual_190);

avgmean(13,1) = mean(historical_volatility_annual_250);
high(13,1) = avgmean(13,1) + std(historical_volatility_annual_250);
low(13,1) = avgmean(13,1) - std(historical_volatility_annual_250);


%Volatility cone
historical_vol_cone = 100 * [low avgmean high];

%X-axis needs to be changed when adding more days(weeks) to expirations
x_axis = [1;2;3;5;10;20;30;40;50;100;130;190;250];
plot(x_axis,historical_vol_cone);
% Works!

% Store variables into ammo structure
info.ammo.stage(p).volatility.ammo_historical_vol_profile = historical_vol_profile;
info.ammo.stage(p).volatility.ammo_historical_vol_cone = historical_vol_cone;

end




%This is the variable formula
% close = [536.86;537.46;539.78;544.99;539.19;532.87;528.7;531.26;526.74];
% historical_volatility = std(log(close(2:end)./close(1:end-1))*100) * sqrt(hv_lookback);
