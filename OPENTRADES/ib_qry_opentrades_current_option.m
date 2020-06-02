function [info] = ib_qry_opentrades_current_option(info,i)
%% Hard Code Parameters
clientid = info.params.ibconnection.clientid; % clientId
port = info.params.ibconnection.port; % port

    
%% Query Options and Store Options in IB

 localsymbol = info.ammo.opentrades(i).localSymbol; % hard code local symbol

 data_option = IBMatlab('action','query','localsymbol',localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
  % error handle
  if isempty(data_option) % empty data – try to re-request the same data
      [data_option, ibConnectionObject] = IBMatlab('action','query','localsymbol',localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % option query
  end
  if isempty(data_option) % still empty data – try to disconnect/reconnect
      ibConnectionObject.disconnectFromTWS; % disconnect from IB
      pause(1); % let IB cool down a bit
      data_option = IBMatlab('action','query','localsymbol',localsymbol,'secType','OPT','ClientID',clientid,'Port',port); % will automatically reconnect
  end
 
%% Store Current Option Info      
      info.ib.opentrades(i).current_option = data_option; % store full verison in ib
      info.ammo.opentrades(i).current_option = data_option; % store full version in ammo
                
       % store comp fields for ammo / also defines what comp field is in
       % preference order; reversed to overwrite .Comp field
                  
%% Bring Price, IV, and Greeks Forward
if ((ge(info.ammo.opentrades(i).position,1)) && (strcmp(info.ammo.opentrades(i).right,'C'))) % if long call
    
             if(isfield(data_option,'bidOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.bidOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.bidOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = data_option.bidOptComp.delta;
                    info.ammo.opentrades(i).pos = data_option.bidOptComp.delta;
                    info.ammo.opentrades(i).gamma = data_option.bidOptComp.gamma;
                    info.ammo.opentrades(i).theta = data_option.bidOptComp.theta;
                    info.ammo.opentrades(i).vega = data_option.bidOptComp.vega;
       
             elseif(isfield(data_option,'askOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.askOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.askOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = data_option.askOptComp.delta;
                    info.ammo.opentrades(i).pos = data_option.askOptComp.delta;
                    info.ammo.opentrades(i).gamma = data_option.askOptComp.gamma;
                    info.ammo.opentrades(i).theta = data_option.askOptComp.theta;
                    info.ammo.opentrades(i).vega = data_option.askOptComp.vega;
      
             elseif(isfield(data_option,'lastOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.lastOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.lastOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = data_option.lastOptComp.delta;
                    info.ammo.opentrades(i).pos = data_option.lastOptComp.delta;
                    info.ammo.opentrades(i).gamma = data_option.lastOptComp.gamma;
                    info.ammo.opentrades(i).theta = data_option.lastOptComp.theta;
                    info.ammo.opentrades(i).vega = data_option.lastOptComp.vega;
                    
             elseif(isfield(data_option,'modelOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.modelOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.modelOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = data_option.modelOptComp.delta;
                    info.ammo.opentrades(i).pos = data_option.modelOptComp.delta;
                    info.ammo.opentrades(i).gamma = data_option.modelOptComp.gamma;
                    info.ammo.opentrades(i).theta = data_option.modelOptComp.theta;
                    info.ammo.opentrades(i).vega = data_option.modelOptComp.vega;
                  
             else
                    info.ammo.opentrades(i).optPrice = 999;  
                    info.ammo.opentrades(i).impliedVol = 999;
                    info.ammo.opentrades(i).delta = 999;
                    info.ammo.opentrades(i).pos = 999;
                    info.ammo.opentrades(i).gamma = 999;
                    info.ammo.opentrades(i).theta = 999;
                    info.ammo.opentrades(i).vega = 999;
             end 

elseif ((le(info.ammo.opentrades(i).position, -1)) && (strcmp(info.ammo.opentrades(i).right,'C'))) % if short call

              if(isfield(data_option,'bidOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.bidOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.bidOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = -(data_option.bidOptComp.delta);
                    info.ammo.opentrades(i).pos = (1 - data_option.bidOptComp.delta);
                    info.ammo.opentrades(i).gamma = -(data_option.bidOptComp.gamma);
                    info.ammo.opentrades(i).theta = -(data_option.bidOptComp.theta); % switch sign
                    info.ammo.opentrades(i).vega = -(data_option.bidOptComp.vega);
       
             elseif(isfield(data_option,'askOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.askOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.askOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = -(data_option.askOptComp.delta);
                    info.ammo.opentrades(i).pos = (1 - data_option.askOptComp.delta);
                    info.ammo.opentrades(i).gamma = -(data_option.askOptComp.gamma);
                    info.ammo.opentrades(i).theta = -(data_option.askOptComp.theta);
                    info.ammo.opentrades(i).vega = -(data_option.askOptComp.vega);
      
             elseif(isfield(data_option,'lastOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.lastOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.lastOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = -(data_option.lastOptComp.delta);
                    info.ammo.opentrades(i).pos = (1 - data_option.lastOptComp.delta);
                    info.ammo.opentrades(i).gamma = -(data_option.lastOptComp.gamma);
                    info.ammo.opentrades(i).theta = -(data_option.lastOptComp.theta);
                    info.ammo.opentrades(i).vega = -(data_option.lastOptComp.vega);
                    
             elseif(isfield(data_option,'modelOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.modelOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.modelOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = -(data_option.modelOptComp.delta);
                    info.ammo.opentrades(i).pos = (1 - data_option.modelOptComp.delta);
                    info.ammo.opentrades(i).gamma = -(data_option.modelOptComp.gamma);
                    info.ammo.opentrades(i).theta = -(data_option.modelOptComp.theta);
                    info.ammo.opentrades(i).vega = -(data_option.modelOptComp.vega);
                  
             else
                    info.ammo.opentrades(i).optPrice = 999;  
                    info.ammo.opentrades(i).impliedVol = 999;
                    info.ammo.opentrades(i).delta = 999;
                    info.ammo.opentrades(i).pos = 999;
                    info.ammo.opentrades(i).gamma = 999;
                    info.ammo.opentrades(i).theta = 999;
                    info.ammo.opentrades(i).vega = 999;
              end 
    
elseif ((ge(info.ammo.opentrades(i).position,1)) && (strcmp(info.ammo.opentrades(i).right,'P'))) % if long put
    
             if(isfield(data_option,'bidOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.bidOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.bidOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = data_option.bidOptComp.delta;
                    info.ammo.opentrades(i).pos = -(data_option.bidOptComp.delta); % put in positive terms
                    info.ammo.opentrades(i).gamma = data_option.bidOptComp.gamma;
                    info.ammo.opentrades(i).theta = data_option.bidOptComp.theta;
                    info.ammo.opentrades(i).vega = data_option.bidOptComp.vega;
       
             elseif(isfield(data_option,'askOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.askOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.askOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = data_option.askOptComp.delta;
                    info.ammo.opentrades(i).pos = -(data_option.askOptComp.delta); % put in positive terms
                    info.ammo.opentrades(i).gamma = data_option.askOptComp.gamma;
                    info.ammo.opentrades(i).theta = data_option.askOptComp.theta;
                    info.ammo.opentrades(i).vega = data_option.askOptComp.vega;
      
             elseif(isfield(data_option,'lastOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.lastOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.lastOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = data_option.lastOptComp.delta;
                    info.ammo.opentrades(i).pos = -(data_option.lastOptComp.delta); % put in positive terms
                    info.ammo.opentrades(i).gamma = data_option.lastOptComp.gamma;
                    info.ammo.opentrades(i).theta = data_option.lastOptComp.theta;
                    info.ammo.opentrades(i).vega = data_option.lastOptComp.vega;
                    
             elseif(isfield(data_option,'modelOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.modelOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.modelOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = data_option.modelOptComp.delta;
                    info.ammo.opentrades(i).pos = -(data_option.modelOptComp.delta); % put in positive terms
                    info.ammo.opentrades(i).gamma = data_option.modelOptComp.gamma;
                    info.ammo.opentrades(i).theta = data_option.modelOptComp.theta;
                    info.ammo.opentrades(i).vega = data_option.modelOptComp.vega;
                  
             else
                    info.ammo.opentrades(i).optPrice = 999;  
                    info.ammo.opentrades(i).impliedVol = 999;
                    info.ammo.opentrades(i).delta = 999;
                    info.ammo.opentrades(i).pos = 999;
                    info.ammo.opentrades(i).gamma = 999;
                    info.ammo.opentrades(i).theta = 999;
                    info.ammo.opentrades(i).vega = 999;
             end
             
elseif ((le(info.ammo.opentrades(i).position,-1)) && (strcmp(info.ammo.opentrades(i).right,'P'))) % if short call

              if(isfield(data_option,'bidOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.bidOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.bidOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = -(data_option.bidOptComp.delta); % switch sign
                    info.ammo.opentrades(i).pos = (1 - abs(data_option.bidOptComp.delta));
                    info.ammo.opentrades(i).gamma = -(data_option.bidOptComp.gamma);
                    info.ammo.opentrades(i).theta = -(data_option.bidOptComp.theta); % switch sign
                    info.ammo.opentrades(i).vega = -(data_option.bidOptComp.vega);
       
             elseif(isfield(data_option,'askOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.askOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.askOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = -(data_option.askOptComp.delta);
                    info.ammo.opentrades(i).pos = (1 - abs(data_option.askOptComp.delta));
                    info.ammo.opentrades(i).gamma = -(data_option.askOptComp.gamma);
                    info.ammo.opentrades(i).theta = -(data_option.askOptComp.theta);
                    info.ammo.opentrades(i).vega = -(data_option.askOptComp.vega);
      
             elseif(isfield(data_option,'lastOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.lastOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.lastOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = -(data_option.lastOptComp.delta);
                    info.ammo.opentrades(i).pos = (1 - abs(data_option.lastOptComp.delta));
                    info.ammo.opentrades(i).gamma = -(data_option.lastOptComp.gamma);
                    info.ammo.opentrades(i).theta = -(data_option.lastOptComp.theta);
                    info.ammo.opentrades(i).vega = -(data_option.lastOptComp.vega);
                    
             elseif(isfield(data_option,'modelOptComp'))
                    info.ammo.opentrades(i).optPrice = data_option.modelOptComp.optPrice;  
                    info.ammo.opentrades(i).impliedVol = data_option.modelOptComp.impliedVol;
                    info.ammo.opentrades(i).delta = -(data_option.modelOptComp.delta);
                    info.ammo.opentrades(i).pos = (1 - abs(data_option.modelOptComp.delta));
                    info.ammo.opentrades(i).gamma = -(data_option.modelOptComp.gamma);
                    info.ammo.opentrades(i).theta = -(data_option.modelOptComp.theta);
                    info.ammo.opentrades(i).vega = -(data_option.modelOptComp.vega);
                  
             else
                    info.ammo.opentrades(i).optPrice = 999;  
                    info.ammo.opentrades(i).impliedVol = 999;
                    info.ammo.opentrades(i).delta = 999;
                    info.ammo.opentrades(i).pos = 999;
                    info.ammo.opentrades(i).gamma = 999;
                    info.ammo.opentrades(i).theta = 999;
                    info.ammo.opentrades(i).vega = 999;
              end 
end

end