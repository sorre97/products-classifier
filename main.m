clear all
close all

NROWS = 2;
NCOLUMNS = 3;

figure
%original image
image = im2double(imread('0011.JPG'));
subplot(2, 3, 1), imshow(image), title("Original image");

%white balancing
im = white_balance(image);
subplot(NROWS, NCOLUMNS, 2), imshow(im), title("White balanced image");

%binarization
BW = segmentation(im);