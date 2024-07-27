function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m

%optical center 
c1 = -(inv(K1*R1)*(K1*t1));
c2 = -(inv(K2*R2)*(K2*t2));

%new rotation matrix
norm = sqrt(sum((c1-c2).^2));
r1 = (c1-c2)/norm;
r2 = (cross(R1(3, :), r1))';
r3 = cross(r2, r1);
new_R = [r1 r2 r3]';
R1n = new_R;
R2n = new_R;

%new intrinsic parameter
new_K = K2;
K1n = new_K;
K2n = new_K;

%new translation
t1n = -new_R*c1;
t2n = -new_R*c2;

%rectification:
M1 = (new_K*new_R)*(inv(K1*R1));
M2 = (new_K*new_R)*(inv(K2*R2));

end