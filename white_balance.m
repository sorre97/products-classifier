function balanced = white_balance(image)
%white_balance - white balacing for image
%
%
% Inputs:
%    image - image to color balance
%    
% Outputs:
%    balanced - image white balanced
%
%   Assumptions: uniform illumination
%
%------------- BEGIN CODE --------------
    
    % image is uint8
    if(isa(image, 'uint8'))
        %[L - 1] / 2 is the expected mean gray value (empirical value)
        GrayR = 128;
        GrayG = 128;
        GrayB = 128;
    %double image
    else
        GrayR = 0.5;
        GrayG = 0.5;
        GrayB = 0.5;
    end
    
    %extracting RGB channels
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    
    %calculating white balanced channel with multiplicative coefficient
    Kr = GrayR / mean(R(:));
    Ra = R .* Kr;
    
    Kg = GrayG / mean(G(:));
    Ga = G .* Kg;
    
    Kb = GrayB / mean(B(:));
    Ba = B .* Kb;
    
    %reconstructing output image
    balanced(:, :, 1) = Ra;
    balanced(:, :, 2) = Ga;
    balanced(:, :, 3) = Ba;
    
end
%------------- END OF CODE --------------