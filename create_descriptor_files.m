function create_descriptor_files()
  % Calcola i descrittori delle immagini e li salva su file.

  [images, labels] = readlists();
  
  nimages = numel(images);
  
  lbp = [];
  qhist = []; % rgb quantizzato in 4096 valori
  cedd = [];

  for n = 1 : nimages
    
    im = imread(['simplicity/' images{n}]);
  
    lbp = [lbp; compute_lbp(im)];
   
   qhist = [qhist; compute_qhist(im)];
   
   cedd = [cedd; compute_CEDD(im)];
  
  end
     
  save('descriptors.mat', 'images', 'labels', 'qhist', 'cedd', 'lbp');

end