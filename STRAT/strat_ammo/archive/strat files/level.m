%%% LEVEL.M FUNCTION
% STRAT RUN OF LEVEL.M

%%%Finds levels of support and resistance depending on look back period of
%%%mins and maxs.
function [info] = level(info)

%Param
level_period = info.params.level_period;

%Period for look back period
lag_period = level_period - 1;

%High Price
high = info.ul.ul_x{:,3};
%Low Price
low = info.ul.ul_x{:,4};
   
%Preallocation vectors
resistance = zeros(size(high,1),1);
support = zeros(size(high,1),1);

%Calculation for levels
i=0;
for i = 1:size(high,1)
    try
    resistance(i,1) = max(high(i:lag_period+i));
    support(i,1) = min(low(i:lag_period+i));
    catch ME
    end
end

%Level Structure Build
info.level.resistance = resistance;
info.level.support = support;
   
end