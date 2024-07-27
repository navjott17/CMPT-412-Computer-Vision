function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

%%Normalize the points (scaling data)
norm_pts1 = pts1./M;
norm_pts2 = pts2./M;

x_pts1 = norm_pts1(:, 1);
y_pts1 = norm_pts1(:, 2);

x_pts2 = norm_pts2(:, 1);
y_pts2 = norm_pts2(:, 2);

%%matrix: M*9
A = zeros(size(pts1, 1), 9);

X1 = x_pts1;
Y1 = y_pts1;
X2 = x_pts2;
Y2 = y_pts2;
X2_X1 = X2.*X1;
X2_Y1 = X2.*Y1;
Y2_X1 = Y2.*X1;
Y2_Y1 = Y2.*Y1;
ones_column = ones(size(pts1, 1), 1);

%%from slide 116 where xm is X1 here and x'm is X2 here.
A = [X2_X1 X2_Y1 X2 Y2_X1 Y2_Y1 Y2 X1 Y1 ones_column];

%%find the SVD of A
[~, ~, V1] = svd(A);

%%computing F:
F_reshape = reshape(V1(:, 9), 3, 3);

%%enforcing rank 2 condition on F
[U, S, V2] = svd(F_reshape);

%%setting smallest singular value to zero.
S(end: end) = 0;
V2 = V2';
F_prime = U*S*V2;

%%refine the solution using refineF.m:
refined_matrix = refineF(F_prime, norm_pts1, norm_pts2);

%%unscaling the matrix:
T = [1/M 0 0;
    0 1/M 0;
    0 0 1];
T_transpose = T';

%%Final matrix
F = T_transpose * refined_matrix * T; 
    
end