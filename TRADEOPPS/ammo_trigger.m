function [info] = ammo_trigger(info)
try
%% Notes
%%% TRIGGER.M
% THIS IS TRIGGER.M FILE FOR STRAT RUN TYPE

%%%Trigger takes inputs and parameters from functions and analyzes to meet
%%%criteria for a sell put or call. Currently there are 4 criteria to be
%%%met: percent b, slow k, aroon oscillator, cc day moving average.

% List out Param values here for your reference


%% Build Params Inputs
trigger_pctb_high = info.params.strat_params.trigger_pctb_high;
trigger_pctb_low = info.params.strat_params.trigger_pctb_low;
% trigger_so_fastpctd_high = info.params.strat_params.trigger_so_fastpctd_high;
% trigger_so_fastpctd_low = info.params.strat_params.trigger_so_fastpctd_low;
% trigger_aroon_oscillator_high = info.params.strat_params.trigger_aroon_oscillator_high;
% trigger_aroon_oscillator_low = info.params.strat_params.trigger_aroon_oscillator_low;
% trigger_tslope_up = info.params.strat_params.trigger_tslope_up;
% trigger_tslope_dn = info.params.strat_params.trigger_tslope_dn;

% Iterate through ticker list
for i = 1:size(info.ammo.stage,2)
    try
        %% Hard code Strat inputs; still need to build out criteria because half below are not used
        
         bb_percentb = info.ammo.stage(i).strat_indicators.bollinger.bb_percentb;
%         so_fastpctd = info.ammo.stage(i).strat_indicators.stochastic.so_fastpctd;
%         aroon_oscillator = info.ammo.stage(i).strat_indicators.aroon.aroon_oscillator;
%         ma_c = info.ammo.stage(i).strat_indicators.moveavg.ma_c;
%         ma_tslope = info.ammo.stage(i).strat_indicators.moveavg.ma_tslope;
%         macdline = info.ammo.stage(i).strat_indicators.macd.macdline;
%         macd_osma = info.ammo.stage(i).strat_indicators.macd.macd_osma;
%         macd_fast = info.ammo.stage(i).strat_indicators.macd.macd_fast;
%         resistance = info.ammo.stage(i).strat_indicators.level.resistance;
%         support = info.ammo.stage(i).strat_indicators.level.support;
        
        
%% Percent B conversion from percentage to rational number
        bb_percentb = (bb_percentb)*100;
        
        
%% Sell put criteria
%         info.ammo.stage(i).strat_indicators.trigger.sell_put = 1; % testing purposes
%         ...
            info.ammo.stage(i).strat_indicators.trigger.sell_put = (bb_percentb < trigger_pctb_low);
%             (so_fastpctd < trigger_so_fastpctd_low) & ...
%             (aroon_oscillator < trigger_aroon_oscillator_low);
        
        
%% Sell call criteria
%         info.ammo.stage(i).strat_indicators.trigger.sell_call = 0; % testing purposes
%         ...
            info.ammo.stage(i).strat_indicators.trigger.sell_call = (bb_percentb > trigger_pctb_high);
%             (so_fastpctd > trigger_so_fastpctd_high) & ...
%             (aroon_oscillator > trigger_aroon_oscillator_high);
%         
    catch 
        continue
    end
end

catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_trigger',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end
   
   
  
   
   