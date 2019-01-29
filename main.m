function products = main(filename, verbose)

    products = [];
    
    if(exist('verbose', 'var') && strcmp(verbose, 'verbose'))
        verbose = true;
        NROWS = 3;
        NCOLUMNS = 3;
        NFIGURE = 0;
    else
        verbose = false;
    end
    
    %% intro
    % original image
    image = im2double(imread(['test/' filename]));
    
    if(verbose)
        figure(1), NFIGURE = NFIGURE + 1;
        subplot(NROWS, NCOLUMNS, NFIGURE), imshow(image), title("Original image");
    end
    %% white balancing
    im = white_balance(image);
    %im = image;
    %im(:, :, 1) = imadjust(im(:, :, 1));
    %im(:, :, 2) = imadjust(im(:, :, 2));
    %im(:, :, 3) = imadjust(im(:, :, 3));
    if(verbose)
        figure(1), NFIGURE = NFIGURE + 1;
        subplot(NROWS, NCOLUMNS, NFIGURE), imshow(im), title("White balanced image");
    end
    
    %% binarization
    %im = imfilter(im, fspecial('average')); %smoothing
    im = imgaussfilt(im);
    BW = segmentation(im, verbose);
    if(verbose)
        figure(1), NFIGURE = NFIGURE + 1;
        subplot(NROWS, NCOLUMNS, NFIGURE), imshow(BW), title("Segmentated image");
    end

    %% labelling
    [labels, n_labels] = bwlabel(BW);
    if(verbose)
        figure(1), NFIGURE = NFIGURE + 1;
        subplot(NROWS, NCOLUMNS, NFIGURE), imagesc(labels), axis image, colorbar, title("labelling");
    end
    
    %% mask application
    if(verbose)
        figure(1), NFIGURE = NFIGURE + 1;
        subplot(NROWS, NCOLUMNS, NFIGURE), imshow(BW .* image), title("Mask over original image");
    end
    
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
        % figure, imshow(ROI), title("ROI");

        % macro classification
        object_label = macro_classification(ROI);
        products = [products; object_label];

        % macro labelling
        if(i == 1)
            if(verbose)
                NFIGURE = NFIGURE + 1;
            end
                labelled_image = image;
        end
        labelled_image = insertText(labelled_image, center, object_label, ...
            'FontSize', 20, 'BoxColor', 'white', 'AnchorPoint', 'Center');
        if(verbose)
            figure(1),
            subplot(NROWS, NCOLUMNS, NFIGURE), imshow(labelled_image), title('Labelled image');
    
        end
    end


    %% bounding box
    %answer = questdlg('Plot bounding box?', ...
    % 	'bounding box', ...
    % 	'Yes','Nope','Yes');
    answer = 'Yes';
    % Handle response
    switch answer
        case 'Yes'
            if(verbose)
                figure(1), NFIGURE = NFIGURE + 1;
                subplot(NROWS, NCOLUMNS, NFIGURE), imshow(labelled_image), title("Bounding box image");
            
                drawBoundingBox(BW);
                
                figure,
                imshow(labelled_image);
            end
    end

    %% print shoplist
    total = 0;
    if(verbose)
        fprintf("%19s\n", "Product Classifier");
        fprintf("%15s\n", "SCONTRINO");
    end
    for i = 1 : numel(products)
        current_price = object_price(products(i));
        if(current_price ~= 0 && verbose)
            fprintf("%-13s %.2f%c\n", char(products(i)), current_price, '€');
        end
        total = total + current_price;
    end
    if(verbose)
        fprintf("%-13s %.2f%c\n","TOTALE" , total, '€');
    end

end