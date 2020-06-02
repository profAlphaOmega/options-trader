function[info] = write_historical_trades_csv(info)

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/historical_trades_test.csv';

%Print Values
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end