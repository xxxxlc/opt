from scipy.optimize import linprog
import matplotlib.pyplot as plt
import matplotlib.path as mpath
import seaborn as sns

c = [0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1]
A_eq = [[-1 , 2 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 
, 0 ],
[1 , 2 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 ],
[1 , 2 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0, 1 , 0 , 0 , 0 , 0 , 0 ],
[2 , 0 , 0 , 0 , 0 , -1 , 1 , 1 ,- 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0],
[0 , 2 , 0 , 0 , 0 , 2 , 2 , 2 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0],
[0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0, 0 , -1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0],
[0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0],
[0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1]]

b_eq = [2 , 6 , 2 , 2 , 5 , 0 , 0 , 0]

path = [[], [], []]

class Callback(object):
    def __call__(self, par, convergence=0):
        x = par.x[:2]
        fx = (x[0] - 1) * (x[0] - 1) + (x[1] - 2.5) * (x[1] - 2.5)
        global path
        path[0].append(x[0])
        path[1].append(x[1])
        path[2].append(fx)

callback = Callback()
res = linprog(method='simplex', c=c, A_eq=A_eq, b_eq=b_eq, callback=callback)
iter_no = len(path[0])
sns.lineplot(x=[i for i in range(iter_no)], y=path[0])
ax = sns.lineplot(x=[i for i in range(iter_no)], y=path[1])
ax.legend(['x_1', 'x_2'])
# plt.savefig('qp_modified_simplex.svg')
plt.show()

print("x_1\tx_2\tf(x)")
for i in range(len(path[0])):
    print(path[0][i], path[1][i], path[2][i], sep='\t')

