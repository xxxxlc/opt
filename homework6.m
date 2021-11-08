clear all;
% [xsol,fval,history,searchdir] = runfmincon;

syms x1 x2
f = (x1 - 9 / 4) ^ 2 + (x2 - 2) ^ 2 - ...
    0.1 * log ( - (x1 ^ 2 - x2)) - ...
    0.1 * log ( - (x1 + x2 - 6));

H0 = [];
x0 = [0.1, 0.1];
m = 2;
k = 10;

[X1, H1, F1, G1,HN1] = Newton(f,H0,x0,m,k);
[X3, H3, F3, G3,HN3] = BFGS(f,H0,x0,m,k);
coordinate_x = 1:1:size(X1,2);
coordinate_y1 = X1;
plot(coordinate_x, coordinate_y1(1:1,:), 'o-', 'linewidth', 2);
hold on;
plot(coordinate_x, coordinate_y1(2,:), 'o-', 'linewidth', 2);
% xlim([0 6]);
ylim([0,5]);
xlabel('迭代次数');
ylabel('X');
% title('Newton');
title('Newton');
grid on;
legend('x1','x2');
