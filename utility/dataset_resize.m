% loads photos, white balances them and renames according to counter
d = uigetdir(pwd, 'tmp');
files = dir(fullfile(d, '*.JPG'));

COUNTER = 1;
END = numel(files);
SCALE = 0.25;

for i = 1 : END
   image = files(i);
   im = imread([image.folder '/' image.name]);
   %imw = white_balance(im);
   %imw = imresize(im, SCALE);
   imw = rgb2gray(im);
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
