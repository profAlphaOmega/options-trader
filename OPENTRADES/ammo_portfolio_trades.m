function [info] = ammo_portfolio_trades(info)
try
%% Hard Code Portfolio
portfolio = info.ammo.opentrades; % hard code opentrades    
    
%% Symbol,right,dte Parsing
port_symbol_array = transpose({portfolio(:).symbol}); % portfolio symbol array

usva = unique(transpose({portfolio(:).symbol})); % portfolio unique symbol value array

symbol = [];
%% Run Symbol Loop
 for i = 1:size(usva,1) % loop for each symbol
    try
%% Parse out Symbol    
        symbol.(usva{i}).([usva{i} '_all']) = portfolio(strcmp(usva(i),port_symbol_array)); % parse out and store each symbol in own structure
        
%% Logical Position Array
        symbol_right_array = transpose({symbol.(usva{i}).([usva{i} '_all']).right}); % each symbol right array
   
%% Puts Weighted Position 
         symbol.(usva{i}).([usva{i} '_puts_all']) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_right_array,'P')); % store all puts
         udva_puts = unique(transpose([symbol.(usva{i}).([usva{i} '_puts_all']).dte])); % find unique dte for puts
         symbol.(usva{i}).([usva{i} '_puts_udva']) = udva_puts; % store for later indexing
         symbol_dte_put_array = transpose([symbol.(usva{i}).([usva{i} '_puts_all']).dte]); % create dte index array for puts
        
        j=0;
        for j = 1:size(udva_puts,1) % parse out loop for put dte
            try
                      
                symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))]) = symbol.(usva{i}).([usva{i} '_puts_all'])(symbol_dte_put_array == udva_puts(j));
                
                sindex = le(transpose([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))]).position]),-1); % short position index
                lindex = ge(transpose([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))]).position]),1); % long position index
                
        %% Comp Name,DTE, and Current UL
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_name = [usva{i} '_puts_' num2str(udva_puts(j))];
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_dte = udva_puts(j);
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).current_ul = [symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(1).current_ul];
        %% Comp Long Strike
                symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_long_strike = sum(([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(lindex).strike] .* ... % long weighted strike
                     abs([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(lindex).position]))) ...
                     / sum(abs([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(lindex).position]));
        %% Comp Premium Paid         
                symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_premium_paid = sum(([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(lindex).averageCost] .* ... % weighted cost
                     abs([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(lindex).position]))) ...
                     / sum(abs([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(lindex).position])); 
        %% Comp Short Strike
                symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_short_strike = sum(([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(sindex).strike] .* ... % short weighted strike
                     abs([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(sindex).position]))) ...
                     / sum(abs([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(sindex).position]));
        %% Comp Credit Recieved
                symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_credit_received = sum(([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(sindex).averageCost] .* ... % 
                     abs([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(sindex).position]))) ...
                     / sum(abs([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))])(sindex).position])); % weighted credit received
         
        %% Comp NCR, BE, MaxProfit, MaxLoss, and PL     
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_ncr = (symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_credit_received -  symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_premium_paid) / 100;
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_breakeven =  symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_short_strike -  symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_ncr; 
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_maxprofit =  symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_ncr;
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_maxloss =  symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_breakeven -  symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_long_strike;
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_pl = sum([symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))]).pl]); % already adjusted by position in opentrades calculations
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_pop = 1 - (symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_ncr / abs((symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_short_strike - symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_long_strike)));
                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_ror = symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_ncr / (symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_breakeven - symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j)) '_weighted']).comp_long_strike); % Return on Risk
                 
            catch 
                continue
            end
        end
        
