function  [x,fval,exitflag,output,population,scores] = genetic_algorithm(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon)
%GENETIC_ALGORITHM 
%   调用 ga 工具箱并画图
    
    % 配置优化器
    options = optimoptions('ga','ConstraintTolerance',1e-6,'PlotFcn', ...
                       {@gaplotbestf, @gaplotbestindiv});
    
    [x,fval,exitflag,output,population,scores] = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);
   
    
end

