function create_macro_descriptor_files()
tic
  %% importing file list and labels
  [images, labels] = readlists();
  
  nimages = numel(images);
  
  % feature vector
  CEDD = [];
  hu = [];
    
  %% feature extraction
  for n = 1 : nimages
    % reading image
    im = imread(['dataset/' images{n}]);
    
    % calculate hu descriptors
    CEDD = [CEDD; compute_CEDD(im)];
    
  end
     
  %% saving workspace
  save('descriptors/descriptors.mat', 'images', 'labels', 'CEDD');

  toc
end