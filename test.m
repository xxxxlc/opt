%% 分支定界
% 
% clear all
% clc
%  
% A = [9 7;7 20];
% b = [56 70];
% c = [-40,-90];%标准格式是求min，此题为max，需要转换一下
%  
% lb = [0; 0];%x值的初始范围下界
% ub=[inf;inf];%x值的初始范围上界
% 
% optX = [0; 0];%存放最优解的x，初始迭代点(0,0)
% optVal = 0;%最优解
% [x, fit, exitF, iter] = branch_and_bound(c,A, b,[], [], lb, ub, optX, optVal, 0)

%% 单纯形
A = [1 0 1 1;
    0 1 0.1 0.2];

c = [0; 0; -20; -30];

b = [100; 14];

[x, fval] = simplex(c, A, b);
