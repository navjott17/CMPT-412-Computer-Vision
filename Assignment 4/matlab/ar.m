% Q3.3.1
close all
clear all

ar_source = loadVid('../data/ar_source.mov');
book_video = loadVid('../data/book.mov');
cv_cover = imread('../data/cv_cover.jpg');

final_video = VideoWriter('ar.avi');

open(final_video);
for i = 1:size(ar_source, 2)
    frame_ar = ar_source(i).cdata;
    crop_ar = imcrop(frame_ar, [0 45 size(frame_ar, 2) size(frame_ar, 1)-90]);
    scale_ar = imresize(crop_ar, [size(cv_cover, 1) size(cv_cover, 2)]);
    
    frame_book = book_video(i).cdata;
    [locs1, locs2] = matchPics(cv_cover, frame_book);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    
    composite = compositeH(inv(bestH2to1), scale_ar, frame_book);
    imshow(composite);
%     if(i == 10 || i == 140)
%         imshow(composite);
%         figure;
%     end
    
    writeVideo(final_video, composite);
end
close(final_video);