%% Calls Weighted Position
        symbol.(usva{i}).([usva{i} '_calls_all']) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_right_array,'C')); % store all calls
        udva_calls = unique(transpose([symbol.(usva{i}).([usva{i} '_calls_all']).dte])); % find unique dte for calls
        symbol.(usva{i}).([usva{i} '_calls_udva']) = udva_calls;
        symbol_dte_call_array = transpose([symbol.(usva{i}).([usva{i} '_calls_all']).dte]); % create dte index array for calls
        
        j=0;
        for j = 1:size(udva_calls,1) % parse out loop for call dte
            try
           
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))]) = symbol.(usva{i}).([usva{i} '_calls_all'])(symbol_dte_call_array == udva_calls(j));
                
                sindex = le(transpose([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))]).position]),-1); % short position index
                lindex = ge(transpose([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))]).position]),1); % long position index
           
                
         %% Comp Name,DTE, and Current UL
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_name = [usva{i} '_calls_' num2str(udva_calls(j))];
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_dte = udva_calls(j);
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).current_ul = [symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(1).current_ul];
             
         %% Comp Long Strike
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_long_strike = sum(([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(lindex).strike] .* ... % long weighted strike
                     abs([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(lindex).position]))) ...
                     / sum(abs([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(lindex).position]));
         %% Comp Premium Paid 
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_premium_paid = sum(([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(lindex).averageCost] .* ... % weighted cost
                     abs([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(lindex).position]))) ...
                     / sum(abs([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(lindex).position])); 
         %% Comp Short Strike
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_short_strike = sum(([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(sindex).strike] .* ... % short weighted strike
                     abs([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(sindex).position]))) ...
                     / sum(abs([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(sindex).position]));
         %% Comp Credit Recieved
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_credit_received = sum(([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(sindex).averageCost] .* ... % 
                     abs([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(sindex).position]))) ...
                     / sum(abs([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))])(sindex).position])); % weighted credit received
         %% Comp NCR, BE, MaxProfit, MaxLoss, and PL
                 symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_ncr = (symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_credit_received - symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_premium_paid) / 100;
                 symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_breakeven = symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_short_strike + symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_ncr; 
                 symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_maxprofit = symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_ncr;
                 symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_maxloss = symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_long_strike - symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_breakeven;
                 symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_pl = sum([symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))]).pl]); % already adjusted by position in opentrades calculations
                 symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_pop = 1 - (symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_ncr / abs((symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_short_strike - symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_long_strike)));               
                 symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_ror = symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_ncr / (symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_long_strike - symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j)) '_weighted']).comp_breakeven); % Return on Risk
            catch ME
                continue
            end
        end
     
    catch
        continue
    end
 end

%% Store in Portfolio
info.ammo.portfolio.symbol_index = usva; % store unique symbol list
info.ammo.portfolio.trades = symbol; % store in ammo

%% Portfolio Total P/L

info.ammo.portfolio.pl = sum(transpose([info.ammo.opentrades(:).pl])); % could now be redundant after found in ib account pull

 catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_portfolio_sort',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end




