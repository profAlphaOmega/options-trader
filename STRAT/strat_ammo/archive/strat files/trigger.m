%%% TRIGGER.M
% THIS IS TRIGGER.M FILE FOR STRAT RUN TYPE

%%%Trigger takes inputs and parameters from functions and analyzes to meet
%%%criteria for a sell put or call. Currently there are 4 criteria to be
%%%met: percent b, slow k, aroon oscillator, cc day moving average.

function [info] = trigger(info)

% Params
trigger_pctb_high = info.params.trigger_pctb_high;
trigger_pctb_low = info.params.trigger_pctb_low;
trigger_so_fastpctd_high = info.params.trigger_so_fastpctd_high;
trigger_so_fastpctd_low = info.params.trigger_so_fastpctd_low;
trigger_aroon_oscillator_high = info.params.trigger_aroon_oscillator_high;
trigger_aroon_oscillator_low = info.params.trigger_aroon_oscillator_low;
trigger_tslope_up = info.params.trigger_tslope_up;
trigger_tslope_dn = info.params.trigger_tslope_dn;

% Create close price vector
  close = info.ul.ul_x{:,5};
  ma_c = info.moveavg.ma_c;
  ma_tslope = info.moveavg.ma_tslope;
  bb_percentb = info.bollinger.bb_percentb;
  macdline = info.macd.macdline;
  macd_histogram = info.macd.macd_histogram;
  macd_fast = info.macd.macd_fast;
  so_fastpctd = info.stochastic.so_fastpctd;
  aroon_oscillator = info.aroon.aroon_oscillator;
  resistance = info.level.resistance;
  support = info.level.support;
  
%%%Preallocation Vectors
% Sell vectors
  sell_put = zeros(size(close,1),1);
  sell_call = zeros(size(close,1),1);
% Put row vectors
  rfp1 = zeros(size(close,1),1);
  rfp2 = zeros(size(close,1),1);
  rfp3 = zeros(size(close,1),1);
  rfp4 = zeros(size(close,1),1);
  rfp = zeros(size(close,1),1);
% Call row vectors
  rfc1 = zeros(size(close,1),1);
  rfc2 = zeros(size(close,1),1);
  rfc3 = zeros(size(close,1),1);
  rfc4 = zeros(size(close,1),1);
  rfc = zeros(size(close,1),1);
   
% Percent B conversion from percentage to rational number
  bb_percentb = (bb_percentb)*100;
   
% Sell put criteria
  [pb_row] = find(bb_percentb < trigger_pctb_low);
  rfp1(pb_row,1) = 1;
  [pstoch_row] = find(so_fastpctd < trigger_so_fastpctd_low);
  rfp2(pstoch_row,1) = 1;
  [paroon_row] = find(aroon_oscillator < trigger_aroon_oscillator_low);
  rfp3(paroon_row,1) = 1;
  [ptslope_row] = find(ma_tslope > trigger_tslope_up);
  rfp4(ptslope_row,1) = 1;
   
% Evaluate to see what rows meet criteria
  rfp = rfp1 + rfp2 + rfp3 + rfp4;
   
% Find criteria rows
  [sp_row] = find(rfp == 4);
  sell_put(sp_row,1) = 1;
   
% Sell call criteria
  [cb_row] = find(bb_percentb > trigger_pctb_high );
  rfc1(cb_row,1) = 1;
  [cstoch_row] = find(so_fastpctd > trigger_so_fastpctd_high);
  rfc2(cstoch_row,1) = 1;
  [caroon_row] = find(aroon_oscillator > trigger_aroon_oscillator_high);
  rfc3(caroon_row,1) = 1;
  [ctslope_row] = find(ma_tslope < trigger_tslope_dn);
  rfc4(ctslope_row,1) = 1;
   
% Evaluate to see what rows meet criteria
  rfc = rfc1 + rfc2 + rfc3 + rfc4;
   
%Find criteria rows
  [sc_row] = find(rfc == 4);
  sell_call(sc_row,1) = 1;
   
% Trigger Structure Build
info.trigger.sell_put = sell_put;
info.trigger.sell_call = sell_call;

end
   
   
  
   
   