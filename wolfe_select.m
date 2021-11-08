function [alpha_pre] = wolfe_select(f, x_k, p_k, m)
%WOLFE_SELECT 使用 Wolfe 条件选择当前下降步长 alpha
%   此处显示详细说明
    x_var = sym('x',[1, m]);
    c = num2cell(x_var);
    g_var = sym('x', [m, 1]);
    
    for n = 1:1:m
        g_var(n) = diff(f, x_var(n));
    end
    
    c1 = 0.001;
    c2 = 0.2;

%     for alpha = 0.1:-0.001:0
%         f_val1 = subs(f, c, {(x_k - alpha * p_k)'});
%         f_val2 = subs(f, c, {x_k'}) - c1 * alpha * subs(g_var, c, {x_k'})' * p_k;
%         f_grad1 = subs(g_var, c, {(x_k - alpha * p_k)'})' * p_k;
%         f_grad2 = c2  * subs(g_var, c, {x_k'})' * p_k;
%         if f_val1 <= f_val2 && f_grad1 >= f_grad2
%             alpha_pre = alpha;
%             break;
%         end
%     end

    alpha_r = 1;
    alpha_l = 0;
    while (1)
        alpha = (alpha_r + alpha_l) / 2; 
        f_val1 = subs(f, c, {(x_k - alpha * p_k)'});
        f_val2 = subs(f, c, {x_k'}) - c1 * alpha * subs(g_var, c, {x_k'})' * p_k;
        f_grad1 = subs(g_var, c, {(x_k - alpha * p_k)'})' * p_k;
        f_grad2 = c2  * subs(g_var, c, {x_k'})' * p_k;
        if f_val1 <= f_val2 && f_grad1 >= f_grad2
            alpha_pre = alpha;
            break;
        end
        alpha_r = 0.8 * alpha_r;
    end

end

