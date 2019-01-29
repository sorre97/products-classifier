COUNTER = 1139;
END = 1192;
for i = COUNTER : END
    
   if(COUNTER < 10)
       fprintf("%s\n",['000' num2str(COUNTER) '.png']);
   elseif(COUNTER < 100)
       fprintf("%s\n",['00' num2str(COUNTER) '.png']);
   elseif(COUNTER < 1000)
       fprintf("%s\n",['0' num2str(COUNTER) '.png']);
   else
       fprintf("%s\n",[num2str(COUNTER) '.png']);
   end
   
   COUNTER = COUNTER + 1;
   
end
