function [history] = cuting_plan(f, g, x0, lb, ub)
%CUTING_PLAN cuting_plan
%   f: 目标函数
%   g: 约束函数（没有约束用[]代替）
%   x0: 初始迭代点
%   lb: 下界
%   ub: 上界

    % 变量储存定义
    % 储存每次迭代的x值
    history.X = [];
    history.X = [history.X, x0];
    % 迭代次数
    history.iter_num = 0;
    % 记录上界与下界
    history.U = [];
    history.L = [];
    
    % 迭代终止条件
    iter_epsilon = 10 ^ (-3);
    % 自变量个数
    num_var = size(x0, 1);
    % 符号化自变量，利于求导数
    x = sym('x', [1, num_var]);
    cell_x = num2cell(x);
    
    % 求目标函数的导数
    Gradient_f = gradient(f);
    
    % 求约束函数的导数
    Gradient_g = gradient(g);
    
    % 切平面的上界与下界
    % 切平面的最小上界
    U = double(subs(f, cell_x', x0));
    % 切平面的最大下界
    L = -inf;
    
    history.U = [history.U, U];
    history.L = [history.L, L];
    
    % 构建线性规划问题
%     A = double([[subs(Gradient_f, cell_x', x0)', -1]; ...
%                 [subs(Gradient_g, cell_x', x0)',  0]]);
%             
%     B = double([subs(Gradient_f, cell_x', x0)' * x0 - ...
%                subs(Gradient_f, cell_x', x0); ...
%                subs(Gradient_g, cell_x', x0)' * x0 - ...
%                subs(Gradient_f, cell_x', x0)]);
    A = build_A(Gradient_f, Gradient_g, x0, cell_x);
    B = build_B(Gradient_f, Gradient_g, f, g, x0, cell_x);
    % 线性规划表达式
    C0 = zeros(1, num_var);
    C = [C0, 1];
    
    % 线性规划的上下界
    LB = [lb, -inf];
    UB = [ub, inf];
    
    % 求解转化的切平面的线性规划问题
    while U - L > iter_epsilon
        % 记录迭代次数
        history.iter_num = history.iter_num + 1;
        
        % 利用 linprog 求解线性规划问题, x为最优解 w_k
        x = linprog(C, A, B, [], [], LB, UB);
        
        % 记录迭代的 x
        history.X = [history.X, x(1:num_var)];
        
        % 根据解出的最优解 x_k 再次构建线性规划进行求解
        x_k = x(1:num_var);
%         A = double([[subs(Gradient_f, cell_x', x_k)', -1]; ...
%                 [subs(Gradient_g, cell_x', x_k)',  0]]);
%             
%         B = double([subs(Gradient_f, cell_x', x_k)' * x_k - ...
%                     subs(Gradient_f, cell_x', x_k); ...
%                     subs(Gradient_g, cell_x', x_k)' * x_k - ...
%                     subs(Gradient_g, cell_x', x_k)]);
        A_k = build_A(Gradient_f, Gradient_g, x_k, cell_x);
        B_k = build_B(Gradient_f, Gradient_g, f, g, x_k, cell_x);
        A = [A; A_k];
        B = [B; B_k];
        % 更新下界 L 和上界 U
        L = x(num_var + 1);
        if subs(f,cell_x',x_k) < U
            U = double(subs(f,cell_x',x_k));
        end
        
        history.U = [history.U, U];
        history.L = [history.L, L];
        
    end
    
end

function  A = build_A(f, g, x0, x)
    if size(g) ~= 0
        A = double([[subs(f, x', x0)', -1]; ...
                    [subs(g, x', x0)',  0]]);
    else
        A = double([subs(f, x', x0)', -1]);
    end
end

function  B = build_B(g_f, g_g, f, g, x0, x)
    if size(g_f) ~= 0
        B = double([subs(g_f, x', x0)' * x0 - ...
                    subs(f, x', x0); ...
                    subs(g_g, x', x0)' * x0 - ...
                    subs(g, x', x0)]);
    else
        B = double(subs(g_f, x', x0)' * x0 - ...
                   subs(f, x', x0));
    end
end

