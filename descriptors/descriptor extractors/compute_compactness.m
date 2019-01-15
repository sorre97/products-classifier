function compactness_value = compute_compactness(BW)
  
  area = regionprops(BW, 'Area');
  perimeter = regionprops(BW, 'Perimeter');
  
  compactness_value = (4 * pi * area.Area) / (perimeter.Perimeter)^2;
  
end