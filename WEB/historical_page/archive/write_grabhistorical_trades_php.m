function[] = write_grabhistorical_trades_php()

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/grabhistoricaltrades_test.php';

%Print Home Page File
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end
