layers = get_lenet();
load lenet.mat

layers{1}.batch_size = 1;

image_path = ["../images/real_world/1.jpg", "../images/real_world/2.jpg", "../images/real_world/3.jpg", "../images/real_world/4.jpg", "../images/real_world/5.jpg"];
for i=1:5
    images = imread(image_path(i));
    
    %grayscale
    if numel(images)>2
        images = rgb2gray(images); 
    end
    
    %resizing
    images = imresize(images, [28, 28]);
    images = im2double(images);
    images = reshape(images', [], 1);
    
    [smth, predictions] = convnet_forward(params, layers, images);
    
    [wht, pred] = max(predictions);
    
    fprintf('%d \n', pred-1);
  
end
    

