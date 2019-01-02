% loads photos, white balances them and renames according to counter
d = uigetdir(pwd, 'tmp');
files = dir(fullfile(d, '*.JPG'));

COUNTER = 306;
for i = 1 : numel(files)
   image = files(i);
   im = imread([image.folder '/' image.name]);
   
   imw = white_balance(im);
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
   
   imwrite(imw, [image.folder '/' filename '.JPG']);
end
