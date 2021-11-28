function [x, fval, history] = dual_simplex(f,A,b,Aeq,beq,lb,ub)
%MODIFIEDSIMPLEX 单纯型法

    
    % 设置求解器 
    options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');
    [x, fval] = linprog(f,A,b,Aeq,beq,lb,ub,options);

end

