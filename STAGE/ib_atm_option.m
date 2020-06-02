function [info] = ib_atm_option(info)
%% Pulls ATM Option information
% expiration date for both puts and calls are defined in params
 %rounds down current underlying price and queryies that strike price
 
%% Hard Code Parameters
clientid = info.params.ibconnection.clientid; % clientId
port = info.params.ibconnection.port; % port

for i = 1:size(info.ammo.stage,2)
    try
%% Soft code variables        
strike = num2str(round(info.ammo.stage(i).historical_bars.close(1,1)));

% catch statment for strikes less than 2 places, the ib queries requires there to be a certain length in the localsymbol column, if the strike is
                                                                                        % less than 100 there needs to be a leading zero inserted
if length(strike) == 2
    strike = ['0' strike];
end
            call_atmexpiry = info.ammo.stage(i).call_atmexpiry;    
            call_localsymbol = [call_atmexpiry strike '000']; % concatenate and soft code localsymbol
            atm_options.call_localsymbol = call_localsymbol; % store call localsymbol
            
            put_atmexpiry = info.ammo.stage(i).put_atmexpiry;    
            put_localsymbol = [put_atmexpiry strike '000']; % concatenate and soft code localsymbol
            atm_options.put_localsymbol = put_localsymbol; % store put localsymbol                
                
%% Query the ATM Call Option
         data_option = IBMatlab('action','query','localsymbol',call_localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
         if isempty(data_option) % empty data – try to re-request the same data
              [data_option, ibConnectionObject] = IBMatlab('action','query','localsymbol',call_localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
          end
          if isempty(data_option) % still empty data – try to disconnect/reconnect
              ibConnectionObject.disconnectFromTWS; % disconnect from IB
              pause(1); % let IB cool down a bit
              data_option = IBMatlab('action','query','localsymbol',call_localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % will automatically reconnect
          end

         if(isfield(data_option,'bidOptComp'))
                           data_option.optPrice = data_option.bidOptComp.optPrice;  
                           data_option.impliedVol = data_option.bidOptComp.impliedVol;
                            data_option.delta = data_option.bidOptComp.delta;
                            data_option.pos = data_option.bidOptComp.delta;
                            data_option.gamma = data_option.bidOptComp.gamma;
                            data_option.theta = data_option.bidOptComp.theta;
                            data_option.vega = data_option.bidOptComp.vega;

                     elseif(isfield(data_option,'askOptComp'))
                            data_option.optPrice = data_option.askOptComp.optPrice;  
                            data_option.impliedVol = data_option.askOptComp.impliedVol;
                            data_option.delta = data_option.askOptComp.delta;
                            data_option.pos = data_option.askOptComp.delta;
                            data_option.gamma = data_option.askOptComp.gamma;
                            data_option.theta = data_option.askOptComp.theta;
                            data_option.vega = data_option.askOptComp.vega;

                     elseif(isfield(data_option,'lastOptComp'))
                            data_option.optPrice = data_option.lastOptComp.optPrice;  
                            data_option.impliedVol = data_option.lastOptComp.impliedVol;
                            data_option.delta = data_option.lastOptComp.delta;
                            data_option.pos = data_option.lastOptComp.delta;
                            data_option.gamma = data_option.lastOptComp.gamma;
                            data_option.theta = data_option.lastOptComp.theta;
                            data_option.vega = data_option.lastOptComp.vega;

                     elseif(isfield(data_option,'modelOptComp'))
                            data_option.optPrice = data_option.modelOptComp.optPrice;  
                            data_option.impliedVol = data_option.modelOptComp.impliedVol;
                            data_option.delta = data_option.modelOptComp.delta;
                            data_option.pos = data_option.modelOptComp.delta;
                            data_option.gamma = data_option.modelOptComp.gamma;
                            data_option.theta = data_option.modelOptComp.theta;
                            data_option.vega = data_option.modelOptComp.vega;

                     else
                            data_option.optPrice = 999;  
                            data_option.impliedVol = 999;
                            data_option.delta = 999;
                            data_option.pos = 999;
                            data_option.gamma = 999;
                            data_option.theta = 999;
                            data_option.vega = 999;
         end 
        
            atm_options.call = data_option; % store in soft structure     
             
%% Query the ATM Put Option
         data_option = IBMatlab('action','query','localsymbol',put_localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
         if isempty(data_option) % empty data – try to re-request the same data
              [data_option, ibConnectionObject] = IBMatlab('action','query','localsymbol',put_localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
          end
          if isempty(data_option) % still empty data – try to disconnect/reconnect
              ibConnectionObject.disconnectFromTWS; % disconnect from IB
              pause(1); % let IB cool down a bit
              data_option = IBMatlab('action','query','localsymbol',put_localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % will automatically reconnect
          end

         if(isfield(data_option,'bidOptComp'))
                           data_option.optPrice = data_option.bidOptComp.optPrice;  
                           data_option.impliedVol = data_option.bidOptComp.impliedVol;
                            data_option.delta = data_option.bidOptComp.delta;
                            data_option.pos = data_option.bidOptComp.delta;
                            data_option.gamma = data_option.bidOptComp.gamma;
                            data_option.theta = data_option.bidOptComp.theta;
                            data_option.vega = data_option.bidOptComp.vega;

                     elseif(isfield(data_option,'askOptComp'))
                            data_option.optPrice = data_option.askOptComp.optPrice;  
                            data_option.impliedVol = data_option.askOptComp.impliedVol;
                            data_option.delta = data_option.askOptComp.delta;
                            data_option.pos = data_option.askOptComp.delta;
                            data_option.gamma = data_option.askOptComp.gamma;
                            data_option.theta = data_option.askOptComp.theta;
                            data_option.vega = data_option.askOptComp.vega;

                     elseif(isfield(data_option,'lastOptComp'))
                            data_option.optPrice = data_option.lastOptComp.optPrice;  
                            data_option.impliedVol = data_option.lastOptComp.impliedVol;
                            data_option.delta = data_option.lastOptComp.delta;
                            data_option.pos = data_option.lastOptComp.delta;
                            data_option.gamma = data_option.lastOptComp.gamma;
                            data_option.theta = data_option.lastOptComp.theta;
                            data_option.vega = data_option.lastOptComp.vega;

                     elseif(isfield(data_option,'modelOptComp'))
                            data_option.optPrice = data_option.modelOptComp.optPrice;  
                            data_option.impliedVol = data_option.modelOptComp.impliedVol;
                            data_option.delta = data_option.modelOptComp.delta;
                            data_option.pos = data_option.modelOptComp.delta;
                            data_option.gamma = data_option.modelOptComp.gamma;
                            data_option.theta = data_option.modelOptComp.theta;
                            data_option.vega = data_option.modelOptComp.vega;

                     else
                            data_option.optPrice = 999;  
                            data_option.impliedVol = 999;
                            data_option.delta = 999;
                            data_option.pos = 999;
                            data_option.gamma = 999;
                            data_option.theta = 999;
                            data_option.vega = 999;
         end 
             
             atm_options.put = data_option; %store in soft structure
        
%% Store atm_options in ammo   
        info.ammo.stage(i).atm_options = atm_options; % store atm options in info
                
    catch ME
    end
end % end symbol loop
 



end