function normalized_central_moment_m_n = normalized_center_moment(m, n, image)
%normalized_center_moment - computes normalized center moment of order m, n
%
%
% Inputs:
%    (m, n) - order of normalized center moment calculation
%    image - image to calculate normalized central moment on
%    
% Outputs:
%    normalized_central_moment_m_n - normalized center moment of order m, n
% 
%------------- BEGIN CODE --------------
    close all
    
    % alpha factor
    alpha = (m + n)/2 + 1;
    
    % calculating normalized moment of order m,n
    normalized_central_moment_m_n = moment(m, n, image, 'central') / (moment(0, 0, image)^alpha);
    
end
%------------- END OF CODE --------------