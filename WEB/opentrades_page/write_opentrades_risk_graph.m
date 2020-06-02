function[info] = write_open_trade_risk_graph(info)

%Parse out risk array 

%File Name
filename = 'C:/Users/Zato/Desktop/trade.csv';

%Inputs
short_strike = 45;
long_strike = 40;
short_credit = 3;
long_debit = 1;
current_strike = 42.5;

%Parameters
break_even = short_strike - (short_credit - long_debit);
max_profit = (short_credit - long_debit);
max_loss = -((short_strike - long_strike) - (short_credit - long_debit)); % - (width of the strikes - net credit)

%Write Headers
        fid = fopen(filename,'w'); 
        fprintf(fid,'strike,pl,current_strike,current_pl\n');
        fclose(fid);

%Build Arrays
    for i = 1:((short_strike - long_strike) + 1)
        try
            if i == 1
                risk_array(i,:) = [long_strike,max_loss];
            else
                risk_array(i,:) = [(long_strike + i-1),(((long_strike + (i-1)) - long_strike) + max_loss)];    
            end
        catch ME
        end
    end

risk_array(:,2) = risk_array(:,2) * 100;

%Create current profit/loss value vectors to the arrray
risk_array(1,3) = current_strike;
risk_array(1,4) = ((current_strike - long_strike) + max_loss)*100;

%Print
length = risk_array(:,1);   
        i=0;
        for i =  1:size(length+1,1)
            try
                fid = fopen(filename,'a');
                if(fid ~= -1)
                    fprintf(fid,'%f,%f,%f,%f\n',risk_array(i,1),risk_array(i,2),risk_array(i,3),risk_array(i,4));
                end
                fclose(fid);
            catch ME
            end
        end
        fclose all
end