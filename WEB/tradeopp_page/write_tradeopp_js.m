function[info] = write_tradeopp_js(info)

%File Name
filename = 'C:/inetpub/ammoroot/js/tradeopp_test.js';

js_tradeopp_text = 'jstext';

%Print Text
fid = fopen(filename,'w'); 
fprintf(fid,js_tradeopp_text);
fclose(fid);

info.web_tradeopp.js_tradeopp.js_tradeopp_text = js_tradeopp_text;
        
end