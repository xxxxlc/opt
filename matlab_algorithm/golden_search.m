function [x_iter, y_iter] = golden_search(f, x_domain, N)
%GOLDEN_SEARCH golden search method to find the value of x that minimize
%   
    lambda = 0.6180;                                                       % 黄金分割比

    x_iter = zeros(size(x_domain, 1), N);
    y_iter = zeros(1, N);
    abcd = zeros(4, N);
    f_abcd = zeros(4, N);
    
    abcd(1, 1) = x_domain(1);
    abcd(4, 1) = x_domain(2);
    abcd(2, 1) = lambda * abcd(1, 1) + (1 - lambda) * abcd(4, 1);
    abcd(3, 1) = lambda * abcd(4, 1) + (1 - lambda) * abcd(1, 1);
    
    f_abcd(:, 1) = f(abcd(:, 1));

    for i = 1:1:N
        [min_val, index] = min(f_abcd(:, i));
        x_iter(i) = abcd(index, i);
        y_iter(i) = min_val;
        
        if index > 2
            abcd(1, i + 1) = abcd(2, i);
            abcd(2, i + 1) = abcd(3, i);
            abcd(4, i + 1) = abcd(4, i);
            abcd(3, i + 1) = lambda * abcd(4, i + 1) + ...
                            (1 - lambda) * abcd(1, i + 1);
            
            f_abcd(1, i + 1) = f_abcd(2, i);
            f_abcd(2, i + 1) = f_abcd(3, i);
            f_abcd(4, i + 1) = f_abcd(4, i);
            f_abcd(3, i + 1) = f(abcd(3, i + 1));
        else
            abcd(1, i + 1) = abcd(1, i);
            abcd(3, i + 1) = abcd(2, i);
            abcd(4, i + 1) = abcd(3, i);
            abcd(2, i + 1) = lambda * abcd(1, i + 1) + ...
                            (1 - lambda) * abcd(4, i + 1);
            
            f_abcd(1, i + 1) = f_abcd(1, i);
            f_abcd(3, i + 1) = f_abcd(2, i);
            f_abcd(4, i + 1) = f_abcd(3, i);
            f_abcd(2, i + 1) = f(abcd(2, i + 1));
        end
    end



end

