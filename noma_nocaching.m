%clear;
function[n_n] = noma_nocaching(K,P_max,beta,lambda,epsilon,zeta)

moda = 7*ones(1,K/2);
alpha_array = zeros(1,K);
for i = 1:2:K
    alpha_array(i) = C4(lambda(i),lambda(i+1),epsilon(i),epsilon(i+1),beta(i),beta(i+1),zeta((i+1)/2));
    alpha_array(i+1) = 1-alpha_array(i);
end

[P_array]=inter_pair(K,P_max,alpha_array,moda);
result = zeros(1,K);

for i = 1:K/2
    [result(2*i-1),result(2*i)] = final(P_array(i),alpha_array(2*i-1),moda(i),lambda(2*i-1),lambda(2*i),beta(2*i-1),beta(2*i),epsilon(2*i-1),epsilon(2*i));
end

suc_pro = sum(result)/K;

n_n=suc_pro;
% figure
% plot(2:2:16,suc_sum);
% xlabel('用户数');
% ylabel('成功概率')
