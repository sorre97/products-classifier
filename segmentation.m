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
NROWS = 3;
NCOLUMNS = 3;
    
    figure(2)
    img = rgb2gray(image);
    
    %% Binarization
    
    % OLD - binarizing over RGB channels separately
    %{
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    
    BW = imcomplement(imbinarize(R) & imbinarize(G) & imbinarize(B));
    subplot(NROWS, NCOLUMNS, 1), imshow(BW), title("Binarized image");
    BW = ~imbinarize(img);
    %}
    
    % using morphological opening to extract background
    % using light gray colors for objects in order to use morphology 
    img = imcomplement(img);
    SE = strel('disk', 60);
    % extracting background with structure element
    background = imopen(img,SE);
    im2 = img - background;
    % adjusting histogram distribution with gamma correction
    im3 = imadjust(im2);
    % binarizing image
    BW = imbinarize(im3);
    % removing small imperfections from binarization
    BW = bwareaopen(BW,50);
    subplot(NROWS, NCOLUMNS, 1), imshow(BW), title("Binarized image");
    
    %% Edge
    % Edge extraction using Canny method
    edge2 = edge(img, 'Canny', 0.1);
    subplot(NROWS, NCOLUMNS, 2), imshow(edge2), title("Edges");
    
    
    % adding edges to better delimit objects
    BW = BW | edge2;
    %BW = padarray(BW, [3 3], 0, 'both');
    subplot(NROWS, NCOLUMNS, 3), imshow(BW), title("BW edge");
    
    
    %% morphology
    
    % ALTERNATIVE
    % dilatation and erosion to connect borders
    % structuring element
    %SE = strel('square', 8);
    %morph = imclose(BW, SE);
    
    SE = strel('disk', 3);
     
    % REPLACED BY HOUGH METHOD FOR EDGE LINKING
    % dilatation to close object borders
    morph = imdilate(BW, SE);
    subplot(NROWS, NCOLUMNS, 4), imshow(morph), title("Morph dilatation");
    
    % hole filling
    morph = imfill(morph, 'holes');
    subplot(NROWS, NCOLUMNS, 5), imshow(morph), title("Morph holes");
    
    % opening to filter small imperfections from dilatation
    morph = bwareaopen(morph, 2000);
    subplot(NROWS, NCOLUMNS, 6), imshow(morph), title("Morph opening");
    
    % paper line filtering with erosion
    % touching objects handling
    morph = imerode(morph, SE);
    morph = imerode(morph, SE);
    morph = imerode(morph, SE);
    subplot(NROWS, NCOLUMNS, 7), imshow(morph), title("Morph erosion");
    
    %% end
    segmentated_image = morph;
%------------- END OF CODE --------------