function[info] = write_open_trades_csv(info)

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/open_trades_test.csv';

%Print Values
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end