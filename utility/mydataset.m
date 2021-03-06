clear all
close all

% loads photos, white balances them and renames according to counter
d = uigetdir(pwd, 'tmp');
files = dir(fullfile(d, '*.JPG'));
%files = dir(fullfile(d, '*.png'));

COUNTER = 1139;
END = numel(files);
SCALE = 0.25;

for i = 1 : END
   image = files(i);
   im = im2double(imread([image.folder '/' image.name]));
   
   BW = segmentation(im);
   %BW = imopen(imfill(~imbinarize(rgb2gray(im)), 'holes'), strel('disk', 9));
   
   % finding current mask boundaries
   [rows, columns] = find(BW);
   topRow = min(rows);
   bottomRow = max(rows);
   leftColumn = min(columns);
   rightColumn = max(columns);
   
   % object
   object = BW .* im;
   objectR = object(:, :, 1);
   objectG = object(:, :, 2);
   objectB = object(:, :, 3);
   %figure, imshow(object);
   
   % cropping region of interest
   ROI = zeros(bottomRow - topRow + 1, rightColumn - leftColumn + 1);
   ROI(:, :, 1) = objectR(topRow:bottomRow, leftColumn:rightColumn);
   ROI(:, :, 2) = objectG(topRow:bottomRow, leftColumn:rightColumn);
   ROI(:, :, 3) = objectB(topRow:bottomRow, leftColumn:rightColumn);
   %figure(1), imshow(ROI);
   
   %imw = imresize(im, SCALE);
   %imw = rgb2gray(im); 
   
   %ROI = imresize(ROI, SCALE);
   
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
   %imwrite(im, [ 'dataset/' filename '.png']);
end
