% % A test script using templeCoords.mat
% %
% % Write your code here
clear;
img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

%load the two images and the point corrrespondences from someCorresp.mat
points1 = load('../data/someCorresp.mat');

%load the points in imgage 1 contained in templeCoords.mat
points2 = load('../data/templeCoords.mat');

%load the intrinsics.mat
points3 = load('../data/intrinsics.mat');

%Run eightpoint to compute F
F = eightpoint(points1.pts1, points1.pts2, points1.M);

%Run epipolarCorrespondences
[pts2] = epipolarCorrespondence(img1, img2, F, points2.pts1);

%Compute essential matrix E
E = essentialMatrix(F, points3.K1, points3.K2);

%Compute the first camera projection matrix P1
P1 =[
    1 0 0 0;
    0 1 0 0;
    0 0 1 0];

%Use camera2.m to compute condidates for P2
P2_c = camera2(E);

%Run triangulate function
dist = -100000000;
for i = 1:4
    p1 = points3.K1*P1;
    %Find out the correct P2
    P2 = P2_c(:, :, i);
    pts3d = triangulate(p1, points2.pts1, P2, pts2);
    sum1 = sum(pts3d(:, 3) > 0);
    if (dist < sum1)
        dist = sum1;
        P = pts3d;
        A = P2_c(:, :, i);
    end
end
% plot the point correspondences on screen
plot3(P(:, 1), P(:, 3), -P(:, 2), '.'); axis equal

%rotation matrix
R1 = [1 0 0; 0 1 0; 0 0 1];
R2 = A(:, 1:3);

%translation
t1 = zeros(3, 1);
t2 = -A(:, 4);

% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
