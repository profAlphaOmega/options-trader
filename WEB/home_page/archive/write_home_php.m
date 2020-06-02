function[info] = write_home_php(info)

%File Name
filename = 'C:/inetpub/ammoroot/home_test.php';

% This is where you put php's actual text to be printed
php_home_text = 'phptext';

%Print Home Page File
fid = fopen(filename,'w'); 
fprintf(fid,php_home_text);
fclose(fid);

info.web_home.php_home.php_home_text = php_home_text;

end
