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
NROWS = 4;
NCOLUMNS = 3;

    figure(3),
    'hold on';
    boxes = regionprops(BW, 'BoundingBox');
    for i = 1 : length(boxes)
       points = boxes(i).BoundingBox;
       rectangle('Position', points, 'EdgeColor', 'r', 'LineWidth', 3);
    end
    'hold off';
    
%------------- END OF CODE --------------