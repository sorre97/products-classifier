function out = test_drinks_classifier(descriptors, labels, cv)
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
  c_drinks = fitcknn(train_values, train_labels, 'NumNeighbors', 5);
  
  train_predicted = predict(c_drinks, train_values);
  train_perf = confmat(train_labels, train_predicted);

  test_predicted = predict(c_drinks, test_values);
  test_perf = confmat(test_labels, test_predicted);
  
  %%EXPORT CLASSIFIER WITH CLASSIFICATION LEARNER
  out = [train_perf, test_perf];
  saveCompactModel(c_drinks, 'macroClassificationKNN');
  
end