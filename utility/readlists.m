function [images,labels]=readlists()
  f=fopen('lists/images.list');
  z = textscan(f,'%s');
  fclose(f);
  images = z{:}; 

  f=fopen('lists/labels.list');
  l = textscan(f,'%s');
  labels = l{:};
  fclose(f);
end
