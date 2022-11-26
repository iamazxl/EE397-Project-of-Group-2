## 方法一 Readme

### 函数实现

* 主函数

在主函数中有参数初始化以及调用其他函数，最后重复传输过程计算平均概率。调用 baseline 函数，统计成功概率，最后作图对比。见代码main1

* $\alpha$ 计算

首先基于四个定理，可以给出 $\alpha_i$ 也就是功率对内分配的取值。四个公开分配函数分别为 C1、C2、C3、C4。

随机生成用户缓存文件和用户需求文件，并计算 要求-缓存 的逻辑关系。根据逻辑关系分为 7 种不同情况，计算 $\alpha$ 可见代码 cal_a.m。


* 功率对间分配

再根据 $\alpha$ 数组计算功率对间的分配。$\Psi$ 是只与 $\alpha$ 有关的函数，==但在文章中未明确给出==。可见代码 inter_pair.m

* 计算传输成功概率

根据 $\alpha$ 的值和分配的功率 $P_i$ 计算文件接收成功概率。可见代码 final.m

* baseline

noma_nocaching.m、OMA_nocaching.m、OMA_caching.m、MMF.m、equal.m

### 运行结果

运行main1函数

<img src="https://notes.sjtu.edu.cn/uploads/upload_be35f84fe1695cbd846f24952feeb77e.png" alt="figure5" style="zoom:67%;" />

<center>论文结果<center>

<img src="https://notes.sjtu.edu.cn/uploads/upload_478a01edae40c07ac7e18d320ea3d719.jpg" alt="运行结果1" style="zoom:67%;" />
<center>运行结果<center>