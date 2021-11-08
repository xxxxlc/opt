function [Lmin_iter, Umin_iter, x_iter] = cutplane(f, m, domain)
%CUTPLANE 此处显示有关此函数的摘要
%   此处显示详细说明
    Lmin_iter = [];
    Umin_iter = [];
    x_iter = [];
    while(abs(domain(2) - domain(1)) > 0.0001)
        % 取 x_k
        x_k = [domain(1) + (domain(2) - domain(1)) / 4; ...
               domain(1) + (domain(2) - domain(1)) * 2 / 4;
               domain(1) + (domain(2) - domain(1)) * 3 / 4
               ];
        x1 = sym('x', [1, m]);
        c = num2cell(x1);
        g1 = sym('x',[m, 1]);
        [Umin, xumin] = min(subs(f,c,{x_k}));
        for n = 1:m
            g1(n) = diff(f,x1(n));
        end

        G = subs(g1,c,{x_k});

        % f(x1) + g1(x1)(x - x1)

        t = linspace(domain(1),domain(2),100);
        Lmin = 99;
        for i = 1:1:size(t, 2)
            if Lmin > fmax(t(i))
                Lmin = fmax(t(i));
                t_min = t(i);
            end
%             Lmin = min(Lmin, fmax(t(i)));
        end
        
        Lmin_iter = [Lmin_iter, Lmin];
        Umin_iter = [Umin_iter, Umin];
      
        
        if t_min < x_k(xumin)
            domain(1) = t_min;
            domain(2) = x_k(xumin);
        else
            domain(1) = x_k(xumin);
            domain(2) = t_min;
        end
        x_iter = [x_iter;domain];
    end
    

    
    function y = fmax(x)
        y = max([subs(f, c, x_k(1)) + subs(G(1,:), c, x) .* (x - x_k(1)), ...
                subs(f, c, x_k(2)) + subs(G(2,:), c, x) .* (x - x_k(2)), ...
                subs(f, c, x_k(3)) + subs(G(3,:), c, x) .* (x - x_k(3))]);
    end

end

