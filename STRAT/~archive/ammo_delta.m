function [] = ammo_delta()

stock_price = 204;
call_strike_price = 220;
put_strike_price = 220;
%Use IV at the ATM option K
call_IV = .40;
put_IV = .40;
T = 45/365;
r = .0004;

call_delta = normcdf(((log(stock_price/call_strike_price)) + ((r + ((call_IV^2)/2)) * T)) / (call_IV * sqrt(T)));
put_delta = -1 * (1 - normcdf(((log(stock_price/put_strike_price)) + ((r + ((put_IV^2)/2)) * T)) / (put_IV * sqrt(T)))); 

end
