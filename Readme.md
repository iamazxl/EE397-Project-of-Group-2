## Readme

### 方法一函数实现

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

### 方法一运行结果

<img src="https://notes.sjtu.edu.cn/uploads/upload_be35f84fe1695cbd846f24952feeb77e.png" alt="figure5" style="zoom:50%;" />

<center>论文结果<center>

<img src="https://notes.sjtu.edu.cn/uploads/upload_478a01edae40c07ac7e18d320ea3d719.jpg" alt="运行结果1" style="zoom:50%;" />
<center>运行结果<center>
  
## 方法二运行结果
### 运行net_1.m函数
  
运行net_1.m程序进行网络训练，将训练好的网络数据保存在method2_cache_10.mat和method2_cache_30.mat中。
  
运行main_1226.m程序进行方法一、方法二性能对比，运行结果如下。

<img src="https://user-images.githubusercontent.com/88258281/210690630-4f29abe7-036e-493d-8f9b-6ab1e182210d.png" style="zoom:30%;" />
  
<img src="https://user-images.githubusercontent.com/88258281/210690698-6afd74b9-39b2-4f5a-895d-e358c68b6fac.png" style="zoom:30%;" />
