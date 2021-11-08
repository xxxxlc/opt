clear all;

%% 约束图像
xn1 = linspace(-1, 1, 1000);
xn2 = linspace(-1, 1, 1000);
[X1, X2] = meshgrid(xn1, xn2);
z = -X1 .* X2;
for i = 1:1:size(X1, 1)
    for j = 1:1:size(X2, 1)
        if 1 - X1(i, j)^2 - X2(i, j)^2 < 0
            z(i ,j) = NaN;
        end
    end
end
figure(1)
surf(X1, X2, z);

figure(3)

% ct = contour(X1, X2, z, 100,'ShowText','on','LabelSpacing',2880);
ct = contour(X1, X2, z, 100);
hold on

%% 内点法
% x0 = [0.1, 0.1];
% A = [];
% b = [];
% Aeq = [];
% beq = [];
% lb = [];
% ub = [];
% algorithm = 'interior-point';
% options = optimoptions('fmincon',  ...                                    % 选择算法 'interior-point-convex',
%                        'Algorithm',algorithm, ...       
%                        'MaxIter', 200, ...
%                        'Display','iter'); 
% nonlcon = @c;
% x = fmincon(@f,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
% 
% function y = f(x)
%     y = -x(1) * x(2);
% end
% 
% function [c, ceq] = c(x)
%     c = x(1)^2 + x(2)^2 - 1;
%     ceq = [];
% end

%%
x0 = [0.1, 0.1];
[xsol1 ,fval1 ,history1 ,searchdir1] = runfmincon(x0);
x0 = [-0.1, -0.1];
[xsol2 ,fval2 ,history2 ,searchdir2] = runfmincon(x0);
x_iter1 = history1.x;
y_iter1 = history1.fval;
x_iter2 = history2.x;
y_iter2 = history2.fval;
num_iter1 = 1:1:size(x_iter1, 1);
num_iter2 = 1:1:size(x_iter2, 1);
subplot(2,2,1)
h1 = plot(num_iter1, x_iter1(:,1), 'o-', 'linewidth', 2);
hold on;
h2 = plot(num_iter2, x_iter2(:,1), 'o-', 'linewidth', 2);
title('两种情况下x1的迭代情况');
legend('[0.1,0.1]','[-0.1,-0.1]');

subplot(2,2,2)
h1 = plot(num_iter1, x_iter1(:,2), 'o-', 'linewidth', 2);
hold on;
h2 = plot(num_iter2, x_iter2(:,2), 'o-', 'linewidth', 2);
title('两种情况下x2的迭代情况');
legend('[0.1,0.1]','[-0.1,-0.1]');

subplot(2,2,3)
h1 = plot(num_iter1, y_iter1, 'o-', 'linewidth', 2);
hold on;
h2 = plot(num_iter2, y_iter2, 'o-', 'linewidth', 2);
title('两种情况下val的迭代情况');
legend('[0.1,0.1]','[-0.1,-0.1]');

subplot(2,2,4)
ct = contour(X1, X2, z, 100);
hold on
h1 = plot(x_iter1(:,1), x_iter1(:,2), 'o-', 'linewidth', 2);
hold on;
h2 = plot(x_iter2(:,1), x_iter2(:,2), 'o-', 'linewidth', 2);
title('等值线下两种x迭代情况');
legend('等值线','[0.1,0.1]','[-0.1,-0.1]');

%% 切平面法
clear all;

syms x1
f = - x1 * sqrt(1 - x1 ^ 2);

[Lmin_iter, Umin_iter, x_iter] = cutplane(f, 1, [0,1]);




%% plot
figure(4)
num_iter = 1:1:size(x_iter, 1);
h1 = plot(num_iter, x_iter(:, 1), 'o-', 'linewidth', 2);
hold on;
h1 = plot(num_iter, x_iter(:, 2), 'o-', 'linewidth', 2);
title('切平面上下界L,U迭代情况');
legend('L','U');
% function y = f(x)
%     y = x * sqrt(1 - x ^ 2);
% end