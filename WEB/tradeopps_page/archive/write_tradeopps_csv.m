function[info] = write_tradeopps_csv(info)

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/tradeopps_test.csv';

%Print Values
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end