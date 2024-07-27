layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
imshow(img')
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.

h_out_2 = output{2}.height;
w_out_2 = output{2}.width;
c_2 = output{2}.channel;

output_2 = reshape(output{2}.data, [h_out_2, w_out_2, c_2]);

h_out_3 = output{3}.height;
w_out_3 = output{3}.width;
c_3 = output{3}.channel;

output_3 = reshape(output{3}.data, [h_out_3, w_out_3, c_3]);

for i=1:20
    subplot(4, 5, i);
    imshow(output_2(:, :, i).');
end

for i=1:20
    subplot(4, 5, i);
    imshow(output_3(:, :, i).');
end

