function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%

%%NX2 matrix pts2:
row = size(pts1, 1);
col = size(pts1, 2);
pts2 = zeros(row, col);

%x and y points of pts1
x1 = pts1(1, 1);
y1 = pts1(1, 2);
p1 = [x1; y1; 1];

%epipolar line
%reference from slide 72 of two-view geometry
epipolar = F*p1;
epipolar = epipolar/-epipolar(2);

%window size
window = 40;
img1_window = double(im1(y1: y1+window, x1-window:x1+window));

%calculate points for pts2
for i = 1:row
    least_dist = inf;
    for j = x1-window:x1+window
        
        p2 = round([j, j*epipolar(1) + epipolar(3), 1]);
        x2 = p2(1);
        y2 = p2(2);
        
        %window for second image
        img2_window = double(im2(y2:y2+window, x2-window:x2+window));
        diff = sum((img1_window - img2_window).^2, 'all');
        diff = sqrt(diff);
        
        %fill in pts2 matrix
        if (diff < least_dist)
            least_dist = diff;
            pts2(i, 1) = x2;
            pts2(i, 2) = y2;
        end
    end     
end