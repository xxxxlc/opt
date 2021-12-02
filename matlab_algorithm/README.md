# README

内容简介

## 函数性质

- 单峰函数
- 拟凸函数
- 凸函数



## 线性规划

- 单纯形法
  - simplex
  - linprog



## 二次规划

- 单纯形法
  - 松弛变量
  - 转化线性规划
  - linprog
- 有效集法（active-set）
  - active-set（存在问题）
  - quadprog
- 内点法（interior-point-convex）
  - quadprog



## 无约束非线性优化

牛顿和准牛顿算法

- 牛顿
  - Newton
- 拟牛顿
  - LM
  - BFGS
  - DFP



一维线搜索算法

- 固定步长法
  - fixed_step
- 变步长法
- 抛物线法
- 三次插值法
- 黄金分割法
  - golden_search
- 斐波那契法
  - fibonacci_search



搜索方向确定

- 正交搜索法
  - 正交搜索
  - Powell正交方法
- 最速下降法
- 牛顿方向
- BFGS
- DFP
- FR



Nelder-Mead方法



## 非线性优化的约束

- 线性等式约束
  - 构造消元
- 非线性等式约束
  - 拉格朗日乘数法
- 不等式约束
  - 构造映射消除约束
  - 线性不等式约束
    - 梯度投影法
  - 非线性不等式约束
    - 罚函数
    - 障碍函数
    - 二次规划法（SQP）



## 凸优化

- 凸函数
  - 凸函数性质
- 仿射函数
- 凸优化算法
  - 切平面算法  [切平面法 | xxxxlc](https://xxxxlc.github.io/2021/11/12/qie-ping-mian-fa/)
    - 无约束切平面算法
    - 有约束切平面算法
  - 椭球算法
    - 无约束椭球算法
    - 有约束椭球算法
  - 内点算法



## 全局优化

- 随机搜索
- 多起始点局部优化
- 模拟退火算法
- 遗传算法



## 多目标规划

- Pareto optimality
  - Weighted-sum
  - esplision-constrain
  - Goal-attainment



## 整数规划

- 分支定界
  - branch_and_bound




## 动态规划

