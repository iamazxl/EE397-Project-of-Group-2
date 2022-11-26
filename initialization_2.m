K = 4;   %用户数目，1~16自定义，且为偶数
P_max = 1;
d_i = 1; % i=1,2,...,K
sigma2 = 1; %信道高斯噪声方差
H1 = makedist('Exponential',1); %|h1|^2，满足指数分布
H2 = makedist('Exponential',2); %|h1|^2，满足指数分布
lambda_1=1;
lambda_2=1;
num_file = 38; %文件数目
epsilon = zeros(0,num_file);
betai=ones(1,K);
for i = 1:num_file
    epsilon(i) = 0.016*i;
end
Cmax=19;%最多缓存数
loop1max=10;
loop2max=10;
allalpha=zeros(loop1max,K);
allreward=zeros(K,1);

for loop1=1:loop1max
    Cnum=randi(Cmax,[1,4]);
    CCij=zeros(K,num_file);

 for i=1:K
    Ctemp=randperm(38);
    Cpositon=Ctemp(1:Cnum(i));
     for j=1:Cnum(i)
        CCij(i,Cpositon(j))=1;
     end
 end
 ftemp=randperm(38);
 fask=ftemp(1:4);
 Cij=zeros(K,K);
 for i=1:K
     for j=1:K
         Cij(i,j)=CCij(i,fask(j));
     end
 end
 Sij=zeros(K,K);
 for i=1:K
     for j=1:K
         if Cij(i,j)==0 
             Sij(i,j)=epsilon(fask(j));
         end
     end
     if Cij(i,i)==1
         Sij(i,:)=0;
     end
 end
 Sij=Sij.';
 Sij=reshape(Sij,1,K*K);

 for loop2=1:loop2max
     alpha=rand(1,K);
  for k=1:K
      if Sij(K*(k-1)+k)>0
          alpha(k)=0;
      end
  end
  alphasum=sum(alpha);
  alpha=alpha/alphasum;
  psi=zeros(K,K);
  for i=1:K
      for j=1:K
          if alpha(i)>=alpha(j)
              psi(i,j)=1;
          end
      end
  end
  success=ones(1,K);
  for i=1:K
      for j=1:K
          sumtemp=0;
          for k=1:K
              sumtemp=sumtemp+lambda_2*Cij(i,k)*psi(j,k)*alpha(k);
          end
          sumtemp=sumtemp-lambda_2*Cij(i,j)*psi(j,j)*alpha(j);
          if (lambda_1*alpha(j))/(sumtemp+betai(i))<((1-Cij(i,j))*epsilon(j))
              success(1,i)=0;
          end
      end
  end
  reward=sum(success);
  allreward(loop2)=reward;
 end
  alpha(loop1,:)=alpha;
end





