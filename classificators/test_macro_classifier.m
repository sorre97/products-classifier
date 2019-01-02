function out = test_macro_classifier(descriptors, labels, cv)
  % Testa un classificatore dati descrittori, etichette e partizionamento.
  % Parametri: 
  %   descriptor : descrittore/i da usare per la classificazione
  %   labels : etichette delle immagini
  %   cv : output di cvpartition con le partizioni train set / test set
  
  train_values = descriptors(cv.training,:);
  train_labels = labels(cv.training);
  
  test_values  = descriptors(cv.test,:);
  test_labels  = labels(cv.test);
  
  % classificator training
  c = fitcknn(train_values, train_labels, 'NumNeighbors', 5);
  %c = fitctree(train_values, train_labels);
  %c = fitcsvm(train_values, train_labels);
  
  train_predicted = predict(c, train_values);
  train_perf = confmat(train_labels, train_predicted);

  test_predicted = predict(c, test_values);
  test_perf = confmat(test_labels, test_predicted);
  
  % exporting classifier
  out = [train_perf, test_perf];
  saveCompactModel(c, 'classificators/macroClassificationKNN');
  
end