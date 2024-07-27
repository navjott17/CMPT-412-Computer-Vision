function M = determinant(A)
M = A;
d = det(A);
if d < 0
    M = -A;
end
end