function object_label = macro_classification(ROI)
%macro_classification - classification of ROI according to macro
%classificator
%
%
% Inputs:
%    ROI - Region of interest, object to classify
%    
% Outputs:
%    object_label - label of the object assigned according to macro_classificator 
%
%

%% feature extraction

% equalizing ROI throw V channel of HSV color space
ROIHSV = rgb2hsv(ROI);
ROIHSV(:, :, 3) = imadjust(ROIHSV(:, :, 3));
ROI = hsv2rgb(ROIHSV);
    
% binary variable for ROI
BWROI = imfill(rgb2gray(im2uint8(ROI)) > 0, 'holes');

CEDD = compute_CEDD(im2uint8(ROI));
hu = Hu_Moments(SI_Moment(BWROI));
%qhist = compute_qhist(im2uint8(ROI));
compactness = compute_compactness(BWROI);
color = compute_average_color(ROIHSV);

%figure, imshow(ROI);

% feature normalization
CEDD_STD = std2(CEDD);
CEDD_MEAN = mean2(CEDD);
CEDD = (CEDD - CEDD_MEAN) / CEDD_STD;
  

hu_STD = std2(hu);
hu_MEAN = mean2(hu);
hu = (hu - hu_MEAN) / hu_STD;


%qhist_STD = std2(qhist);
%qhist_MEAN = mean2(qhist);
%qhist = (qhist - qhist_MEAN) / qhist_STD;


%% classification
% importing classifier
CompactMdl = loadCompactModel('classificators/macroClassificationKNN.mat');
% classification
%[object_label, prob] = predict(CompactMdl, [hu compactness color CEDD]);
[object_label, prob] = predict(CompactMdl, [hu CEDD]);
%% unknown class
% printing confidence of recognition for each class
%g=sprintf('%.8f ', prob);
%fprintf('Confidence probability:\n');
%fprintf("%10s%10s%10s%10s%10s%10s%10s%10s\n", "algida", "chocolate", "cocacola", "limone", "apple", "pasta", "yogurt", "integrale");
%fprintf('%s - %s\n', g, char(object_label));

% if probability of recognition is below treshold T, the object is not recognized
% unknown class is assigned
T = 0.65;
if(max(prob) < T)
    object_label = cellstr('unknown');
end

end
%------------- END OF CODE --------------