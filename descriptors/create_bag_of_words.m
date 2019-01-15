function create_bag_of_words()
    %d = uigetdir(pwd, 'tmp');
    %setDir  = fullfile(d);

    % dataset location
    setDir = './dataset2';

    % storing files and labels in imageDataStore object
    imds = imageDatastore(setDir,'IncludeSubfolders',true,'LabelSource',...
    'foldernames');

    % splitting dataset into validation set and traning set (holding 30%)
    [trainingSet, validationSet] = splitEachLabel(imds,0.3,'randomize');
    % extraction of bag of words (feature)
    bag = bagOfFeatures(trainingSet);
    % traning classifier with bag of words
    classifier = trainImageCategoryClassifier(trainingSet, bag);

    % confusion matrix
    confMatrix = evaluate(classifier, trainingSet);
    confMatrix = evaluate(classifier, validationSet);
    mean(diag(confMatrix));
    
    % loading image for testing
    %img = imread(fullfile(setDir,'pasta','0114.JPG'));
    %[labelIdx, score] = predict(classifier,img);
    %classifier.Labels(labelIdx)
     
  %% saving classifier
  save('classificators/SURFClassifier', 'classifier', 'imds', 'bag');

end