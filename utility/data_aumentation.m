im = imread('dataset/0508.JPG');

COUNTER = 508;

for angle = 5 : 5 : 360 
    imr = imrotate(im, angle);
    
    if(COUNTER < 10)
       filename = ['000' num2str(COUNTER)];
   elseif(COUNTER < 100)
       filename = ['00' num2str(COUNTER)];
   elseif(COUNTER < 1000)
       filename = ['0' num2str(COUNTER)];
   else
       filename = num2str(COUNTER);
    end
   
   COUNTER = COUNTER + 1;
   
   imwrite(imr, [ 'tmp/' filename '.JPG']);
end