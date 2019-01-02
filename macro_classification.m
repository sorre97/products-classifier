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
%% TODO
hu = compute_hu_moments(ROI);

%%IMPORT CLASSIFIER
CompactMdl = loadCompactModel('classificationKNN.mat');
object_label = predict(CompactMdl, hu); 
end
%------------- END OF CODE --------------