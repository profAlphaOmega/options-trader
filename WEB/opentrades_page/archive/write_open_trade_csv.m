function[info] = write_open_trade_csv(info)

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/open_trade_test.csv';

%Print Values
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end