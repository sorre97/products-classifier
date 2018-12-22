clear all
close all

NROWS = 3;
NCOLUMNS = 3;
NFIGURE = 0;

%% intro
% original image
image = im2double(imread('test/0025.JPG'));
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

%% mask application
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imshow(BW .* image), title("Mask over original image");

%% classification
% for each connected component
for i = 1 : (n_labels - 1)
    % extracting region of interest
    % current label mask
    current_label = (labels == i);
    
    % finding current mask boundaries
    [rows, columns] = find(labels == i);
    topRow = min(rows);
    bottomRow = max(rows);
    leftColumn = min(columns);
    rightColumn = max(columns);
    
    % extracting single object with mask
    object = im .* (current_label);
    objectR = object(:, :, 1);
    objectG = object(:, :, 2);
    objectB = object(:, :, 3);
    
    % cropping region of interest
    ROI = zeros(bottomRow - topRow + 1, rightColumn - leftColumn + 1);
    ROI(:, :, 1) = objectR(topRow:bottomRow, leftColumn:rightColumn);
    ROI(:, :, 2) = objectG(topRow:bottomRow, leftColumn:rightColumn);
    ROI(:, :, 3) = objectB(topRow:bottomRow, leftColumn:rightColumn);
    
    figure(1), NFIGURE = NFIGURE + 1;
    subplot(NROWS, NCOLUMNS, NFIGURE), imshow(ROI), title("ROI");
    
    %% TODO
    % Stiamo passando un singolo oggetto al macro_classificatore (bevanda, pasta...)
    % che risponde con una label associata.
    % Bisogna prima di tutto trainare il classificatore
    % nei relativi file (test_classifier e train_classifier)
    % sentitevi liberi di cambiare i nomi di queste due funzioni 
    % perchè non mi piacciono ma non ho trovato di meglio
    
    object_label = macro_classification(ROI);
end
