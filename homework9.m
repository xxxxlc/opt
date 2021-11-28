clear all;
%%
u = [0 1];

k = 5;

y = zeros(1, 5);
J = zeros(1, 5);
y_s = [0.5];
treeVec_val = [0.5];
for i = 1:1:5
    if i == 1
        y_set = y_s;
    else
        y_set = y_iter;
    end
    y_iter = [];
    for j = 1:1:size(u, 2)
        for k = 1:1:size(y_set, 2)
            y = y_set(1, k);
            [temp_J, temp_y] = f(y, u(j));
            treeVec_val = [treeVec_val, temp_J];
            y_iter = [y_iter temp_y];
            y_s = [y_s, temp_y];
        end
    end
end

treeVec = generateTree(5);
treeplot(treeVec);
% count = size(treeVec,2);
[x,y] = treelayout(treeVec);
x = x';
y = y';
name1 = cellstr(num2str((y_s)'));
text(x(:,1),y(:,1),name1,'VerticalAlignment','bottom','HorizontalAlignment','right', 'fontsize', 6);


%%
u = [0 1];
num_iter = 3;
n = 1;

y_val = [0.5];
J_val = [];
global opt_val
opt_val = 0;
global tree
tree = [];
global J_f

dfs(3, 0, 0.5, [1 0], [], 0);

%%
treeVec = [0 1 2 3 3 2 6 6 1 9 9];
treeplot(treeVec);
[x,y] = treelayout(treeVec);
x = x';
y = y';
name1 = cellstr(num2str((J_f)'));
text(x(:,1),y(:,1),name1,'VerticalAlignment','bottom','HorizontalAlignment','right', 'fontsize', 6);

%% 
x = fmincon(@f2, [0,0,0],[],[],[],[],[0 0 0],[1 1 1]);

%%
function [J, y] = f(y1, u)
    lambda = 0.01;
    r = 1;
    a = 0.9;
    b = 0.1;
    y = 0.9 * y1 + 0.1 * u;
    J = (y - r) ^  2 + lambda * u ^ 2;
end

function treeVec = generateTree(depth)
    treeVec = [0];
    for i = 1:1:2 ^ (depth) - 1
        treeVec = [treeVec i i];
    end
end

function [J, y] = f1(y1, u, J1)
    lambda = 0.01;
    r = 1;
    a = 0.9;
    b = 0.1;
    y = a * y1 + b * u;
    J = (y - r) ^  2 + lambda * u ^ 2 + J1;
end

function J = f2(U)
    [J, temp_y] = f1(0.5, U(1), 0);
    for i = 2:1:size(U, 2)
        [J, temp_y] = f1(temp_y, U(i), J);
    end
end

function dfs(depth, J_pre, y_pre, u, u_arr, tree_index)
    global opt_val
    global tree
    global J_f
    J_f = [J_f, J_pre];
    tree = [tree,  tree_index];
    if depth == 0
        if opt_val == 0
            opt_val = J_pre;
            disp(u_arr)
            return;
        else
            if J_pre < opt_val
                opt_val = J_pre;
                disp(u_arr)
                return;
            else
                disp(u_arr)
                return;
            end
        end
    end
    
    if opt_val ~= 0 && J_pre > opt_val
       disp(u_arr)
       return;
    end
    
    for i = 1:1:size(u, 2)
        u_arr = [u_arr u(i)];
        [temp_J, temp_y] = f1(y_pre, u(i), J_pre);
        dfs(depth - 1, temp_J, temp_y, u, u_arr, tree_index + 1);
        len = size(u_arr, 2);
        u_arr = u_arr(1:len - 1);
    end
end
