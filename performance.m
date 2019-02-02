close all
clear all
tic

% loads photos, white balances them and renames according to counter
files = dir(fullfile('./test', '*.JPG'));

COUNTER = 1;
END = numel(files);

product_labels = [];
predicted_labels = [];
correct_labels = [];

for i = 1 : END 
   %% reading image
   image = files(i);
   image_name = image.name;
   fprintf("%d\n", i);
   %% calculating labels
   product_labels = main(image_name);
    
   %% extracting txt associated file
   [~,name,ext] = fileparts(image.name);
   txt_filename = [name '.txt'];
   
   %% reading txt file line by line
   txt = fopen(['validation_set_txt/' txt_filename]);
   tline = fgetl(txt);
   
   j = 1;
   while ischar(tline) && j <= length(product_labels)
       % DEBUG
       %disp(tline)
       %disp(char(product_labels(j, 1)))
       
       correct_labels = [correct_labels; cellstr(tline)];
       predicted_labels = [predicted_labels; cellstr(product_labels(j, 1))];
       
       tline = fgetl(txt);
       j = j + 1;
   end

   fclose(txt);
end

%% confusion matrix
cm = confusionchart(correct_labels, predicted_labels);
cm.Title = 'Product Classification Using KNN';
cm.RowSummary = 'absolute';
cm.ColumnSummary = 'absolute';

toc