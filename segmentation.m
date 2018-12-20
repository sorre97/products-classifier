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
    img = imcomplement(rgb2gray(image));
    SE = strel('disk',60);
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
    
    %% Edge extraction
    % extracting edge with Canny method
    edge2 = edge(img, 'Canny', 0.1);
    subplot(NROWS, NCOLUMNS, 2), imshow(edge2), title("Edges");
    
    % adding edges to better delimit objects
    BW = BW | edge2;
    subplot(NROWS, NCOLUMNS, 3), imshow(BW), title("BW edge");

    %% morphology
    % structuring elemnt
    SE = strel('disk', 3);
    
    % dilatation to close object borders
    morph = imdilate(BW, SE);
    
    % ALTERNATIVE
    % dilatation and erosion to connect borders
    %SE = strel('disk', 6);
    %morph = imclose(BW, SE);
    
    subplot(NROWS, NCOLUMNS, 4), imshow(morph), title("Morph dilatation");
    
    % hole filling
    morph = imfill(morph, 'holes');
    subplot(NROWS, NCOLUMNS, 5), imshow(morph), title("Morph holes");
    
    % opening
    morph = bwareaopen(morph, 2000);
    subplot(NROWS, NCOLUMNS, 6), imshow(morph), title("Morph opening");
    
    %% end
    segmentated_image = morph;
%------------- END OF CODE --------------