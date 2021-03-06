load('descriptors/descriptors.mat');

descriptor_vector = [hu compactness color CEDD];

%% feature incorrelation
Y=tsne(descriptor_vector);
gscatter(Y(:,1),Y(:,2),labels);

%% training 
% partitioning labels in 80% tranining and 20% test
cv = cvpartition(labels, 'Holdout', 0.2);

result = test_macro_classifier(descriptor_vector, labels, cv);

perf = [result.accuracy];

