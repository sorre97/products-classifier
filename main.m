clear all
close all

NROWS = 2;
NCOLUMNS = 3;

% original image
image = im2double(imread('0025.JPG'));
figure(1), 
subplot(2, 3, 1), imshow(image), title("Original image");

%% white balancing
im = white_balance(image);
figure(1), 
subplot(NROWS, NCOLUMNS, 2), imshow(im), title("White balanced image");

%% binarization
im = imfilter(im, fspecial('average')); %smoothing
BW = segmentation(im);
figure(1), 
subplot(NROWS, NCOLUMNS, 3), imshow(BW), title("Segmentated image");

%% bounding box
%answer = questdlg('Plot bounding box?', ...
%	'bounding box', ...
%	'Yes','No', 'Yes');
answer = 'Yes';
if(answer == 'Yes')
    drawBoundingBox(BW);
end

%% labelling
[labels, n_labes] = bwlabel(BW);
figure(1), 
subplot(NROWS, NCOLUMNS, 4), imagesc(labels), axis image, colorbar, title("labelling");

%% mask application
subplot(NROWS, NCOLUMNS, 5), imshow(BW .* image), title("Mask over original image");
