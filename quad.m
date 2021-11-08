clear all;

%% 优化问题
H = [2, 0; 0, 2];                                                          % 二次目标项
f = [-2; -5];                                                              % 线性目标项

A = [-1, 2; 1, 2; 1, 2];                                                   % 线性不等式约束
b = [2; 6; 2];
Aeq = [];                                                                  % 线性等式约束
beq = [];
lb = [0,0];                                                                % 变量下限
ub = [];                                                                   % 变量上限
x0 = [0,0];
algorithm = 'active-set';

options = optimoptions('quadprog',  ...                                    % 选择算法 'interior-point-convex',
                       'Algorithm',algorithm, ...       
                       'MaxIter', 200, ...
                       'Display','iter');                                  % 'trust-region-reflective' 'active-set'
[x,fval,exitflag,output,lambda] = ...
                quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,options)
            
% output
% x：解
% fval：解处的目标函数值
% exitflag - quadprog：停止的原因
% output：有关优化过程的信息
% lambda：解处的拉格朗日乘数

% 迭代器意义
% Primal Infeas：原始不可行性
% Dual Infeas：对偶不可行性
% Complementarity：非活动不等式的拉格朗日乘数的最大绝对值的度量


% 获取迭代的解
nIter = output.iterations;
X = [];
for i = 1:1:nIter
    options = optimoptions('quadprog',  ...                                
                       'Algorithm',algorithm, ...       
                       'MaxIter', i, ...
                       'Display','iter'); 
    [x,fval,exitflag,output,lambda] = ...
                quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,options)
    X = [X,x];
end

%% 画图
figure(1);
coordinate_x = 1:1:size(X,2);
coordinate_y = X;
plot(coordinate_x, coordinate_y(1:1,:), 'o-', 'linewidth', 2);
hold on;
plot(coordinate_x, coordinate_y(2,:), 'o-', 'linewidth', 2);
% xlim([0 6]);
ylim([0,1]);
xlabel('迭代次数');
ylabel('f(x)');
title('interior-point-convex');
grid on;
legend('x1','x2');