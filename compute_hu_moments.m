function hu_moments_vector = compute_hu_moments(image)
%compute_hu_moments - computes hu moment features
%
%
% Inputs:
%    image - image to compute hu
%    
% Outputs:
%    hu_moments_vector - hu moment features vector
%
%------------- BEGIN CODE --------------
    close all
    
    im = im2double(image);
    
   % calculating normalized center moments used by Hu
    V20 = normalized_center_moment(2, 0, im);
    V02 = normalized_center_moment(0, 2, im);
    V11 = normalized_center_moment(1, 1, im);
    V30 = normalized_center_moment(3, 0, im);
    V12 = normalized_center_moment(1, 2, im);
    V03 = normalized_center_moment(0, 3, im);
    V21 = normalized_center_moment(2, 1, im);
    
    % calculating hu moments
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
    
    % output hu moments vector
    hu_moments_vector = [h1 h2 h3 h4 h5 h6 h7]';
    
    fprintf("Hu moments:\n");
    fprintf("%4s %f\n", 'h1: ', h1);
    fprintf("%4s %f\n", 'h2: ', h2);
    fprintf("%4s %f\n", 'h3: ', h3);
    fprintf("%4s %f\n", 'h4: ', h4);
    fprintf("%4s %f\n", 'h5: ', h5);
    fprintf("%4s %f\n", 'h6: ', h6);
    fprintf("%4s %f\n", 'h7: ', h7);
    
end
%------------- END OF CODE --------------