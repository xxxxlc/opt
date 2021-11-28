clear all;

%% 模拟退火
options = saoptimset('OutputFcn',@outfun,'Display', 'iter', 'PlotFcns',{
    @saplotbestf, @saplotf, @saplotbestx, @saplotx, ...
    @saplottemperature});
lb = 0;
lu = 1;
x0 = 1;
global history
history.x = [];
history.t = [];
[x, fval, exitflag, output] = simulannealbnd(@fun1, x0, lb, lu, options);

x_domain = 0:0.001:1;
y = fun1(x_domain);
figure(2);
plot(x_domain, y);
xlabel('x');
ylabel('f(x)');
title('函数图像');

x_iter = 1:1:size(history.x, 2);
figure(3);
plot(x_iter, history.t);
title('temperature function');
figure(4);
plot(x_iter, history.x);
title('current iteration point');
%% 遗传算法
clear all;
x1_domain = linspace(-6, 6, 200);
x2_domain = linspace(-6, 6, 200);
[X1, X2] = meshgrid(x1_domain, x2_domain);
for i = 1:1:size(X1, 1)
    for j = 1:1:size(X1, 2)
        z(i, j) = func2([X1(i, j), X2(i, j)]);
    end
end
figure(5)
surf(X1, X2, z);
figure(6)
ct = contour(X1, X2, z, 100);
options = optimoptions('ga','ConstraintTolerance',1e-6,'PlotFcn', ...
                       {@gaplotbestf, @gaplotbestindiv, ...
                       @gaplotexpectation, @gaplotrange, ...
                       @gaplotdistance, @gaplotgenealogy, ...
                       @gaplotselection, @gaplotscorediversity, ...
                       @gaplotscores, @gaplotstopping});
x = ga(@func2, 2, [], [], [], [], [-6 0], [0 6], [],options);
%%
genetic_algorithm(@func2, 2, [], [], [], [], [-6 0], [0 6], []);

%% 求解函数
function y = fun1(x)
    y = -exp(-2 .* log(2) .* ((x - 0.008) ./ 0.854)) ...
        .* (sin(5 .* pi .* (x .^ 0.75 - 0.05))) .^ 6;
end

function y = func2(x)
    y = (2186 - (x(1) .^ 2 + x(2) - 11) .^ 2 ...
        - (x(1) + x(2) .^ 2 - 7) .^ 2) ./ 2186;  
end

function [stop, optnew, changed] = outfun(x,optold,state)
    stop = false;
    optnew = optold;
    changed = false;
    switch state
        case 'init'
              % Setup for plots or dialog boxes
        case 'iter'
              % Make updates to plots or dialog boxes as needed
              global history
              history.x = [history.x, optold.x];
              history.t = [history.t, optold.temperature];
        case 'interrupt'
              % Check conditions to see whether optimization 
              % should quit
        case 'done'
              % Cleanup of plots, dialog boxes, or final plot
    end
end