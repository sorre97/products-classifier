function price = object_price(object_label)
%object_price - price of object
%
%
%
% Inputs:
%    object_label - object label to be priced
%    
% Outputs:
%    price - price of the object
%
%
    product = char(object_label);
    
    switch product
        case 'Algida'
            price = 3.5;
        case 'CocaCola'
            price = 2;
        case 'Mandarino'
            price = 0.2;
        case 'Aranciata'
            price = 1.5;
        case 'Mela'
            price = 0.3;
        case 'Rummo'
            price = 1.3;
        case 'Passata'
            price = 1.2;
        case 'Viviverde'
            price = 1.0;
        case 'Yomo'
            price = 1.5;
        case 'Ghiaccioli'
            price = 3.9;
        case 'Cioccolato'
            price = 1.2;
        case 'Pasta'
            price = 1.5;
        case 'Milka'
            price = 2.5;
        case 'The'
            price = 2.5;
        case 'Integrale'
            price = 1.7;
        case 'Sprite'
            price = 1.5;
        case 'Limone'
            price = 0.2;
        otherwise
            price = 0;
    end
end
%------------- END OF CODE --------------