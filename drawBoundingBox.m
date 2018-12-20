function  drawBoundingBox(BW)
%drawBoundingBOx - drawsBoundingBox on original image
%
%
% Inputs:
%    BW - binary image
%    
% Outputs:
%    - 
%
%
%------------- BEGIN CODE --------------
NROWS = 2;
NCOLUMNS = 3;

    figure(1), subplot(NROWS, NCOLUMNS, 1);
    boxes = regionprops(BW, 'BoundingBox');
    for i = 1 : length(boxes)
       point = boxes(i).BoundingBox;
       rectangle('Position', point, 'EdgeColor', 'r', 'LineWidth', 1);
    end
    
%------------- END OF CODE --------------