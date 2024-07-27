function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!
Image1 = I1;
Image2 = I2;
%% Convert images to grayscale, if necessary
% because it must be a m*3 array to convert to grayscale
%%should be 3 dimension to convert.
size1 = size(I1);
size2 = size(I2);
if length(size1) == 3
    Image1 = rgb2gray(I1);
end
if length(size2) == 3
    Image2 = rgb2gray(I2);
end
%% Detect features in both images
feature1 = detectFASTFeatures(Image1);
feature2 = detectFASTFeatures(Image2);
%% Obtain descriptors for the computed feature locations
locs_in1 = feature1.Location;
locs_in2 = feature2.Location;
[desc1, location1] = computeBrief(Image1, locs_in1);
[desc2, location2] = computeBrief(Image2, locs_in2);
%% Match features using the descriptors
threshold = 10.0;
ratio = 0.71;
matching = matchFeatures(desc1, desc2, 'MatchThreshold', threshold, 'MaxRatio', ratio);
%first column
m1 = matching(:,1);
%second column
m2 = matching(:,2);

% take only m1 rows of locations computed from computebrief
locs1 = location1(m1,:);
%size(locs1)
locs2 = location2(m2,:);

end

