function [x, fval, history] = simplex(c, Aeq, beq)
%SIMPLEX 此处显示有关此函数的摘要
%   Ax = b
%   f(x) = c' x
    
%     history.B = [];
%     history.N = [];
%     history.x_index_B = [];
%     history.x_index_N = [];
%     history.x_B = [];
%     history.x_N = [];
%     history.c_B = [];
%     history.c_N = [];
%     history.z0 = [];
%     history.p = [];
%     history.y = [];
    
    shape = size(Aeq);
    row = shape(1);
    col = shape(2);
    
    x = zeros(1, col);
    x_index_B = 1:1:row;
    x_index_N = 1:1:col - row;
    x_index_N = x_index_N + row;
    
    B = Aeq(1:row, 1:row);
    N = Aeq(1:row, row + 1:col);
    
    c_N = c(row + 1:col);
    c_B = c(1:row);
    
    while(1)
        x_N = zeros(col - row, 1);
        x_B = B \ beq - B \ N * x_N;


        z0 = c_B' * inv(B) *  beq;
        p = (c_N' - c_B' * inv(B) * N)';
        
        change_col_N = 0;
        change_value = 0;
        for i = 1:1:size(p, 1)
            if p(i) < change_value
                change_col_N = i;
                change_value = p(i);
            end
        end
        
        % 储存 history
%         history.B = [history.B, B];
%         history.N = [history.N, N];
%         history.x_index_B = [history.x_index_B, x_index_B];
%         history.x_index_N = [history.x_index_N, x_index_N];
%         history.x_B = [history.x_B, x_B];
%         history.x_N = [history.x_N, x_N];
%         history.c_B = [history.c_B, c_B];
%         history.c_N = [history.c_N, c_N];
%         history.z0 = [history.z0, z0];
%         history.p = [history.p, p];
        
        
        % 找到最优解
        if change_col_N == 0
            break
        end
        
        % p中仍然有小于 0 的值存在
        y = B \ N(:, change_col_N);
        temp = x_B ./ y;
        [~, change_col_B] = min(temp);
        
%         history.y = [history.y, y];
        
        % 交换 B 中 N 中的一列
        temp = B(:, change_col_B);
        B(:, change_col_B) = N(:, change_col_N);
        N(:, change_col_N) = temp;
        
        temp = c_B(change_col_B);
        c_B(change_col_B) = c_N(change_col_N);
        c_N(change_col_N) = temp;
        
        temp = x_index_B(change_col_B);
        x_index_B(change_col_B) = x_index_N(change_col_N);
        x_index_N(change_col_N) = temp;
        
        
    end
    
    
    for i = 1:1:row
        x(x_index_B(i)) = x_B(i); 
    end
    
    for j = 1:1:col
        x(x_index_N(i)) = x_N(i);
    end
    
    fval = z0;


end

