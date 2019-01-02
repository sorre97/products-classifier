function create_drinks_descriptor_files()
  %% importing file list and labels
  [images, labels] = readlists();
  
  nimages = numel(images);
  
  % feature vector
  % da stabilire
    
  %% feature extraction
  for n = 1 : nimages
    % reading image
    im = rgb2gray(im2double(imread(['dataset/' images{n}])));
    
    % calculate descriptors
    % da stabilire
    
  end
     
  %% saving workspace
  save('drinks_descriptors.mat', 'images', 'labels', 'hu');

end