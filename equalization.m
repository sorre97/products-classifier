clear all
close all

% loads photos, equalizes them and renames according to counter
d = uigetdir(pwd, 'tmp');
files = dir(fullfile(d, '*.png'));

COUNTER = 1;
END = numel(files);

for i = 1 : END
   image = files(i);
   im = im2double(imread([image.folder '/' image.name]));
   
   ROIHSV = rgb2hsv(im);
   ROIHSV(:, :, 3) = imadjust(ROIHSV(:, :, 3));
   ROI = hsv2rgb(ROIHSV);
   
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
   
   imwrite(ROI, [ 'dataset/' filename '.png']);
   fprintf("%d\n", i);
   %imwrite(im, [ 'dataset/' filename '.png']);
end