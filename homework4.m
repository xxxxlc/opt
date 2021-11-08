clear all;
%% 1
syms x1 x2;
f = (x1 - 3) ^ 4 + (x1 - 3 * x2) ^ 2;
H0 = [110, -6; -6, 18];
x0 = [0;0];
m = 2;
k = 20;
[X1, H1, F1, G1,HN1] = Newton(f,H0,x0,m,k);
[X2, H2, F2, G2,HN2] = LM(f,H0,x0,m,k);
[X3, H3, F3, G3,HN3] = BFGS(f,H0,x0,m,k);
[X4, H4, F4, G4,HN4] = DFP(f,H0,x0,m,k);

figure(1);
coordinate_x = 1:1:size(X1,2);
coordinate_y1 = X1;
coordinate_y2 = X2;
coordinate_y3 = X3;
coordinate_y4 = X4;
plot(coordinate_x, coordinate_y1(1:1,:), 'o-', 'linewidth', 2);
hold on;
plot(coordinate_x, coordinate_y1(2,:), 'o-', 'linewidth', 2);
% xlim([0 6]);
ylim([0,5]);
xlabel('迭代次数');
ylabel('X');
title('Newton');
grid on;
legend('x1','x2');

figure(2);
plot(coordinate_x, coordinate_y2(1:1,:), 'o-', 'linewidth', 2);
hold on;
plot(coordinate_x, coordinate_y2(2,:), 'o-', 'linewidth', 2);
% xlim([0 6]);
ylim([0,5]);
xlabel('迭代次数');
ylabel('X');
title('LM');
grid on;
legend('x1','x2');

figure(3);
plot(coordinate_x, coordinate_y3(1:1,:), 'o-', 'linewidth', 2);
hold on;
plot(coordinate_x, coordinate_y3(2,:), 'o-', 'linewidth', 2);
% xlim([0 6]);
ylim([0,5]);
xlabel('迭代次数');
ylabel('X');
title('BFGS');
grid on;
legend('x1','x2');

figure(4);
plot(coordinate_x, coordinate_y4(1:1,:), 'o-', 'linewidth', 2);
hold on;
plot(coordinate_x, coordinate_y4(2,:), 'o-', 'linewidth', 2);

% xlim([0 6]);
ylim([0,5]);
xlabel('迭代次数');
ylabel('X');
title('DFP');
grid on;
legend('x1','x2');
%% 2
clear all;
N = 20;

[x_golden, y_golden] = golden_search(@func1, [0, 8], N);
[x_fib, y_fib] = fibonacci_search(@func1, [0, 8], N);
[x_fix, y_fix] = fixed_step(@func1, [0, 8], N, 1);
figure(5);
num_iter = 1:1:size(x_golden, 2);
plot(num_iter, x_golden, 'o-', 'linewidth', 2);
hold on;
plot(num_iter, y_golden, 'o-', 'linewidth', 2);
xlabel('迭代次数');
title('Golden_search ');
grid on;
legend('x_golden','y_golden');

figure(6);
num_iter = 1:1:size(x_fib, 2);
plot(num_iter, x_fib, 'o-', 'linewidth', 2);
hold on;
plot(num_iter, y_fib, 'o-', 'linewidth', 2);
xlabel('迭代次数');
title('Fibonacci ');
grid on;
legend('x_golden','y_golden');

figure(7);
num_iter = 1:1:size(x_fix, 2);
plot(num_iter, x_fix, 'o-', 'linewidth', 2);
hold on;
plot(num_iter, y_fix, 'o-', 'linewidth', 2);
xlabel('迭代次数');
title('fixed step');
grid on;
legend('x_golden','y_golden');

function [y] = func1(x)
    y = -min([x ./ 2, 2 - (x - 3) .^ 2, 2 - x ./ 2], [], 2);
end