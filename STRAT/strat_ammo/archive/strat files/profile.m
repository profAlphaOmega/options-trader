function [abshigh abslow absmid laghigh laglow lagmid] = profile(ul)
%Stage     
   %cd C:/Users/Zato/Desktop/AMMO;

%Counter for size of array
         
        %Lag period variable
        lag = 60;

        %Matrix "A" for analysis       
        A=ul{1,5};
        
        abshigh = max(A);
        abslow = min(A);
        absmid = mean(A);
         
        %Matrix "B" for analysis
        B = ul{1,5}(1:lag,1);
        
        laghigh = max(B);
        laglow  = min(B);
        lagmid = mean(B);
                    
                
end
            
   
     