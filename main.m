clear all
close all

NROWS = 3;
NCOLUMNS = 3;
NFIGURE = 0;

%% intro
% original image
image = im2double(imread('0025.JPG'));
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imshow(image), title("Original image");

%% white balancing
im = white_balance(image);
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imshow(im), title("White balanced image");

%% binarization
im = imfilter(im, fspecial('average')); %smoothing
BW = segmentation(im);
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imshow(BW), title("Segmentated image");

%% bounding box
%answer = questdlg('Plot bounding box?', ...
%	'bounding box', ...
%	'Yes','No', 'Yes');
answer = 'Yes';
if(answer == 'Yes')
    drawBoundingBox(BW);
end

%% labelling
[labels, n_labels] = bwlabel(BW);
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imagesc(labels), axis image, colorbar, title("labelling");

%% classification
for i = 1 : (n_labels - 1)
    % extracting region of interest
    current_label = (labels == i);
    [rows, columns] = find(labels == i);
    topRow = min(rows);
    bottomRow = max(rows);
    leftColumn = min(columns);
    rightColumn = max(columns);
    ROI = im .* (current_label);
    croppedImage = ROI(topRow:bottomRow, leftColumn:rightColumn);
    
    figure(1), NFIGURE = NFIGURE + 1;
    subplot(NROWS, NCOLUMNS, NFIGURE), imagesc(labels), axis image, colorbar, title("labelling"), imshow(croppedImage);
    %object = classification(ROI);
end

%% mask application
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imshow(BW .* image), title("Mask over original image");
