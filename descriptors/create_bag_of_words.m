clear all
close all

d = uigetdir(pwd, 'tmp');
setDir  = fullfile(d);
imds = imageDatastore(setDir,'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
[trainingSet,testSet] = splitEachLabel(imds,0.3,'randomize');
bag = bagOfFeatures(imds);
classifier = trainImageCategoryClassifier(imds, bag);
img = imread(fullfile(setDir,'pasta','0114.JPG'));
confMatrix = evaluate(classifier, testSet);
[labelIdx, score] = predict(classifier,img);
classifier.Labels(labelIdx);