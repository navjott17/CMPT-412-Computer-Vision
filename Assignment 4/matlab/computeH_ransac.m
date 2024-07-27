function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3
%reference from https://www.youtube.com/watch?v=EkYXjmiolBg
size_locs1 = size(locs1, 1);
size_locs2 = size(locs2, 1);
iter = 5000;
num = 4;
total_inliers = 0;
inliers = zeros(1, size_locs1);
for i = 1:iter
    if size_locs1 < 4
        random_points = randperm(size_locs1,size_locs1);
    else
        random_points = randperm(size_locs1,num);
    end

    l1 = locs1(random_points, :);
    l2 = locs2(random_points, :);
    [H] = computeH_norm(l1, l2);
    
    x_pred = H*[locs1 ones(size_locs1,1)]';
    x_pred = x_pred./x_pred(3,:);
    y_pred = [locs2 ones(size_locs2,1)]';
    
    dist = x_pred - y_pred;
    dist = sqrt(dist(1,:).^2 + dist(2,:).^2);    
    
    count = 0;
    temp = zeros(1, size_locs1);
    for j = 1:size_locs1
        if dist(j) < 0.5
            temp(j) = 1;
            count = count+1;
        end
    end
    
    if count > total_inliers
        total_inliers = count;
        inliers = temp;
    end
      
end
x = locs1(inliers==1,:);
y = locs2(inliers==1,:); 
bestH2to1 = computeH_norm(y, x);
end

