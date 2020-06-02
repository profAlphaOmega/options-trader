function[] = write_grabopen_trade_php()

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/grab_open_trade_test.php';

%Print Home Page File
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end
