%f��ʾĿ�꺯��
%g��ʾԼ������
%g_f��ʾf���ݶ�
%g_g��ʾg���ݶ�
clc;
clear;
iter_epsilon = 10^(-10);%������ֹ����
x1 = sym('x',[1,2]);
x0 = [0.04; 0];
c = num2cell(x1);
f = -0.25*(x1(1) - x1(2)^2);
g = (x1(1) + x1(2)^2)/2 - 1;
g_f = gradient(f);
g_g = gradient(g);
X = [];%�洢ÿ�ε�����xֵ
X = [X,x0];
m = 2;%�����ĸ���
U = double(subs(f,c',x0));%��ƽ�淨����С�Ͻ�
L = -inf;%��ƽ�淨������½�
A0 = [[subs(g_f, c', x0)', -1];[subs(g_g, c',x0)', 0]];
B0 = [subs(g_f, c', x0)'*x0 - subs(f, c', x0); subs(g_g, c', x0)'*x0 - subs(g, c', x0)];

A = double(A0);
B = double(B0);
C = [0;0;1];%���Թ滮�ı��ʽ
LB = [0,-2, -inf];%���ɵ����Թ滮���½�ֱ��Ӧu1 u2 L_k ��ͬ
UB = [2, 2, inf];%���ɵ����Թ滮���Ͻ�
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
