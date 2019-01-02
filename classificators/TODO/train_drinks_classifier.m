load('drinks_descriptors.mat');

% partitioning labels in 80% tranining and 20% test
cv = cvpartition(labels, 'Holdout', 0.2);

result = test_macro_classifier(hu, labels, cv);

perf = [result.accuracy];
    
% figure, bar(perf), xlabel("Number of try"), ylabel("Accuracy on test");