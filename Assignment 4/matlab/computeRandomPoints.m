% clear all
% close all
% cv_cover = imread('../data/cv_cover.jpg');
% cv_desk = imread('../data/cv_desk.png');
% 
% [locs1, locs2] = matchPics(cv_cover, cv_desk);
% % bestH2to1 = computeH(locs1, locs2);     
% % bestH2to1 = computeH_norm(locs1, locs2);
% random = zeros(10,2);
% random(:,1) = randi([1, size(cv_cover,2)],1,10);
% random(:,2) = randi([1, size(cv_cover,1)],1,10);
% RGB = insertMarker(cv_cover,random,'size',10);
% imshow(RGB);
% figure;
% one = ones(1, size(random, 1));
% point = [random.'; one];
% final_img = (bestH2to1 * point).';
% final_img = final_img(:,1:2)./final_img(:,3);
% showMatchedFeatures(cv_cover, cv_desk, random, final_img, 'montage')