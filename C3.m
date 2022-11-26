function[alpha]=C3(zeta)
%C3情况下最佳功率分配
%输入：zeta
%zeta:lambda、epsilon、beta的函数
%输出：alpha用户1的功率分配额度

alpha=1-1/(sqrt(zeta)+1);

end