function[] = write_home_js()

%File Name
filename = 'C:/inetpub/ammoroot/js/home_test.js';

%Print Text
fid = fopen(filename,'w'); 
        fprintf(fid,'');
        fclose(fid);

end