function train_classifier()

load('descriptors.mat');

% partitioning labels in 80% tranining and 20% test
cv = cvpartition(labels, 'Holdout', 0.2);

% res7 = test_classifier(DESCRIPTORS_VECTOR, labels, cv);

%{
perf = [res1(2).accuracy, ...
        res2(2).accuracy, ...
        res3(2).accuracy, ...
        res4(2).accuracy, ...
        res5(2).accuracy, ...
        res6(2).accuracy, ...
        res7(2).accuracy];
%}
perf = [res0(2).accuracy];
    
figure, bar(perf), xlabel("Number of try"), ylabel("Accuracy on test");

end