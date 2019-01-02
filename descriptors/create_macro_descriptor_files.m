function create_macro_descriptor_files()
  %% importing file list and labels
  [images, labels] = readlists();
  
  nimages = numel(images);
  
  % feature vector
  hu = [];
    
  %% feature extraction
  for n = 1 : nimages
    % reading image
    im = rgb2gray(im2double(imread(['dataset/' images{n}])));
    
    % calculate hu descriptors
    hu = [hu; compute_hu_moments(im)];
    
  end
     
  %% saving workspace
  save('descriptors.mat', 'images', 'labels', 'hu');

end