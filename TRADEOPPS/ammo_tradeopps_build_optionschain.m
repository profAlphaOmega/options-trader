%% AMMO_ANALYZE_OPTIONSCHAIN
function [info] = ammo_tradeopps_build_optionschain(info)
try
%% Hard Code Params
strike_tolerance = info.params.strat_params.strike_tolerance;
clientid = info.params.ibconnection.clientid;
port = info.params.ibconnection.port;

%% Run
for i = 1:size(info.ammo.tradeopps,2)
    try
%% Soft Code Variables
        symbol = info.ammo.tradeopps(i).symbol; %ticker with expiry
        ul_price = info.ammo.tradeopps(i).current_ul.bidPrice; % bid price for the underlying
        expiry = info.ammo.tradeopps(i).expiry;
        
        
%% Clean up Options Chain
        filename = ['C:\Users\Zato\Desktop\Master\AMMO\TRADEOPPS\options_chain\chain_' expiry '_' symbol '_' date '.csv']; % find filename
        chain_table = readtable(filename); % scan table (cell arrays)
        chain_table = unique(chain_table,'rows'); % delete duplicates
        chain_table(ne(chain_table{:,6},100),:) = []; %  no mini's; delete any row without a 100 multiplier
        
        %% delete far in or out of money strikes
        if (strcmp(info.ammo.tradeopps(i).pleg.pleg_right,'CALL'))
            chain_table(((chain_table{:,7} < (ul_price)) | ... % for calls; delete strikes below atm
                (chain_table{:,7} > (ul_price + strike_tolerance))),:) = []; % delete strikes far far out of the money
            
        elseif (strcmp(info.ammo.tradeopps(i).pleg.pleg_right,'PUT'))
            chain_table(((chain_table{:,7} > (ul_price)) | ... % for puts; delete strikes above atm
                (chain_table{:,7} < (ul_price - strike_tolerance))),:) = []; % delete strikes far far out of the money
        else continue
        end
        
        %% remove unnecessary rights
        if (strcmp(info.ammo.tradeopps(i).pleg.pleg_right,'CALL'))
            chain_table(strcmp(chain_table{:,5},'P'),:) = []; % delete puts from chain
        elseif (strcmp(info.ammo.tradeopps(i).pleg.pleg_right,'PUT'))
            chain_table(strcmp(chain_table{:,5},'C'),:) = []; % delete calls from chain
        else continue
        end
        
        chain_table = sortrows(chain_table,'localsymbol','ascend'); % sort ascending
        
        info.ammo.tradeopps(i).optionschain = table2struct(chain_table); % convert and store into structure
        info.ib.tradeopps(i).optionschain = table2struct(chain_table); % Store in ib
                
