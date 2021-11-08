clear all;

syms x1 x2
f = (x1 - 2) ^ 2 + 4 * (x2 - 3) ^ 2;

x0 = [0; 0];

[x_steepest_dscent, y_steepest_dscent, grad, norm, alpha] = steepest_descent(f,...
                                                            x0, ...
                                                            [-999, 999],... 
                                                            60, 2);
                                     
subplot(2,2,1)
num_iter = 1:1:size(x_steepest_dscent, 2);
plot(num_iter, x_steepest_dscent(1, :), 'o-', 'linewidth', 2);
hold on;
plot(num_iter, x_steepest_dscent(2, :), 'o-', 'linewidth', 2);
xlabel('迭代次数');
title('x1, x2');
grid on;
legend('x1','x2');


xn1 = linspace(0, 4);
xn2 = linspace(0, 4);
[X1, X2] = meshgrid(xn1, xn2);
z = (X1 - 2) .^ 2 + 4 * (X2 - 3) .^ 2;
subplot(2,2,2)
surf(X1, X2, z);
subplot(2,2,3)
contour(X1, X2, z, 100);
hold on;
plot(x_steepest_dscent(1, :), x_steepest_dscent(2, :), 'o-', 'linewidth', 2);
subplot(2,2,4)
num_iter = 1:1:size(alpha, 2);
plot(num_iter, alpha, 'o-', 'linewidth', 2);