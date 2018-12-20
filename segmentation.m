function segmentated_image = segmentation(image)
%white_balance - white balacing for image
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

    img = rgb2gray(image);

    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    BW = imcomplement(imbinarize(R) & imbinarize(G) & imbinarize(B));
    subplot(NROWS, NCOLUMNS, 2), imshow(BW), title("Binarized image");
    
    edge2 = edge(img, 'Canny', 0.2);
    BW = BW | edge2;
    subplot(NROWS, NCOLUMNS, 3), imshow(BW), title("BW edge");

    %morphology
    SE = [0 1 0; 1 1 1; 0 1 0];
    morph = imdilate(BW, SE);
    morph = imdilate(morph, SE);
    morph = imdilate(morph, SE);
    subplot(NROWS, NCOLUMNS, 4), imshow(morph), title("Morph dilatation");
    morph = imfill(morph, 'holes');
    subplot(NROWS, NCOLUMNS, 5), imshow(morph), title("Morph holes");
    morph = bwareaopen(morph, 2000);
    subplot(NROWS, NCOLUMNS, 6), imshow(morph), title("Morph opening");
    
    segmentated_image = morph;

%------------- END OF CODE --------------