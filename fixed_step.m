function [x_iter, y_iter] = fixed_step(f, x_domain, N, delta_s)
%FIXED_STEP fixed_step method to find the value of x that minimize
%   此处显示详细说明
    x_iter = zeros(size(x_domain, 1), N);
    y_iter = zeros(1, N);
    fx = zeros(1, N);
    
    x_iter(1) = (x_domain(1) + x_domain(2)) / 2;
    y_iter(1) = f(x_iter(1));
    
    for i = 1:1:N
        fx(i) = (f(x_iter(i)) - f(x_iter(i) + 0.001)) / 0.001;
        if fx(i) == 0
            break;
        else
            x_iter(i + 1) = x_iter(i) + fx(i) * delta_s;
            y_iter(i + 1) = f(x_iter(i + 1));
        end
        delta_s = delta_s * 0.8;
    end


end

