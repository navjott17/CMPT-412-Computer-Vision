load('../data/someCorresp.mat');
img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');
%eightpoint test
F = eightpoint(pts1, pts2, M);
%displayEpipolarF(img1, img2, F);

%epipolar correspondence test
[coordsIM1, coordsIM2] = epipolarMatchGUI(img1, img2, F);

%essential matrix
load('../data/intrinsics.mat');
E = essentialMatrix(F, K1, K2);