function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
n = size(x1, 1);
A = zeros(2*n, 9);
if any(isnan(x1(:))) || any(isinf(x1(:)))
    x1 = zeros(size(x1,1),size(x1,2));
end
if any(isnan(x2(:))) || any(isinf(x2(:)))
    x2 = zeros(size(x2,1),size(x2,2));
end
for i = 1: n
    X1 = x1(i, 1); %first column of image1
    Y1 = x1(i, 2); %second column of image1

    X2 = x2(i, 1);
    Y2 = x2(i, 2);

    X2_X1 = X2*X1;
    X2_Y1 = X2*Y1;
    Y2_X1 = Y2*X1;
    Y2_Y1 = Y2*Y1;
    R1 = [-X1 -Y1 -1 0 0 0 X2_X1 X2_Y1 X2];
    R2 = [0 0 0 -X1 -Y1 -1 Y2_X1 Y2_Y1 Y2];
    
    %Ah = 0
    A(2*i-1, :) = R1;
    A(2*i, :) = R2;
end
[U, ~, V] = svd(A);

H2to1 = reshape(V(:, end), 3, 3)';
end
