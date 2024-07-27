% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
cover_img = imread('../data/cv_cover.jpg');
if length(size(cover_img)) == 3
    cover_img = rgb2gray(cover_img);
end
%% Compute the features and descriptors

% feature_img = detectFASTFeatures(cover_img);
feature_img = detectSURFFeatures(cover_img);
location_img = feature_img.Location;
% [desc, locs] = computeBrief(cover_img, location_img);
[desc, locs] = extractFeatures(cover_img, location_img, 'Method', 'SURF');
y = [];
degree_rotate = 0;
for i = 0:35
    %% Rotate image
    %rotating image in increments of 10 degrees
    degree_rotate = (i+1)*10;
    rotate_img = imrotate(cover_img, degree_rotate);
    %% Compute features and descriptors
%     feature_r = detectFASTFeatures(rotate_img);
    feature_r = detectSURFFeatures(rotate_img);
    location_r = feature_r.Location;
%     [desc_r, locs_r] = computeBrief(rotate_img, location_r);
    [desc_r, locs_r] = extractFeatures(rotate_img, location_r, 'Method', 'SURF');
    %% Match features
    threshold = 10.0;
    ratio = 0.71;
    matching = matchFeatures(desc, desc_r, 'MatchThreshold', threshold, 'MaxRatio', 0.71); 
    m1 = matching(:,1); %first column 
    m2 = matching(:,2); %second column

    % take only m1 rows of locations computed from computebrief
    locs1 = location_img(m1,:);
    locs2 = location_r(m2,:);
%     if (degree_rotate == 10 || degree_rotate == 160 || degree_rotate == 290)
%         showMatchedFeatures(cover_img, rotate_img, locs1, locs2, 'montage')
%         figure;
%     end  

    %% Update histogram
    y(i+1) = size(matching, 1);
end

%% Display histogram
bar(y);
title('SURF');