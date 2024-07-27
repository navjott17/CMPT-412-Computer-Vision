close all
clear

data = load('../data/PnP.mat');
%load an image, CAD, 2D points x and 3D points X
img = data.image;
cad = data.cad;
x = data.x;
X = data.X;

%Run estimate_pose and estimate_param
P = estimate_pose(x, X);
[K, R, t] = estimate_params(P);

%project 3D points
pts3d = P*[X; ones(1, size(X, 2))];
pts3d = pts3d./pts3d(3, :);
figure;
imshow(img);
x1 = pts3d(1, :);
y1 = pts3d(2, :);
z1 = pts3d(3, :);
hold on;
plot3(x1, y1, z1, 'bo', 'MarkerSize', 10);
plot(x1, y1, 'r.','MarkerSize',10);
hold off
vertices = cad.vertices';
faces = cad.faces;
x2 = vertices(1, :);
y2 = vertices(2, :);
z2 = vertices(3, :);
figure;
trimesh(faces, x2, y2, z2, 'EdgeColor', 'black');

%CAD model rotated 
temp_matrix = [vertices; ones(1, size(vertices', 1))];
A = [0 0 0 1];
rotated = [R t; A] * temp_matrix;
x3 = rotated(1, :);
y3 = rotated(2, :);
z3 = rotated(3, :);
figure;
trimesh(faces, x3, y3, z3, 'EdgeColor', 'black');

%project all vertices overlapping with 2D image
proj = P * temp_matrix;
proj = proj./ proj(3, :);
x4 = proj(1, :)';
y4 = proj(2, :)';
figure;
imshow(img);
hold on
patch('Faces', faces, 'Vertices', [x4, y4], 'EdgeColor', 'blue') 
hold off    