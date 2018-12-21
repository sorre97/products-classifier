function create_descriptor_files()
  % Calcola i descrittori delle immagini e li salva su file.

  [images, labels] = readlists();
  
  nimages = numel(images);
  
  %%descriptors array

  for n = 1 : nimages
    
    im = imread(['dataset/' images{n}]);
    
    %%descriptors calculator
    
  end
     
  save('descriptors.mat', 'images', 'labels', 'DESCRIPTORS');

end