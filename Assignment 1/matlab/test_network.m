%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix

confusion = zeros(10, 10); %because numbers are from 0 to 9.
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    y_pred = ytest(:, i:i+99);
    truth = y_pred;
    
    [smth, index] = max(P); %to find largest value in columns.
    
    %for confusion matrix
    for a=1:length(index)
        confusion(truth(a), index(a)) = confusion(truth(a), index(a)) + 1;
    end
    confusionchart(confusion)
end