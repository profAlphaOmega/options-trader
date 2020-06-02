function[] = write_grabopen_trades_php()

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/grabopentrades_test.php';

%Print Home Page File
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end
