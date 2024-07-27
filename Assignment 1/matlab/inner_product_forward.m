function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.
% Filling the height, width, channel, batch size and data field of the
% output.

output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = k;
output.data = zeros([n, k]);

% output_temp is output, f(x) = wx + b
for i=1:k
    output.data(:,i) = (param.w.' * input.data(:,i)) + param.b.';
end
    
end
