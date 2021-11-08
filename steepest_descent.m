function [x_iter, y_iter, grad_iter, norm_iter, alpha_iter] = steepest_descent(f, x0, x_domain, N, m)
%STEEPEST_DESCENT 
%   此处显示详细说明
    x_var = sym('x',[1, m]);
    c = num2cell(x_var);
    g_var = sym('x', [m, 1]);
    
    for n = 1:1:m
        g_var(n) = diff(f, x_var(n));
    end
    
    x_iter = zeros(size(x0, 1), N);
    y_iter = zeros(1, N);
    grad_iter = zeros(size(x0, 1), N);
    norm_iter = zeros(1, N);
    alpha_iter = zeros(1, N);
    
    x_iter(:, 1) = x0;
    y_iter(:, 1) = subs(f, c, {x_iter(:, 1)'});
    grad_iter(:, 1) = subs(g_var, c, {x_iter(:, 1)'});
    norm_iter(:, 1) = norm(grad_iter(:, 1));
    
    for i = 1:1:N
        alpha_iter(:, i) = wolfe_select(f, x_iter(:, i), grad_iter(:, 1) / norm_iter(:, 1), 2);
        x_iter(:, i + 1) = x_iter(:, i) - alpha_iter(:, i) * grad_iter(:, i) ./ ...
                           norm(grad_iter(:, i));
%         x_iter(:, i + 1) = x_iter(:, i) - grad_iter(:, i) ./ ...
%                            norm(grad_iter(:, i));
        y_iter(:, i + 1) = subs(f, c, {x_iter(:, i + 1)'});
        grad_iter(:, i + 1) = subs(g_var, c, {x_iter(:, i + 1)'});
        norm_iter(:, i + 1) = norm(grad_iter(:, i + 1));
    end


end

