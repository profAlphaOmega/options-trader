function [] = write_strat_csv()


%Write headers for master.csv file
cd C:/Users/Zato/Desktop/AMMO/vault/strat_output;
file_runfile = [run_start_time '_strat_master.csv'];
fid = fopen(file_runfile,'w');
fprintf(fid,'counter,run_type,run_start_time,ticker,sell_put,sell_call,date,open,high,low,close,volume,adjusted_close,support,resistance,ma_c,ma_cc,ma_iii,ma_oscillator,ma_tslope,bb_percent_b,macd_line,fast_macd,macd_histogram,so_slowpctk,aroon_oscillator,aroon_trend\n');
fclose(fid);

%Change Path to printing directory

%%%Have to change a lot of vars in here, change to info structure
cd C:/Users/Zato/Desktop/AMMO/vault/strat_output;
length = ul{:,7};
i=0;
for i =  1:size(length+1,1)
  try
  fid = fopen(file_runfile,'a');
   if(fid ~= -1)
   fprintf(fid,'%f,%s,%s,%s,%f,%f,%s,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',pkey(i,1),run_type,run_start_time,ticker,sell_put(i,1),sell_call(i,1),ul{1,1}{i,1},ul{1,2}(i,1),ul{1,3}(i,1),ul{1,4}(i,1),ul{1,5}(i,1),ul{1,6}(i,1),ul{1,7}(i,1),support(i,1),resistance(i,1),ma_c(i,1),ma_cc(i,1),ma_iii(i,1),ma_oscillator(i,1),ma_tslope(i,1),bb_percentb(i,1),macdline(i,1),macd_fast(i,1),macd_histogram(i,1),so_fastpctd(i,1),aroon_oscillator(i,1),aroon_trend(i,1));
   end
  fclose(fid);
  catch ME
  end
end


end