function [outputArg1,outputArg2] = active_set(x0, H, g, A, b)
%ACTIVE_SET 有效集具体计算步骤
%   此处显示详细说明
    
    b_c = A * x0 - b;
    
    % 起作用的约束
    w = [];
    w_iter = [];
    for i = 1:1:size(b, 1)
        if b_c(i) == 0
            w = [w, i];
            w_iter = [w_iter, i];
        end
    end
    
    % 构造并求解等式约束二次规划问题
    while(1)
        A0 = [];
%         b0 = [];
        for i = 1:1:size(w, 2)
            A0 = [A0; A(w(i), :)];
%             b0 = [b0; b(w(i), :)];
        end
        b0 = zeros(size(A0, 1), 1);
        p_k = quadprog(H,g,[],[],A0,b0,[],[],[0 0]');

        if p_k == 0
            % 不满足条件，去掉约束继续计算
            lambda = A0' \ (H * x0 + g);
            if lambda > 0
                break
            end
            [~, min_index] = min(lambda);
            w(min_index) = [];
            continue
        else
            % 满足条件，计算 alpha
            alpha_all = [];
            for i = 1:1:size(b, 1)
                if isempty(find(w_iter==i))
                    temp = A(i, :) * p_k;
                    if temp < 0
                        temp1 = (b(i, :) - A(i, :) * x0) / temp;
                        alpha_all = [alpha_all, temp1];
                    end
                end
            end
            alpha_k = min(1, min(alpha_all));
        end
        x0 = x0 + alpha_k * p_k;
        b_c = A * x0 - b;
        
        w = [];
        w_iter = [];
        for i = 1:1:size(b, 1)
            if b_c(i) == 0
                w = [w, i];
                w_iter = [w_iter, i];
            end
        end
    end
            

    
end

