load('descriptors/descriptors.mat');

%% feature incorrelation
  Y=tsne([CEDD]);
  gscatter(Y(:,1),Y(:,2),labels);

%% training 
% partitioning labels in 80% tranining and 20% test
cv = cvpartition(labels, 'Holdout', 0.2);

result = test_macro_classifier([CEDD], labels, cv);

perf = [result.accuracy];
    
%figure, bar(perf), xlabel("Number of try"), ylabel("Accuracy on test");

