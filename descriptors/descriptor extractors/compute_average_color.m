function out = compute_average_color(tassello)
    
    %{
    red_mean = mean2(tassello(:, :, 1));
    green_mean = mean2(tassello(:, :, 2));
    blue_mean = mean2(tassello(:, :, 3));
    out = [red_mean, green_mean, blue_mean];
    %}

    [rows, cols, ch] = size(tassello);
    rgb = reshape(tassello, rows * cols, ch);
    out = mean(rgb);
end