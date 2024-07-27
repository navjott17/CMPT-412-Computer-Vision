function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.

%compute camera center c using SVD
[U, ~, V] = svd(P);
c = V(1:3, 4)/V(4, 4);

%compute K and R using QR decomposition
%reference from
%https://math.stackexchange.com/questions/1640695/rq-decomposition and
%reference from https://www.math.ucla.edu/~yanovsky/Teaching/Math151B/handouts/GramSchmidt.pdf

%compute A' = IA
A = zeros(3, 3);
A(:, 1) = P(:, 1);
A(:, 2) = P(:, 2);
A(:, 3) = P(:, 3);

Identity = eye(3);
I = Identity;
I(1, :) = Identity(3, :);
I(3, :) = Identity(1, :);

A = determinant(A);

A_bar = I*A;
A_transpose = transpose(A_bar);
A_transpose = determinant(A_transpose);

%QR decomposition
[q, r] = qr(A_transpose);

%calculate intrinsic K (right upper triangular)
K = I*r'*I;
diagonal_matrix = diag(sign(diag(K)));
K = K*diagonal_matrix;

%calculate rotation R (orthonormal matrix)
R = inv(K)*A;

%calculate translation t
t = -R*c;
end
