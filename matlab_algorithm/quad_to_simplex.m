function [A0, b0, c0, x0] = quad_to_simplex(H, c, A, b)
%KKT 根据KKT条件转化二次函数为单纯形的线形规划
% Ax  + u1 = b   
% Hx + A'T - mu + u2 = -c
% x, mu, u1, u2 > 0
% x' mu = 0
    [m_A, n_A] = size(A);
    [m_H, n_H] = size(H);
    matrix01 = zeros(m_A, m_A);
    
    I_A = eye(m_A);
    I_H = eye(m_H);
    
    matrix02 = zeros(m_A, m_H);
    matrix03 = zeros(m_A, m_H);
    matrix04 = zeros(m_H, m_A);
    
    A0 = [A matrix01 matrix02 I_A matrix03;
          H A' -I_H matrix04 I_H];
    
    b0 = [b; -c];
    
    c0 = [zeros(1, size(A, 2) + size(matrix01, 2) + size(matrix02, 2)), ...
          ones(1, size(I_A, 2) + size(matrix03, 2))]';

end

