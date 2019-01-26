function segmentated_image = segmentation(image, print)
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
if(exist('print', 'var') && strcmp(print, 'verbose'))
    verbose = true;
    NROWS = 3;
    NCOLUMNS = 3;
    figure(2)
else
    verbose = false;
end

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
    if(verbose)
        subplot(NROWS, NCOLUMNS, 1), imshow(BW), title("Binarized image");
    end
    
    %% Edge
    % Edge extraction using Canny method
    edge2 = edge(img, 'Canny', 0.1);
    %edge2 = edge(img, 'Canny', 0.05);
    if(verbose)
        subplot(NROWS, NCOLUMNS, 2), imshow(edge2), title("Edges");
    end
    
    
    % adding edges to better delimit objects
    BW = BW | edge2;
    
    % removing borders to avoid edge on corners
    BWsize = size(BW);
    BW2 = zeros(BWsize);
    BW2(3: BWsize(1) - 3, 3: BWsize(2) - 3) = BW(3: BWsize(1) - 3, 3: BWsize(2) - 3);
    BW = BW2;
    if(verbose)
        subplot(NROWS, NCOLUMNS, 3), imshow(BW), title("BW edge");
    end
    
    
    %% morphology
    
    % ALTERNATIVE
    % dilatation and erosion to connect borders
    % structuring element
    %SE = strel('square', 8);
    %morph = imclose(BW, SE);
    
    SE = strel('disk', 3);

    % dilatation to close object borders
    %morph = bwareaopen(BW, 4000);
    morph = imdilate(BW, SE);
    if(verbose)
        subplot(NROWS, NCOLUMNS, 4), imshow(morph), title("Morph dilatation");
    end
    
    % hole filling
    morph = imfill(morph, 'holes');
    if(verbose)
        subplot(NROWS, NCOLUMNS, 5), imshow(morph), title("Morph holes");
    end
    
    % opening to filter small imperfections from dilatation
    morph = bwareaopen(morph, 1000);
    if(verbose)
        subplot(NROWS, NCOLUMNS, 6), imshow(morph), title("Morph opening");
    end
    
    % paper line filtering with erosion
    % touching objects handling
    morph = imerode(morph, SE);
    morph = imerode(morph, SE);
    morph = imerode(morph, SE);
    morph = imerode(morph, SE);
    morph = imerode(morph, SE);
    
    if(verbose)
        subplot(NROWS, NCOLUMNS, 7), imshow(morph), title("Morph erosion");
    end
    
    morph = imdilate(morph, SE);
    morph = imdilate(morph, SE);
    morph = imdilate(morph, SE);
    if(verbose)
        subplot(NROWS, NCOLUMNS, 8), imshow(morph), title("Morph dilatation");
    end
    
    %% separating touching objects
    
    % calculating euclidean distance of not morph
    D = -bwdist(imcomplement(morph));
    %figure, imshow(D,[]);
    
    % applying a mask based on extended minima transform
    % (increment the second parameter to avoid the segmentation 
    % between the object)
    mask = imextendedmin(D,10);
    %figure, imshow(mask);
    
    % modifying distance image so it only has regional minima 
    % wherever binary marker image BW is nonzero. (?)
    D2 = imimposemin(D,mask);
    
    % applying watershed transform in order to segment the image
    Ld2 = watershed(D2);
    %figure, imshow(label2rgb(Ld2));
    finalImage = morph;
    finalImage(Ld2 == 0) = 0;
    
    if(verbose)
        subplot(NROWS, NCOLUMNS, 9), imshow(finalImage), title("Separating touching objects");
    end
    
    %% end
    segmentated_image = finalImage;
%------------- END OF CODE --------------