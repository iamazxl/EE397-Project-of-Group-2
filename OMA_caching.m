% clear;
function[o_c] = OMA_caching(K,P_max,beta,lambda,epsilon,use,file)

moda = zeros(1,K);
alpha = zeros(1,K);

for i = 1:K
    u_f=ismember(use(i),file(i,:));

    if u_f
        moda(i)=0;
    else
        moda(i)=1;
        alpha(i) = 1;
    end
end

ss = sum(sqrt(alpha));
P_array = zeros(1,K);
for i =1:K
    P_array(i)=sqrt(alpha(i)*moda(i))*P_max/ss;
end

result = zeros(1,K);

for i = 1:K
    if moda(i) == 0
        result(i) = 1;
    elseif  rand()<exp(-lambda(i)*beta(i)*epsilon(i)/P_array(i))
        result(i) = 1;
    end
end

suc_pro=sum(result)/K;
o_c = suc_pro;
% figure
% plot(0:38,suc_sum);
% legend('OMA+caching')
% xlabel('cach_file');
% ylabel('成功概率')

end
