function  plot3D(f, g, N, lb, ub, i, X, leg)
%PLOT3D 画出函数图像，以及迭代轨迹
%   f:  目标函数 
%   g:  约束函数
%   N:  划分网格数目
%   lb: 下界
%   ub: 上界
%   i:  第i幅图
%   X:  x1,x2
%   leg:图例
%
    
    % 自变量个数，可以直接为2，因为自变量个数为2，才能画3D
    %num_var = size(x0, 1);
    num_var = 2;
    % 符号化自变量
    x = sym('x', [1, num_var]);
    cell_x = num2cell(x);
    
    % plot
    xn1 = linspace(lb(1), ub(1), N);
    xn2 = linspace(lb(2), ub(2), N);
    
    % 产生网格
    [X1, X2] = meshgrid(xn1, xn2);
    
    % 计算 z 值
    for i = 1:1:size(X1, 1)
        for j = 1:1:size(X2, 1)
            if double(subs(g, cell_x, [X1(i, j), X2(i, j)])) > 0
                z(i ,j) = NaN;
            else
                z(i ,j) = double(subs(f, cell_x, [X1(i, j),X2(i, j)]));
            end
        end
    end
    
    figure(i)
    surf(X1, X2, z);
    
    figure(i+1)
    contour(X1, X2, z, 100);
    hold on;
    x_iter1 = X(1, :);
    x_iter2 = X(2, :);
    num_iter1 = 1:1:size(x_iter1, 1);
    num_iter2 = 1:1:size(x_iter2, 1);
    h1 = plot(num_iter1, x_iter1(:,1), 'o-', 'linewidth', 2);
    hold on;
    h2 = plot(num_iter2, x_iter2(:,1), 'o-', 'linewidth', 2);
    title('两种情况下x1的迭代情况');
    legend(leg);
    
end

