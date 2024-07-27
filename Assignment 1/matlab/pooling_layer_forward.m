function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    temp_data = zeros([h_out, w_out, c, batch_size]);
    output.data = zeros([h_out* w_out* c, batch_size]);
    
    %reshaping the data to take out max as the definition of pooling
    %suggests
    reshaped_input_data = reshape(input.data, [h_in, w_in, c, batch_size]);
    s = stride;
    
    for a=(1:output.height)
        horizontal = s*(a-1) + 1; %row of a kernel with stride, s=2
        for b=(1:output.width)
            vertical = s*(b-1) + 1; %column of a kernel with stride, s=2
            filter_data = reshaped_input_data(horizontal:horizontal+k-1, vertical:vertical+k-1, :, :);
            temp_data(a,b,:,:) = max(max(filter_data));
        end
    end
    X = output.height*output.width*c;
    output.data = reshape(temp_data, [X, batch_size]);
end

