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
CEDD = compute_CEDD(im2uint8(ROI));
hu = Hu_Moments(SI_Moment(rgb2gray(im2uint8(ROI))));
%qhist = compute_qhist(im2uint8(ROI));
%lbp = compute_lbp(im2uint8(rgb2gray(ROI)));
    
%figure, imshow(ROI);

% feature normalization
CEDD_STD = std2(CEDD);
CEDD_MEAN = mean2(CEDD);
CEDD = (CEDD - CEDD_MEAN) / CEDD_STD;
  

hu_STD = std2(hu);
hu_MEAN = mean2(hu);
hu = (hu - hu_MEAN) / hu_STD;

%% classification
% importing classifier
CompactMdl = loadCompactModel('classificators/macroClassificationKNN.mat');
% classification
[object_label, prob] = predict(CompactMdl, [CEDD hu]); 

%% unknown class
% printing confidence of recognition for each class
g=sprintf('%f ', prob);
fprintf('Confidence probability: %s - %s\n', g, char(object_label));

% if probability of recognition is below treshold T, the object is not recognized
% unknown class is assigned
T = 0.50;
if(max(prob) < T)
    object_label = cellstr('unknown');
end

%SURF
%load('classificators/SURFClassifier.mat');
%[labelIdx, score] = predict(classifier, rgb2gray(im2uint8(ROI)));
%object_label = classifier.Labels(labelIdx);
end
%------------- END OF CODE --------------