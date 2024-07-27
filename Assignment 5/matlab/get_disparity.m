function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

row = size(im1, 1);
column = size(im2, 2);

disp = zeros(row, column, maxDisp+1);
matrix = zeros(row, column);

for i = 1:maxDisp+1
    total = 1:(row*(column - (i-1)));
    matrix(total) = double((im1(row*(i-1) + total) - im2(total)).^2);
    mask = ones(windowSize, windowSize);
    disp(:, :, i) = conv2(matrix, mask, 'same');
end

[~, ind] = min(disp, [], 3);
dispM = ind-1;
end