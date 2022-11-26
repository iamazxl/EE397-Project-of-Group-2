%clear;
function[mmf] = MMF(K,P_max,beta,epsilon)

lambda1=ones(1,K/2);
lambda2=2*ones(1,K/2);
lambda=[lambda1,lambda2];
H1 = random(makedist('Exponential',1),1,K/2); %|h1|^2，满足指数分布
H2 = random(makedist('Exponential',2),1,K/2); %|h1|^2，满足指数分布
H=[H1,H2];


ss = sum(sqrt(H));
P_array = zeros(1,K);
for i =1:K
    P_array(i)=sqrt(H(i))*P_max/ss;
end

result = zeros(1,K);

for i = 1:K
    if  rand()<exp(-lambda(i)*beta(i)*epsilon(i)/P_array(i))
        result(i) = 1;
    end
end
mmf=sum(result)/K;

% figure
% plot(2:2:16,suc_sum);
% xlabel('用户数');
% ylabel('成功概率')

