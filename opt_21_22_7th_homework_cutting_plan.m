%f表示目标函数
%g表示约束条件
%g_f表示f的梯度
%g_g表示g的梯度
clc;
clear;
iter_epsilon = 10^(-10);%迭代终止条件
x1 = sym('x',[1,2]);
x0 = [0.04; 0];
c = num2cell(x1);
f = -0.25*(x1(1) - x1(2)^2);
g = (x1(1) + x1(2)^2)/2 - 1;
g_f = gradient(f);
g_g = gradient(g);
X = [];%存储每次迭代的x值
X = [X,x0];
m = 2;%变量的个数
U = double(subs(f,c',x0));%切平面法的最小上界
L = -inf;%切平面法的最大下界
A0 = [[subs(g_f, c', x0)', -1];[subs(g_g, c',x0)', 0]];
B0 = [subs(g_f, c', x0)'*x0 - subs(f, c', x0); subs(g_g, c', x0)'*x0 - subs(g, c', x0)];

A = double(A0);
B = double(B0);
C = [0;0;1];%线性规划的表达式
LB = [0,-2, -inf];%化成的线性规划的下界分别对应u1 u2 L_k 下同
UB = [2, 2, inf];%化成的线性规划的上界
k = 0;
while U - L > iter_epsilon
    k = k+1
    x = linprog(C,A,B,[],[],LB,UB);
    X = [X,x(1:m)];
    A0 = [[subs(g_f, c', x(1:m))', -1];[subs(g_g, c',x(1:m))', 0]];
    B0 = [subs(g_f, c', x(1:m))'*x(1:m) - subs(f, c', x(1:m)); subs(g_g, c', x(1:m))'*x(1:m) - subs(g, c', x(1:m))];
    A = double([A; A0]);
    B = double([B; B0]);
    L = x(m + 1);
    if subs(f,c',x(1:m)) < U
        U = double(subs(f,c',x(1:m)));
    end
end
