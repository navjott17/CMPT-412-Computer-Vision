function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]

%took reference from computeH which was done in project 4
n = size(x, 2);
A = zeros(2*n, 12);

for i = 1:n
    x1 = x(1, i);
    y1 = x(2, i);
    X1 = X(1, i);
    Y1 = X(2, i);
    Z1 = X(3, i);
    
    x1_X1 = x1*X1;
    x1_Y1 = x1*Y1;
    x1_Z1 = x1*Z1;
    y1_X1 = y1*X1;
    y1_Y1 = y1*Y1;
    y1_Z1 = y1*Z1;
    
    R1 = [-X1 -Y1 -Z1 -1 0 0 0 0 x1_X1 x1_Y1 x1_Z1 x1];
    R2 = [0 0 0 0 -X1 -Y1 -Z1 -1 y1_X1 y1_Y1 y1_Z1 y1];
    
    %Ah = 0
    A(2*i-1, :) = R1;
    A(2*i, :) = R2;
end
[U, ~, V] = svd(A);
P = (reshape(V(:, end), 4, 3)');
end
