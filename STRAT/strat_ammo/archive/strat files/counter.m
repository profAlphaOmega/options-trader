%%% COUNTER.M FUNCTION
% STRAT RUN OF COUNTER.M FUNCTION

%%%This function is a counter for number of days
function [info] = counter(info)

%Close price vector
close = info.ul.ul_x{:,5};

%Preallocation vector
pkey = zeros(size(close,1),1);

%Loop for counter
for i = 1:size(close,1)
    try
        pkey(i,1) = i;
    catch ME
    end
end
    %flipud
    %pkey = flipud(pkey);
    
%Counter Structure Build   
info.counter.pkey = pkey;

end