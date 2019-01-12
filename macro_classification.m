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
qhist = compute_qhist(im2uint8(ROI));
%lbp = compute_lbp(im2uint8(rgb2gray(ROI)));
%ghist = compute_glcm(im2uint8(rgb2gray(ROI)));
%glcm = compute_ghist(im2uint8(rgb2gray(ROI)));
%colorRGB = compute_average_color(im2uint8(ROI));
    
%figure, imshow(ROI);

% feature normalization
CEDD_STD = std2(CEDD);
CEDD_MEAN = mean2(CEDD);
CEDD = (CEDD - CEDD_MEAN) / CEDD_STD;
  

hu_STD = std2(hu);
hu_MEAN = mean2(hu);
hu = (hu - hu_MEAN) / hu_STD;


qhist_STD = std2(qhist);
qhist_MEAN = mean2(qhist);
qhist = (qhist - qhist_MEAN) / qhist_STD;

%colorRGB_STD = std2(colorRGB);
%colorRGB_MEAN = mean2(colorRGB);
%colorRGB = (colorRGB - colorRGB_MEAN) / colorRGB_STD;

%% classification
% importing classifier
CompactMdl = loadCompactModel('classificators/macroClassificationKNN.mat');
% classification
[object_label, prob] = predict(CompactMdl, [hu CEDD qhist]); 

%% unknown class
% printing confidence of recognition for each class
g=sprintf('%.8f ', prob);
fprintf('Confidence probability:\n');
fprintf("%10s%10s%10s%10s%10s%10s%10s%10s\n", "algida", "chocolate", "cocacola", "limone", "apple", "pasta", "yogurt", "integrale");
fprintf('%s - %s\n', g, char(object_label));

% if probability of recognition is below treshold T, the object is not recognized
% unknown class is assigned
T = 0.50;
if(max(prob) < T)
    object_label = cellstr('unknown');
end

%{
NON POSSIBILE PER VIA DEI GELATI IN PIEDI

BW = rgb2gray(ROI) > 0;
area = regionprops(BW, 'Area');
perimeter = regionprops(BW, 'Perimeter');
compactness = (4 * pi * area.Area) / (2 * perimeter.Perimeter)^2;

if(strcmp(char(object_label), 'algida'))
    fprintf('%s\n', char(object_label));
    fprintf('Area: %f\n', area.Area);
    fprintf('Perimeter: %f\n', perimeter.Perimeter);
    fprintf('Compactness: %f\n', compactness);
    
    if(compactness < 0.18)
        object_label = cellstr('chocolate'); 
    end
end
%}


%SURF
%load('classificators/SURFClassifier.mat');
%[labelIdx, score] = predict(classifier, rgb2gray(im2uint8(ROI)));
%object_label = classifier.Labels(labelIdx);
end
%------------- END OF CODE --------------