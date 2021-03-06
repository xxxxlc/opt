clear all

%% 优化
Aeq = [
    -1  2  1  0  0   1  0  0    0  0  0  0  0   0  0  0   0  0  0  0  0;
     1  2  0  1  0   0  1  0    0  0  0  0  0   0  0  0   0  0  0  0  0;
     1  2  0  0  1   0  0  1    0  0  0  0  0   0  0  0   0  0  0  0  0;
     
     2  0  0  0  0   0  0  0   -1  0  0  0  0  -1  1  1   1  0  0  0  0;
     0  2  0  0  0   0  0  0    0 -1  0  0  0   2  2  2   0  1  0  0  0;
     2  0  0  0  0   0  0  0    0  0 -1  0  0   1  0  0   0  0  1  0  0;
     0  2  0  0  0   0  0  0    0  0  0 -1  0   0  1  0   0  0  0  1  0;
     2  0  0  0  0   0  0  0    0  0  0  0 -1   0  0  1   0  0  0  0  1;
    ];
beq = [
    2;
    6;
    2;
    
    2;
    5;
    0;
    0;
    0;
    ];

f = [0  0  0  0  0    1  1  1    0  0  0  0  0    0  0  0    1  1  1  1  1]';

m = size(Aeq, 2);
lb = zeros(m,1);
options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');
%%[x, fval, exitflag, output]= linprog(f,[],[],Aeq,beq,lb,[],options);
%% 画图
[x, fval]= dual_simplex(f,[],[],Aeq,beq,lb,[]);