%clear;
function[o_n] = OMA_nocaching(K,P_max,beta,lambda,epsilon)
alpha = ones(1,K);
ss = sum(sqrt(alpha));
P_array = zeros(1,K);
for i =1:K
    P_array(i)=sqrt(alpha(i))*P_max/ss;
end
result = zeros(1,K);
for i = 1:K
    if  rand()<exp(-lambda(i)*beta(i)*epsilon(i)/P_array(i))
        result(i) = 1;
    end
end

suc_pro=sum(result)/K;

o_n= suc_pro;
% figure
% plot(2:2:16,suc_sum);
% xlabel('用户数');
% ylabel('成功概率')


