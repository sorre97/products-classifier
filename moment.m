function moment_m_n = moment(m, n, image, mode)
%moment - computes moment of order m, n. Central moment if specified
%
%
% Inputs:
%    (m, n) - order of moment calculation
%    image - image to calculate moment on
%    
% Outputs:
%    moment_m_n - moment of order m, n. Central moment if specified
% 
%------------- BEGIN CODE --------------
    close all
    
    % checking if central moment or normal moment
    if(exist(mode))
       %baricenter coordinates for central moment
        ib = moment(1, 0, image) / moment(0, 0, image);
        jb = moment(0, 1, image) / moment(0, 0, image);
    else
        %normal moment calculation. No baricenter coordinates needed
        ib = 0;
        jb = 0;
    end
    
    [rows, columns, ~] = size(image);
    
    for i = 1 : rows
       for j = 1 : columns
          moment_m_n = moment_m_n + ((i - ib)^m * (j - jb)^n * image(i, j)); 
       end
    end
    
    
    
    
end
%------------- END OF CODE --------------