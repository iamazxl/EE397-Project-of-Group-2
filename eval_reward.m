function [avereward] = eval_reward(S,alpha)
K=3;
num_file = 38; %文件数目
epsilon = zeros(0,num_file);
betai=ones(1,K);
for i = 1:num_file
    epsilon(i) = 0.016*i;
end
C=ones(K,K);
C(find(S))=0;
C=C';
psi = zeros(K,K);
for i=1:K
    for j=1:K
        if alpha(i)>=alpha(j)
            psi(i,j)=1;
        end
    end
end
Amax=100;
avereward=zeros(1,Amax);
for loop3=1:Amax
    H=zeros(1,K);
    for i =1:K
    H(i) = random(makedist('Exponential',i));
    end
    success=ones(1,K);  %各用户是否成功接收
        for j=1:K
            sumtemp=0;
            for k=1:K
                if k~=j
                    sumtemp=sumtemp+H(j)*C(j,k)*psi(j,k)*alpha(k);
                end
            end
            if (H(j)*alpha(j))/(sumtemp+betai(j))<((1-C(j,j))*epsilon(j))
                success(1,j)=0;
            end
        end
    reward=sum(success);
    avereward(loop3)=reward;
end
avereward=sum(avereward)/Amax;
end

