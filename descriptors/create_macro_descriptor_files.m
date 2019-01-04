function create_macro_descriptor_files()
tic
  %% importing file list and labels
  [images, labels] = readlists();
  
  nimages = numel(images);
  
  % feature vector
  %CEDD = [];
  hu = [];
  %qhist = [];
  %lbp = [];
    
  %% feature extraction
  for n = 1 : nimages
    % reading image
    im = imread(['dataset2/' images{n}]);
    
    fprintf("%d\n", n);
    
    % calculate hu descriptors
    hu = [hu; Hu_Moments(SI_Moment(rgb2gray(im2double(im))))];
    %CEDD = [CEDD; compute_CEDD(im)];
    %qhist = [qhist; compute_qhist(im)];
    %lbp = [lbp; compute_lbp(rgb2gray(im))];
  end
     
  %% saving workspace
  save('descriptors/descriptors.mat', 'images', 'labels', 'hu');

  toc
end