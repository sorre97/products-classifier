function create_macro_descriptor_files()
  %% importing file list and labels
  [images, labels] = readlists();
  
  nimages = numel(images);
  
  % feature vector
  CEDD = [];
  hu = [];
  qhist = [];
  lbp = [];
    
  %% feature extraction
  for n = 1 : nimages
    % reading image
    im = imread(['dataset/' images{n}]);
    
    fprintf("%d\n", n);
    
    % calculate hu descriptors
    hu = [hu; Hu_Moments(SI_Moment(rgb2gray(im)))];
    CEDD = [CEDD; compute_CEDD(im)];
    %qhist = [qhist; compute_qhist(im)];
    %lbp = [lbp; compute_lbp(rgb2gray(im))];    
    
    %SURF
    %points = detectSURFFeatures(rgb2gray(im));
    %[features, valid_points] = extractFeatures(rgb2gray(im), points);
  end
  
  % feature normalization
  CEDD_STD = std2(CEDD);
  CEDD_MEAN = mean2(CEDD);
  CEDD = (CEDD - CEDD_MEAN) / CEDD_STD;
  
  hu_STD = std2(hu);
  hu_MEAN = mean2(hu);
  hu = (hu - hu_MEAN) / hu_STD;
  
  %% saving workspace
  save('descriptors/descriptors.mat', 'images', 'labels', 'CEDD', 'hu');

end