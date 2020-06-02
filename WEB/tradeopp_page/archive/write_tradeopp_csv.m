function[info] = write_tradeopp_csv(info)

%File Name
filename = 'C:/inetpub/ammoroot/datagrab/tradeopp_test.csv';

%Print Values
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end