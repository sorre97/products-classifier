function segmentated_image = segmentation(image)
%segmentation - segmentation of image
%
%
% Inputs:
%    image - image to calculate segmentation
%    
% Outputs:
%    segmentated_image - segmentated image
%
%
%------------- BEGIN CODE --------------
NROWS = 2;
NCOLUMNS = 3;
    
    figure(2)
    img = rgb2gray(image);
    
    %% Binarization
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    
    % binarizing over RGB channels separately
    BW = imcomplement(imbinarize(R) & imbinarize(G) & imbinarize(B));
    subplot(NROWS, NCOLUMNS, 1), imshow(BW), title("Binarized image");
    BW = ~imbinarize(rgb2gray(image));
    
    % adding edget to delimit objects better
    edge2 = edge(img, 'Canny', 0.1);
    subplot(NROWS, NCOLUMNS, 2), imshow(edge2), title("Edges");
    
    BW = BW | edge2;
    subplot(NROWS, NCOLUMNS, 3), imshow(BW), title("BW edge");


    %% morphology
    % structuring elemnt
    SE = [0 1 0; 1 1 1; 0 1 0];
    
    %dilatation, 3 times 3x3 SE
    morph = imdilate(BW, SE);
    morph = imdilate(morph, SE);
    morph = imdilate(morph, SE);
    subplot(NROWS, NCOLUMNS, 4), imshow(morph), title("Morph dilatation");
    
    %hole filling
    morph = imfill(morph, 'holes');
    subplot(NROWS, NCOLUMNS, 5), imshow(morph), title("Morph holes");
    
    %opening
    morph = bwareaopen(morph, 2000);
    subplot(NROWS, NCOLUMNS, 6), imshow(morph), title("Morph opening");
    
    %% end
    segmentated_image = morph;
%------------- END OF CODE --------------