%% Symbol,right,dte 
% port_symbol_array = transpose({portfolio(:).symbol});
% 
% usva = unique(transpose({portfolio(:).symbol}));
% 
%  for i = 1:size(usva,1)
%     try
%    
%         symbol.(usva{i}).([usva{i} '_all']) = portfolio(strcmp(usva(i),port_symbol_array));
%         
%         symbol_right_array = transpose({symbol.(usva{i}).([usva{i} '_all']).right});
%         
%          symbol.(usva{i}).([usva{i} '_puts_all']) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_right_array,'P'));
%          udva_puts = unique(transpose([symbol.(usva{i}).([usva{i} '_puts_all']).dte]));      
%          symbol_dte_put_array = transpose([symbol.(usva{i}).([usva{i} '_puts_all']).dte]);
%         
%         j=0;
%         for j = 1:size(udva_puts,1)
%             try
%            
%                 symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))]) = symbol.(usva{i}).([usva{i} '_puts_all'])(symbol_dte_put_array == udva_puts(j));
%                 
%             catch ME
%             end
%         end
%         
%         
%         symbol.(usva{i}).([usva{i} '_calls_all']) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_right_array,'C'));
%         udva_calls = unique(transpose([symbol.(usva{i}).([usva{i} '_calls_all']).dte]));
%         symbol_dte_call_array = transpose([symbol.(usva{i}).([usva{i} '_calls_all']).dte]);
%         
%         j=0;
%         for j = 1:size(udva_calls,1)
%             try
%            
%                 symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))]) = symbol.(usva{i}).([usva{i} '_calls_all'])(symbol_dte_call_array == udva_calls(j));
%                 
%             catch ME
%             end
%         end
%         
%         
%         
%     catch ME
%     end
%  end
%  
% 
%% Symbol,right,expiry
% port_symbol_array = transpose({portfolio(:).symbol});
% 
% usva = unique(transpose({portfolio(:).symbol}));
% 
%  for i = 1:size(usva,1)
%     try
%    
%         symbol.(usva{i}).([usva{i} '_all']) = portfolio(strcmp(usva(i),port_symbol_array));
%         
%         symbol_right_array = transpose({symbol.(usva{i}).([usva{i} '_all']).right});
%         
%          symbol.(usva{i}).([usva{i} '_puts_all']) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_right_array,'P'));
%          udva_puts = unique(transpose({symbol.(usva{i}).([usva{i} '_puts_all']).expiry}));      
%          symbol_expiry_put_array = transpose({symbol.(usva{i}).([usva{i} '_puts_all']).expiry});
%         
%         j=0;
%         for j = 1:size(udva_puts,1)
%             try
%            
%                 symbol.(usva{i}).([usva{i} '_puts_' udva_puts{j}]) = symbol.(usva{i}).([usva{i} '_puts_all'])(strcmp(symbol_expiry_put_array,udva_puts{j}));
%                 
%             catch ME
%             end
%         end
%         
%         
%         
%         symbol.(usva{i}).([usva{i} '_calls_all']) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_right_array,'C'));
%         udva_calls = unique(transpose({symbol.(usva{i}).([usva{i} '_calls_all']).expiry}));
%         symbol_dte_call_array = transpose({symbol.(usva{i}).([usva{i} '_calls_all']).expiry});
%         
%         j=0;
%         for j = 1:size(udva_calls,1)
%             try
%            
%                 symbol.(usva{i}).([usva{i} '_calls_' udva_calls{j}]) = symbol.(usva{i}).([usva{i} '_calls_all'])(strcmp(symbol_dte_call_array,udva_calls{j}));
%                 
%             catch ME
%             end
%         end
%         
%         
%         
%     catch ME
%     end
%  end
%  



%% symbol,dte
% port_symbol_array = transpose({portfolio(:).symbol});
% 
% usva = unique(transpose({portfolio(:).symbol}));
% 
%  for i = 1:size(usva,1)
%     try
%    
%         symbol.(usva{i}).([usva{i} '_all']) = portfolio(strcmp(usva(i),port_symbol_array));
%   
%         
%         udva = unique(transpose([symbol.(usva{i}).([usva{i} '_all']).dte]));
%         symbol_dte_array = transpose([symbol.(usva{i}).([usva{i} '_all']).dte]);
%         
%         for j = 1:size(udva,1)
%             try
%            
%                 symbol.(usva{i}).([usva{i} '_' num2str(udva(j))]) = symbol.(usva{i}).([usva{i} '_all'])(symbol_dte_array == udva(j));
%                 
%             catch ME
%             end
%         end
%         
%     catch ME
%     end
%  end
%  




%% symbol, expiry
% port_symbol_array = transpose({portfolio(:).symbol});
% 
% usva = unique(transpose({portfolio(:).symbol}));
% 
%  for i = 1:size(usva,1)
%     try
%    
%         symbol.(usva{i}).([usva{i} '_all']) = portfolio(strcmp(usva(i),port_symbol_array));
%         
%         udva = unique(transpose({symbol.(usva{i}).([usva{i} '_all']).expiry}));
%         symbol_expiry_array = transpose({symbol.(usva{i}).([usva{i} '_all']).expiry});
%         
%         for j = 1:size(udva,1)
%             try
%            
%                 symbol.(usva{i}).([usva{i} '_' udva{j}]) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_expiry_array,udva{j}));
%                 
%             catch ME
%             end
%         end
%         
%     catch ME
%     end
%  end