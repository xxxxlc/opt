function [xstar, fxstar, flagOut, iter] = branch_and_bound(c, A, b, Aeq, Beq, lb, ub, optXin, optF, iter)
%BRANCH_AND_BOUND 分支定界
%   此处显示详细说明
%   A: 不等式约束系数矩阵
%   b: 不等式约束常数向量
%   c: 目标函数系统向量
%   Aeq: 等式约束系数矩阵
%   Beq: 等式约束常数向量
%   lb: 下界
%   ub: 上界
%   optXin: 每次迭代的最优 x
%   optF: 每次迭代最优的 f
%   iter: 迭代次数
    
    % 定义最优解为全局变量
    global optX optVal optFlag

    iter = iter + 1;
    
    % 更新迭代得到的值
    optX = optXin;
    optVal = optF;
    
    
    % 利用 linprog 求解线性回归
    [x, fit, status] = linprog(c, A, b, Aeq, Beq, lb, ub, []);
    
    % status 返回算法迭代停止的原因
    % status = 1 算法收敛于解 x ，即 x 是线性规划的最优解
    
    % 没有找到最优解，停止该分支的迭代
    if status ~= 1
        xstar = x;
        fxstar = fit;
        flagOut = status;
        return;
    end
    
    % 找到的函数的最优解仍不是整数解
    if max(abs(round(x) - x)) > 1e-3
        % 如果函数值小于之前解的值， 返回函数的解
        if fit > optVal
            xstar = x;
            fxstar = fit;
            flagOut = -100;
        end
    % 其他情况就是得到的函数最优解为整数解，此分支结束，不再继续向下求解
    else
        % 此时函数如果小于之前的值就保留
        if fit > optVal
            xstar = x;
            fxstar = fit;
            flagOut = -100;
        % 放入全局变量暂时存放
        else
            optVal = fit;
            optX = x;
            optFlag = status;
            xstar = x;
            fxstar = fit;
            flagOut = status;
            return;
        end      
    end
    
    % 求的 x 对应的小数部分
    midX = abs(round(x)- x);
    
    % 得到非整数的 x 的索引值
    notIntV = find(midX > 1e-3);
    
    % 得到第一个非整数 x 的索引值
    pXidx = notIntV(1);
    
    templb = lb;
    tempub = ub;
    
    % 原上界大于此时找到的分界位置值
    if ub(pXidx) >= fix(x(pXidx)) + 1
        % 将这个分界值作为新的下界参数传入
        templb(pXidx) = fix(x(pXidx)) + 1;
        [~,~,~] = branch_and_bound(c, A, b, Aeq, Beq, templb, ub, optX, optVal, iter + 1);
    end
    
    % 下界同理
    if lb(pXidx) <= fix(x(pXidx))
        tempub(pXidx) = fix(x(pXidx));
        [~, ~, ~] = branch_and_bound(c,A, b, Aeq, Beq, lb, tempub, optX, optVal, iter + 1);
    end
    
    xstar = optX;
    fxstar = optVal;
    flagOut = optFlag;

end

