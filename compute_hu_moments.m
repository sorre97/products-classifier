function hu_moments_vector = compute_hu_moments()
%compute_hu_moments - computes hu moment features
%
%
% Inputs:
%    - 
%    
% Outputs:
%    hu_moments_vector - hu moment features vector
%
%------------- BEGIN CODE --------------
    close all
    
    % initializing hu column feature vector
    hu_moments_vector = zeros(7, 1);
    
    V20 = normalized_center_moment(2, 0);
    V02 = normalized_center_moment(0, 2);
    V11 = normalized_center_moment(1, 1);
    V30 = normalized_center_moment(3, 0);
    V12 = normalized_center_moment(1, 2);
    V03 = normalized_center_moment(0, 3);
    V21 = normalized_center_moment(2, 1);
    
    h1 = V20 + V02;
    h2 = (V20 - V02)^2 + (4 * V11^2);
    h3 = (V30 - (3 * V12))^2 + (V03 - (3 * V21))^2;
    h4 = (V30 + V12)^2 + (V03 + V21)^2;
    h5 = (V30 - (3 * V12)) * (V30 + V12) * ((V30 + V12)^2 - (3 * (V03 + V21)^2)) + ...
        ((3 * V21) - V03) * (V03 + V21) * (3 * (V30 + V12)^2 - (V03 + V21)^2);
    h6 = (V20 - V02) * ((V30 + V12)^2 - (V03 + V21)^2) + (4 * V11 * (V30 + V12) * ...
        (V03 + V21));
    h7 = ((3 * V21) - V03) * (V30 + V12) * ((V30 + V12)^2 - (3 * (V03 + V21)^2)) + ...
        ((3 * V12) - V30) * (V03 + V21) * (3 * (V30 + V12)^2 - (V03 + V21)^2);
    
    hu_moments_vector = [h1 h2 h3 h4 h5 h6 h7]';
    
end
%------------- END OF CODE --------------