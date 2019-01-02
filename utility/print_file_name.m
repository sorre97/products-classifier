COUNTER = 1;
for i = 1 : 305
    
   if(COUNTER < 10)
       fprintf("%s\n",['000' num2str(COUNTER) '.JPG']);
   elseif(COUNTER < 100)
       fprintf("%s\n",['00' num2str(COUNTER) '.JPG']);
   elseif(COUNTER < 1000)
       fprintf("%s\n",['0' num2str(COUNTER) '.JPG']);
   else
       fprintf("%s\n",[num2str(COUNTER) '.JPG']);
   end
   
   COUNTER = COUNTER + 1;
   
end
