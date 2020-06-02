function[info] = write_historical_trades_js(info)

% Have to put some kind of trade id in here
%File Name
filename = 'C:/inetpub/ammoroot/js/historicaltrades_test.js';

% This is where you put php's actual text to be printed
js_historical_text = 'jstext';

%Print Text
fid = fopen(filename,'w'); 
fprintf(fid,js_historical_text);
fclose(fid);

info.web_historical.js_historical.js_historical_text = js_historical_text;


end