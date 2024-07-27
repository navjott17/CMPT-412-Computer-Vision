layers = get_lenet();
load lenet.mat

image_path = ["../images/image1.JPG", "../images/image2.JPG", "../images/image3.png", "../images/image4.jpg"];

for i=1:4
    images = imread(image_path(i));
    
    %grayscale
    if numel(images)>2
        images = rgb2gray(images); 
    end
    
    thresh = graythresh(images);
     
end
