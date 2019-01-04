function create_macro_descriptor_files()
tic
  %% importing file list and labels
  [images, labels] = readlists();
  
  nimages = numel(images);
  
  % feature vector
  %CEDD = [];
  hu = [];
    
  %% feature extraction
  for n = 1 : nimages
    % reading image
    im = rgb2gray(im2double(imread(['dataset/' images{n}])));
    
    fprintf("%d\n", n);
    
    % calculate hu descriptors
    hu = [hu; Hu_Moments(SI_Moment(im))];
    %CEDD = [CEDD; compute_CEDD(im)];
  end
     
  %% saving workspace
  save('descriptors/descriptors.mat', 'images', 'labels', 'hu');

  toc
end