function [xsol ,fval ,history ,searchdir] = runfmincon(x0)
    % Set up shared variables with outfun
    history.x = [];
    history.fval = [];
    searchdir = [];
    
    % Call optimization
%     x0 = [0.1 0.1];% 和参考文档不太一样
    options = optimoptions(@fmincon ,'OutputFcn',@outfun ,...
                           'Display','iter','Algorithm','interior-point');
    [xsol ,fval] = fmincon(@objfun ,x0,[],[],[],[],[],[],@confun ,...
                            options);
                            
    function stop = outfun(x,optimValues,state)
        stop = false;
 
         switch state
             case 'init'
                 hold on
             case 'iter'
             % Concatenate current point and objective function
             % value with history. x must be a row vector.
               history.fval = [history.fval; optimValues.fval];
               history.x = [history.x; x];
%                disp(history.x);
             % Concatenate current search direction with 
             % searchdir.
%                searchdir = [searchdir;... 
%                             optimValues.searchdirection'];
%                plot(x(1),x(2),'o');
%              % Label points with iteration number and add title.
%              % Add .15 to x(1) to separate label from plotted 'o'.
%                text(x(1)+.15,x(2),... 
%                     num2str(optimValues.iteration));
%                title('Sequence of Points Computed by fmincon');
             case 'done'
                 hold off
             otherwise
         end
    end

    function f = objfun(x)
         f = -x(1) * x(2);
    end

    function [c, ceq] = confun(x)
        % Nonlinear inequality constraints
        c = [x(1)^2 + x(2)^2 - 1];
        % Nonlinear equality constraints
        ceq = [];
    end
end


