function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
x1_new = x1 - centroid1;
x2_new = x2 - centroid2;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
dist1 = sqrt(x1_new(1, :).^2 + x1_new(2, :).^2); %distance formula
dist2 = sqrt(x2_new(1, :).^2 + x2_new(2, :).^2);
mean1 = mean(dist1);
mean2 = mean(dist2);
scl1 = sqrt(2)/mean1;
scl2 = sqrt(2)/mean2;

norm_x1 = x1_new*scl1;
norm_x2 = x2_new*scl2;
%% similarity transform 1
t1x = scl1*centroid1(1);
t1y = scl1*centroid1(2);

T1 = [scl1 0 -t1x;
    0 scl1 -t1y;
    0 0 1];

%% similarity transform 2
t2x = scl2*centroid2(1);
t2y = scl2*centroid2(2);
T2 = [scl2 0 -t2x;
    0 scl2 -t2y;
    0 0 1];

%% Compute Homography
H_norm = computeH(norm_x1, norm_x2);
%% Denormalization
H2to1 = T2\H_norm*T1;
end