%% Query Options and Store Options in IB
        for j = 1:size(info.ammo.tradeopps(i).optionschain,1)
            try
                localsymbol = info.ammo.tradeopps(i).optionschain(j).localsymbol; % hard code local symbol
                
                data_option = IBMatlab('action','query','localsymbol',localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
                % error handling
                if isempty(data_option) % empty data – try to re-request the same data
                    [data_option, ibConnectionObject] = IBMatlab('action','query','localsymbol',localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
                end
                if isempty(data_option) % still empty data – try to disconnect/reconnect
                    ibConnectionObject.disconnectFromTWS; % disconnect from IB
                    pause(1); % let IB cool down a bit
                    data_option = IBMatlab('action','query','localsymbol',localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
                end
                
                
      %% store full verison in ib
      info.ib.tradeopps(i).optionschain(j).data_option = data_option; 
      
       info.ammo.tradeopps(i).optionschain(j).current_option = data_option; % store full option info in optionschain
                
       %% store comp fields
            if(isfield(data_option,'bidOptComp'))
                    info.ammo.tradeopps(i).optionschain(j).optPrice = data_option.bidOptComp.optPrice;  
                    info.ammo.tradeopps(i).optionschain(j).impliedVol = data_option.bidOptComp.impliedVol;
                    info.ammo.tradeopps(i).optionschain(j).delta = data_option.bidOptComp.delta;
                    info.ammo.tradeopps(i).optionschain(j).gamma = data_option.bidOptComp.gamma;
                    info.ammo.tradeopps(i).optionschain(j).theta = data_option.bidOptComp.theta;
                    info.ammo.tradeopps(i).optionschain(j).vega = data_option.bidOptComp.vega;
       
             elseif(isfield(data_option,'askOptComp'))
                    info.ammo.tradeopps(i).optionschain(j).optPrice = data_option.askOptComp.optPrice;  
                    info.ammo.tradeopps(i).optionschain(j).impliedVol = data_option.askOptComp.impliedVol;
                    info.ammo.tradeopps(i).optionschain(j).delta = data_option.askOptComp.delta;
                    info.ammo.tradeopps(i).optionschain(j).gamma = data_option.askOptComp.gamma;
                    info.ammo.tradeopps(i).optionschain(j).theta = data_option.askOptComp.theta;
                    info.ammo.tradeopps(i).optionschain(j).vega = data_option.askOptComp.vega;
      
             elseif(isfield(data_option,'lastOptComp'))
                    info.ammo.tradeopps(i).optionschain(j).optPrice = data_option.lastOptComp.optPrice;  
                    info.ammo.tradeopps(i).optionschain(j).impliedVol = data_option.lastOptComp.impliedVol;
                    info.ammo.tradeopps(i).optionschain(j).delta = data_option.lastOptComp.delta;
                    info.ammo.tradeopps(i).optionschain(j).gamma = data_option.lastOptComp.gamma;
                    info.ammo.tradeopps(i).optionschain(j).theta = data_option.lastOptComp.theta;
                    info.ammo.tradeopps(i).optionschain(j).vega = data_option.lastOptComp.vega;
                    
             elseif(isfield(data_option,'modelOptComp'))
                    info.ammo.tradeopps(i).optionschain(j).optPrice = data_option.modelOptComp.optPrice;  
                    info.ammo.tradeopps(i).optionschain(j).impliedVol = data_option.modelOptComp.impliedVol;
                    info.ammo.tradeopps(i).optionschain(j).delta = data_option.modelOptComp.delta;
                    info.ammo.tradeopps(i).optionschain(j).gamma = data_option.modelOptComp.gamma;
                    info.ammo.tradeopps(i).optionschain(j).theta = data_option.modelOptComp.theta;
                    info.ammo.tradeopps(i).optionschain(j).vega = data_option.modelOptComp.vega;
                  
             else
                    info.ammo.tradeopps(i).optionschain(j).optPrice = 999;  
                    info.ammo.tradeopps(i).optionschain(j).impliedVol = 999;
                    info.ammo.tradeopps(i).optionschain(j).delta = 999;
                    info.ammo.tradeopps(i).optionschain(j).gamma = 999;
                    info.ammo.tradeopps(i).optionschain(j).theta = 999;
                    info.ammo.tradeopps(i).optionschain(j).vega = 999;
            end
            
            catch 
                continue
            end
        end % end option query
        
        
    catch
        continue
    end 
    
    
end % end tradeopps loop



catch ME
    sendmail('ammodono@gmail.com', 'ERROR: ammo_tradeopps_build_optionschain',['identifier: ' ME.identifier 10 'message: ' ME.message 10 'function path: ' ME.stack.file 10 'function name: ' ME.stack.name 10 'line: ' num2str(ME.stack.line)]);
end
end

% %Matlab Calculated Greeks


% strikenum = contract.m_strike;
% current_ul = 196.43;
% rate = 0.02;
% dte = dte/365;
% annual_volatility = historical_vol; % annualized volatility for ul
% 
% 
%                 strike = optionschain(j).strike; % strike
%                 rate = info.params.strat_params.rfrate; % 4 week average risk free rate www.treasury.gov
%                 time = info.ammo.tradeopps(i).dte/252; % use trading days
%                 implied_volatility = optionschain(j).impliedVol; % use implied volatility for now cause that is what the market is currently saying
%                 
%                 [optionschain(j).m_calldelta,optionschain(j).m_putdelta] = blsdelta(ul_price,strike,rate,time,implied_volatility); % delta
%                 % [CallDelta, PutDelta] = blsdelta(Price, Strike, Rate, Time, Volatility, Yield)
%                 
%                 [optionschain(j).m_calltheoprice,optionschain(j).m_puttheoprice] = blsprice(ul_price,strike,rate,time,implied_volatility); % theoretical price
%                 % [Call, Put] = blkprice(Price, Strike, Rate, Time, Volatility)
%                 
%                 m_vega = blsvega(ul_price,strike,rate,time,implied_volatility); %
%                 optionschain(j).callvega = m_vega;
%                 optionschain(j).putvega = m_vega;
%                 % Vega = blsvega(Price, Strike, Rate, Time, Volatility, Yield)
%                 
%                 [optionschain(j).m_calltheta,optionschain(j).m_puttheta] = blstheta(ul_price,strike,rate,time,implied_volatility); % theta
%                 % [CallTheta, PutTheta] = blstheta(Price, Strike, Rate, Time, Volatility, Yield)
%                 
%                 m_gamma = blsgamma(ul_price,strike,rate,time,implied_volatility); % theta
%                 optionschain(j).m_callgamma = m_gamma;
%                 optionschain(j).m_putgamma = m_gamma;
            

                


