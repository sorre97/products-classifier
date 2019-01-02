function [drinks_images,drinks_labels]=drinks_readlists()
  f=fopen('drinks_images.list');
  z = textscan(f,'%s');
  fclose(f);
  drinks_images = z{:}; 

  f=fopen('drinks_labels.list');
  l = textscan(f,'%s');
  drinks_labels = l{:};
  fclose(f);
end