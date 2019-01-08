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

CEDD = compute_CEDD(im2uint8(ROI));
%hu = Hu_Moments(SI_Moment(rgb2gray(ROI)));
qhist = compute_qhist(im2uint8(ROI));
%lbp = compute_lbp(im2uint8(rgb2gray(ROI)));
    
%figure, imshow(ROI);
% IMPORT CLASSIFIER
CompactMdl = loadCompactModel('classificators/macroClassificationKNN.mat');
object_label = predict(CompactMdl, [CEDD qhist]); 

%SURF
%load('classificators/SURFClassifier.mat');
%[labelIdx, score] = predict(classifier, rgb2gray(im2uint8(ROI)));
%object_label = classifier.Labels(labelIdx);
end
%------------- END OF CODE --------------