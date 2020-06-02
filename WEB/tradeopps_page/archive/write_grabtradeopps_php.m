function[] = write_grabtradeopps_php()

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/grabtradeopps_test.php';

%Print Home Page File
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end
