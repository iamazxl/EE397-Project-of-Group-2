K = 4;   %用户数目，1~16自定义，且为偶数
P_max = 1;
d_i = 1; % i=1,2,...,K
sigma2 = 1; %信道高斯噪声方差
lambda_1=1;
lambda_2=1;
num_file = 38; %文件数目
epsilon = zeros(0,num_file);
betai=ones(1,K);
for i = 1:num_file
    epsilon(i) = 0.016*i;
end
Cmax=19;%最多缓存数
loop1max=10;   %生成用户请求和缓存循环数
Amax=10;
loop2max=10;   %生成功率分配向量循环数
allalpha=zeros(loop1max,K);  %最终被选择的最佳的功率分配向量α
avereward=zeros(K,1);
allreward=zeros(K,1);       
cur_reward=0;
max_reward=-1;
average_reward=0;
best_alpha=zeros(1,K);
for loop1=1:loop1max
    Cnum=randi(Cmax,[1,K]);    %生成用户缓存文件数
    CCij=zeros(K,num_file);     %CCij是用户缓存表

    %随机生成用户缓存
 for i=1:K
    Ctemp=randperm(38);
    Cpositon=Ctemp(1:Cnum(i));   %用randperm防止重复，生成具体用户缓存文件
     for j=1:Cnum(i)
        CCij(i,Cpositon(j))=1;
     end
 end

 ftemp=randperm(38);
 fask=ftemp(1:4);    %生成用户请求文件，这里是假设用户请求文件不同
 Cij=zeros(K,K);     %论文中的用户i是否缓存文件j
 for i=1:K
     for j=1:K
         Cij(i,j)=CCij(i,fask(j));
     end
 end
 Sij=zeros(K,K);    %论文中的用户优势
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
 Sij=reshape(Sij,1,K*K);   %方便后续计算reward


 %这里计算框架是根据论文中的伪代码2
 for loop2=1:Amax
      alpha=rand(1,K);
  for k=1:K
      if Sij(K*(k-1)+k)==0
          alpha(k)=0;
      end
  end
  
  alphasum=sum(alpha);
  if alphasum==0
      alpha=0.25*ones(1,K);
  else
      alpha=alpha/alphasum;
  end
  psi=zeros(K,K);
  for i=1:K
      for j=1:K
          if alpha(i)>=alpha(j)
              psi(i,j)=1;
          end
      end
  end
  for loop3=1:loop2max
      H1 = random(makedist('Exponential',lambda_1)); %|h1|^2，满足指数分布
      H2 = random(makedist('Exponential',lambda_2)); %|h1|^2，满足指数分布
  success=ones(1,K);  %各用户是否成功接收
  for i=1:K
      for j=1:K
          sumtemp=0;
          for k=1:K
              sumtemp=sumtemp+H2*Cij(i,k)*psi(j,k)*alpha(k);
          end
          sumtemp=sumtemp-H2*Cij(i,j)*psi(j,j)*alpha(j);
          if (H1*alpha(j))/(sumtemp+betai(i))<((1-Cij(i,j))*epsilon(j))
              success(1,i)=0;
          end
      end
  end
  reward=sum(success);
  avereward(loop3)=reward;
  end
  cur_reward=mean(avereward);
  if cur_reward>max_reward
      max_reward=cur_reward;
      best_alpha=alpha;
  end
 end
  allalpha(loop1,:)=best_alpha;
  allreward(loop1)=max_reward;
  best_alpha=zeros(1,K);
  max_reward=0;
end












