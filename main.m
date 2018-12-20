clear all
close all

NROWS = 2;
NCOLUMNS = 3;

%original image
image = im2double(imread('0011.JPG'));
figure(1), 
subplot(2, 3, 1), imshow(image), title("Original image");

%% white balancing
im = white_balance(image);
figure(1), 
subplot(NROWS, NCOLUMNS, 2), imshow(im), title("White balanced image");

%% binarization
BW = segmentation(im);
figure(1), 
subplot(NROWS, NCOLUMNS, 3), imshow(BW), title("Segmentated image");

%% bounding box
drawBoundingBox(BW);

%% labelling
[labels, n_labes] = bwlabel(BW);
figure(1), 
subplot(NROWS, NCOLUMNS, 4), imagesc(labels), axis image, colorbar, title("labelling");
