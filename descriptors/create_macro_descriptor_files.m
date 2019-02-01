function create_macro_descriptor_files()
  %% importing file list and labels
  [images, labels] = readlists();
  
  nimages = numel(images);
  
  % feature vector
  CEDD = [];
  hu = [];
  compactness = [];
  color = [];
    
  %% feature extraction
  for n = 1 : nimages
    % reading image
    im = imread(['dataset/' images{n}]);
    
    % binary of imread
    BW = rgb2gray(im) > 0;
    
    % color equalization throw V channel of HSV color space
    HSV = rgb2hsv(im);
    HSV(:, :, 3) = imadjust(HSV(:, :, 3));
    im = hsv2rgb(HSV);
    
    fprintf("%d\n", n);
    
    hu = [hu; Hu_Moments(SI_Moment(BW))];
    CEDD = [CEDD; compute_CEDD(im2uint8(im))];
    compactness = [compactness; compute_compactness(BW)];
    color = [color; compute_average_color(HSV)];
    
  end
  
  % feature normalization
  CEDD_STD = std2(CEDD);
  CEDD_MEAN = mean2(CEDD);
  CEDD = (CEDD - CEDD_MEAN) / CEDD_STD;
  
  hu_STD = std2(hu);
  hu_MEAN = mean2(hu);
  hu = (hu - hu_MEAN) / hu_STD;
  
  compactness_STD = std2(compactness);
  compactness_MEAN = mean2(compactness);
  compactness = (compactness - compactness_MEAN) / compactness_STD;
  
  color_STD = std2(color);
  color_MEAN = mean2(color);
  color = (color - color_MEAN) / color_STD;
  
  
  %% saving workspace
  save('descriptors/descriptors.mat', 'images', 'labels', 'CEDD', 'hu', 'color', 'compactness');
  
end