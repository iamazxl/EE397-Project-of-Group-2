function[alpha]=C4(lambda_1,lambda_2,epsilon_1,epsilon_2,beta_1,beta_2,zeta)
%C4情况下最佳功率分配
%input:lambda_1,lambda_2,epsilon_1,epsilon_2,beta_1,beta_2,zeta
%lambda：瑞利分布参数  
%epsilon：SINR
%beta:距离、噪声、损失的函数
%output:alpha用户1的功率分配额度

z_1=1-min(1/(sqrt(1+epsilon_1)*(sqrt(zeta)+sqrt(1+epsilon_1))),1/(1+epsilon_1+epsilon_1/epsilon_2));
z_2=min((1-1/(sqrt(zeta*(1+epsilon_2))+1))/(1+epsilon_2),min(1/(1+epsilon_2+epsilon_2/epsilon_1),0.5));
g_1=lambda_1*epsilon_1*beta_1/((1+epsilon_1)*z_1-epsilon_1)+lambda_2*epsilon_2*beta_2/(1-z_1);
g_2=lambda_1*epsilon_1*beta_1/z_2+lambda_2*epsilon_2*beta_2/(1-(1+epsilon_2)*z_2);

if g_1<=g_2
    alpha=z_1;
else
    alpha=z_2;
end
