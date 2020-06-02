function [info] = ammo_tradeopps_legs(info)
try
%% Hard Code Params
pos = info.params.strat_params.pos; % Probability of OTM
strike_spread = info.params.strat_params.strike_spread; % width of strikes for verticals


%% Run
for i = 1:size(info.ammo.tradeopps,2)
    try
%% Pull Optionschain
        optionschain = info.ammo.tradeopps(i).optionschain; % pull chain
        
%% Convert and Soft Code Arrays
        strike_array = cell2mat(transpose({optionschain(:).strike})); % store as array for calculations 
        right_array = cell2mat(transpose({optionschain(:).right})); % store as array for calculations 
        optPrice_array = cell2mat(transpose({optionschain(:).optPrice})); % store as array for calculations
        impliedVol_array = cell2mat(transpose({optionschain(:).impliedVol})); % store as array for calculations
        delta_array = cell2mat(transpose({optionschain(:).delta})); % store as array for calculations
        gamma_array = cell2mat(transpose({optionschain(:).gamma})); % store as array for calculations
        theta_array = cell2mat(transpose({optionschain(:).theta})); % store as array for calculations
        vega_array = cell2mat(transpose({optionschain(:).vega})); % store as array for calculations
        
        
%% Find Pleg Option
        %delta index option identifier
        [value,delta_index] = min(abs((1 - abs(delta_array)) - pos)); % first convert itm deltas to otm and abs() for puts and calls; then find distance from param; then find index
  
        % store pleg option
         info.ammo.tradeopps(i).pleg.option = optionschain(delta_index); %store the option
         
%% Find Sleg Option
         if strcmp(right_array(delta_index),'P') % puts
             sleg_index = strike_array == (strike_array(delta_index) - strike_spread); % find index of pleg strike - spread
             info.ammo.tradeopps(i).sleg.option = optionschain(sleg_index); % store option in sleg
         elseif strcmp(right_array(delta_index),'C') % calls
             sleg_index = strike_array == (strike_array(delta_index) + strike_spread); % find index of pleg strike + spread
             info.ammo.tradeopps(i).sleg.option = optionschain(sleg_index); % store option in sleg
         else continue
         end
        
    catch 
        continue
    end
end


catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_tradeopps_legs',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end