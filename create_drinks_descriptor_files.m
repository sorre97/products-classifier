function create_drinks_descriptor_files()
  %% importing file list and labels
  [drink_images, drink_labels] = drinks_readlists();
  
  nimages = numel(drink_images);
  
  % feature vector
  qhist = [];
    
  %% feature extraction
  for n = 1 : nimages
    % reading image
    im = imread(['dataset/' drink_images{n}]);
   
    % calculate descriptors
    qhist = [qhist; compute_qhist(im)];
    
  end
     
  %% saving workspace
  save('drinks_descriptors.mat', 'drink_images', ...
    'drink_labels', 'qhist');

end