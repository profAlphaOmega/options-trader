function [info] = ammo_pos(info)

%credit recieved has to be subtracted from strike price 

stock_price = 204;
call_strike_price = 220;
put_strike_price = 220;
%Use IV at the ATM option K
call_IV = .40;
put_IV = .40;
T = 45/365;

%does the put strike price need to be subtracted by the credit recieved or
%break even. Yes.

call_prob_ITM = normcdf((log(stock_price/call_strike_price))/(call_IV*sqrt(T)));
put_prob_ITM = 1 - normcdf((log(stock_price/put_strike_price))/(put_IV*sqrt(T)));

call_prob_OTM = 1 - call_prob_ITM;
put_prob_OTM = 1 - put_prob_ITM;  

end