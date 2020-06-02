function [] = nanscrub()

 %NaN Scrub
   row = isnan('var');
   'var'(row) = {[]};
   
end