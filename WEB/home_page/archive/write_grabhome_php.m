function[] = write_grabhome_php()


% Have text save to a variable; then put into a structure to be saved in a file. for latter uses to grab that file you would scan it back into a structure showing tradeid's and data at that time(somehow scan the webpage for all the data cause it gets parsed out then) then you can store the file and reaccess it when wanted
%File Name
filename = 'C:/inetpub/ammoroot/datagrab/grabhome_test.php';

%Print Home Page File
fid = fopen(filename,'w'); 
fprintf(fid,'');
fclose(fid);

end
