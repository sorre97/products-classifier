clear all
close all

NROWS = 3;
NCOLUMNS = 3;
NFIGURE = 0;

%% intro
% original image
image = im2double(imread('test/0015.JPG'));
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


%% labelling
[labels, n_labels] = bwlabel(BW);
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imagesc(labels), axis image, colorbar, title("labelling");

%% mask application
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imshow(BW .* image), title("Mask over original image");

%% macro classification
% for each connected component

for i = 1 : n_labels
    % extracting region of interest
    % current label mask
    current_label = (labels == i);
    
    % finding current mask boundaries
    [rows, columns] = find(labels == i);
    topRow = min(rows);
    bottomRow = max(rows);
    leftColumn = min(columns);
    rightColumn = max(columns);
    
    centroid = [((leftColumn + rightColumn)/2) ((topRow + bottomRow)/2)];
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
    
    
    object_label = macro_classification(ROI);
    image = insertText(image, centroid, char(object_label), ...
        'FontSize', 20, 'BoxColor', 'white', 'AnchorPoint', 'Center');
    
%% sub classification
%     if (object_label == 'drinks')
%         object_label = drink_classification(ROI);
%     end
    
    
end

drawBoundingBox(BW);
%% bounding box
% answer = questdlg('Plot bounding box?', ...
% 	'bounding box', ...
% 	'Yes','No','Yes');
% % answer = 'Yes';
% if(answer == 'Yes')
%     figure(3), imshow(image), title("Labelled image");
%     drawBoundingBox(BW);
% elseif(answer == 'No')
%     figure(3), imshow(image), title("Labelled image");
% end