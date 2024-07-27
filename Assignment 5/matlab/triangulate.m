function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

row = size(pts1, 1);
col = size(pts1, 2);
pts3d = zeros(row, 3);

for i = 1:row
    P1_col1 = P1(1, :);
    P1_col2 = P1(2, :);
    P1_col3 = P1(3, :);

    P2_col1 = P2(1, :);
    P2_col2 = P2(2, :);
    P2_col3 = P2(3, :);
    
    x1 = pts1(i, 1);
    x2 = pts2(i, 1);
    y1 = pts1(i, 2);
    y2 = pts2(i, 2);
    
    %reference from slide 29 of two-view geometry
    A = [y1.*P1_col3 - P1_col2; P1_col1 - x1.*P1_col3; y2.*P2_col3 - P2_col2; P2_col1 - x2.*P2_col3];
    
    [U, ~, V] = svd(A);
    V = V(:, end);
    pts3d(i, :) = [V(1, 1)./V(4, 1) V(2, 1)./V(4, 1) V(3, 1)./V(4, 1)];

end