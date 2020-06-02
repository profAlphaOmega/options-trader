function[info] = write_home_csv(info)

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/home_test.csv';

%Print Values
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end