clear all
close all

NROWS = 3;
NCOLUMNS = 3;
NFIGURE = 0;

%% intro
% original image
image = im2double(imread('test/0102.JPG'));
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imshow(image), title("Original image");

%% white balancing
im = white_balance(image);
im = image;
figure(1), NFIGURE = NFIGURE + 1;
subplot(NROWS, NCOLUMNS, NFIGURE), imshow(im), title("White balanced image");

%% binarization
%im = imfilter(im, fspecial('average')); %smoothing
im = imgaussfilt(im);
BW = segmentation(im, 'verbose');
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
    center = [((leftColumn + rightColumn)/2) ((topRow + bottomRow)/2)];
    
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
    
    % individual ROI
    %figure, imshow(ROI), title("ROI");
    
    % macro classification
    object_label = macro_classification(ROI);
    
    % macro labelling
    if(i == 1)
        NFIGURE = NFIGURE + 1;
        labelled_image = image;
    end
    labelled_image = insertText(labelled_image, center, object_label, ...
        'FontSize', 20, 'BoxColor', 'white', 'AnchorPoint', 'Center');
    figure(1),
    subplot(NROWS, NCOLUMNS, NFIGURE), imshow(labelled_image), title('Labelled image');
    
%% sub classification
%     if (object_label == 'drinks')
%         object_label = drink_classification(ROI);
%     end 
end


%% bounding box
%answer = questdlg('Plot bounding box?', ...
% 	'bounding box', ...
% 	'Yes','Nope','Yes');
answer = 'Yes';
% Handle response
switch answer
    case 'Yes'
        figure(1), NFIGURE = NFIGURE + 1;
        subplot(NROWS, NCOLUMNS, NFIGURE), imshow(labelled_image), title("Bounding box image");
        drawBoundingBox(BW);
        figure,
        imshow(labelled_image);
end