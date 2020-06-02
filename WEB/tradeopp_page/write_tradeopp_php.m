function[] = write_tradeopp_php()

%File Name
filename = 'C:/inetpub/ammoroot/tradeopp_test.php';

php_tradeopp_text = 'phptext';

%Print Home Page File
fid = fopen(filename,'w'); 
fprintf(fid,php_tradeopp_text);
fclose(fid);

info.web_tradeopp.php_tradeopp.php_tradeopp_text = php_tradeopp_text;

end
