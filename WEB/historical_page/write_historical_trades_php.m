function[info] = write_historical_trades_php(info)

%File Name
filename = 'C:/inetpub/ammoroot/historicaltrades_test.php';

% This is where you put php's actual text to be printed
php_historical_text = 'phptext';

%Print Home Page File
fid = fopen(filename,'w'); 
fprintf(fid,php_historical_text);
fclose(fid);

info.web_historical.php_historical.php_historical_text = php_historical_text;

end
