function create_descriptor_files()
  % Calcola i descrittori delle immagini e li salva su file.

  [images, labels] = readlists();
  
  nimages = numel(images);
  
  %%descriptors array
  m = [];

  for n = 1 : nimages
    
    im = imread(['dataset/' images{n}]);
    
    %%descriptors calculator
    m = [m; mean(im(:))];
    
  end
     
  save('descriptors.mat', 'images', 'labels', 'm');

end