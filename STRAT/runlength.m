%%% RUNLENGTH.M FUNCTION
% STRAT RUN TYPE

%%%THIS FUNCTION ABREVIATES THE RUN LENGTH FOR A SPECIFIC NUMBER OF DAYS

function [info] = runlength(info)

% Param
run_length = info.params.run_length;

%Short UL variable
ul_x = info.strat_indicators.ul.ul;

if size(ul_x{1,5},1) > run_length
ul_x{1,1}(run_length:end) = [];
ul_x{1,2}(run_length:end) = [];
ul_x{1,3}(run_length:end) = [];
ul_x{1,4}(run_length:end) = [];
ul_x{1,5}(run_length:end) = [];
ul_x{1,6}(run_length:end) = [];
ul_x{1,7}(run_length:end) = [];
    
%else
%   ul_x = ul_x;
end

%UL Structure Build
info.ammo.stage.strat_indicators.ul.ul_x = ul_x;

end
    