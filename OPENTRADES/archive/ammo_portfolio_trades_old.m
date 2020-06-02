function [info] = ammo_portfolio_trades(info)
try

portfolio = info.ammo.opentrades; % hard code opentrades    
    
%% Symbol,right,dte 

port_symbol_array = transpose({portfolio(:).symbol}); % portfolio symbol array

usva = unique(transpose({portfolio(:).symbol})); % portfolio unique symbol value array

 for i = 1:size(usva,1) % loop for each symbol
    try
   %% Parse out symbols
        symbol.(usva{i}).([usva{i} '_all']) = portfolio(strcmp(usva(i),port_symbol_array)); % parse out and store each symbol in own structure
        symbol_right_array = transpose({symbol.(usva{i}).([usva{i} '_all']).right}); % each symbol right array
   
    %% Puts
         symbol.(usva{i}).([usva{i} '_puts_all']) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_right_array,'P')); % store all puts
         udva_puts = unique(transpose([symbol.(usva{i}).([usva{i} '_puts_all']).dte])); % find unique dte for puts
         symbol_dte_put_array = transpose([symbol.(usva{i}).([usva{i} '_puts_all']).dte]); % create dte index array for puts
        
        j=0;
        for j = 1:size(udva_puts,1) % parse out loop for put dte
            try
           
                symbol.(usva{i}).([usva{i} '_puts_' num2str(udva_puts(j))]) = symbol.(usva{i}).([usva{i} '_puts_all'])(symbol_dte_put_array == udva_puts(j));
                
            catch 
                continue
            end
        end
        
    %% Calls
        symbol.(usva{i}).([usva{i} '_calls_all']) = symbol.(usva{i}).([usva{i} '_all'])(strcmp(symbol_right_array,'C')); % store all calls
        udva_calls = unique(transpose([symbol.(usva{i}).([usva{i} '_calls_all']).dte])); % find unique dte for calls
        symbol_dte_call_array = transpose([symbol.(usva{i}).([usva{i} '_calls_all']).dte]); % create dte index array for calls
        
        j=0;
        for j = 1:size(udva_calls,1) % parse out loop for call dte
            try
           
                symbol.(usva{i}).([usva{i} '_calls_' num2str(udva_calls(j))]) = symbol.(usva{i}).([usva{i} '_calls_all'])(symbol_dte_call_array == udva_calls(j));
                
            catch 
                continue
            end
        end
        
        
        
    catch
        continue
    end
 end
 
%% Store in ammo
info.ammo.portfolio.symbol_index = usva; % store unique symbol list
info.ammo.portfolio.trades = symbol; % store in ammo
 
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
%% Symbol,right,epiry
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