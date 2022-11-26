clear;
n_c = zeros(1,8);
n_n = zeros(1,8);
o_n = zeros(1,8);
o_c = zeros(1,8);
mmf = zeros(1,8);
for m = 1:8
    K = 2*m;   %用户数目，1~16自定义，且为偶数
    for j =1:10000
        P_max = 1;
        d_i = 1; % i=1,2,...,K
        beta = ones(1,K);
        lambda=ones(1,K);
        lambda(1,2:2:K)=2;
        num_file = 38; %文件数目
        cache_file = 10;
        epsilon = zeros(1,num_file);
        for i = 1:num_file
            epsilon(i) = 0.016*i;
        end

        use=randi(num_file,1,K);
        epsilon = epsilon(use);
        file = zeros(K,cache_file);
        for i =1:K
            tmp = randperm(num_file);
            file(i,:)=tmp(1,1:cache_file);
        end
        zeta = ones(1,K/2);
        for i = 1:2:K
            zeta((i+1)/2)=(lambda(i)*epsilon(i)*beta(i))/(lambda(i+1)*epsilon(i+1)*beta(i+1));
            if zeta((i+1)/2) < 1
                tmp = lambda(i);
                lambda(i) = lambda(i+1);
                lambda(i+1) = tmp;
                tmp = epsilon(i);
                epsilon(i) = epsilon(i+1);
                epsilon(i+1) = tmp;
                tmp = beta(i);
                beta(i) = beta(i+1);
                beta(i+1) = tmp;
                zeta((i+1)/2) = 1/zeta((i+1)/2);
            end
        end

        [alpha,moda] = cal_a(file,use,lambda,epsilon,beta,zeta);
        P_array=inter_pair(K,P_max,alpha,moda);
        result = zeros(1,K);
        for i = 1:K/2
            [result(2*i-1),result(2*i)] = final(P_array(i),alpha(2*i-1),moda(i),lambda(2*i-1),lambda(2*i),beta(2*i-1),beta(2*i),epsilon(2*i-1),epsilon(2*i));
        end
        n_c(m) =n_c(m) + sum(result)/K;
        n_n(m) =n_n(m) +  noma_nocaching(K,P_max,beta,lambda,epsilon,zeta);
        o_n(m) =o_n(m) +  OMA_nocaching(K,P_max,beta,lambda,epsilon);
        o_c(m) =o_c(m) +  OMA_caching(K,P_max,beta,lambda,epsilon,use,file);
        mmf(m) =mmf(m) + MMF(K,P_max,beta,epsilon);
    end
    n_c(m)=n_c(m)/10000;
    o_c(m)=o_c(m)/10000;
    o_n(m)=o_n(m)/10000;
    n_n(m)=n_n(m)/10000;
    mmf(m)=mmf(m)/10000;
end

figure
plot(2:2:16,n_c);
hold on
plot(2:2:16,n_n);
plot(2:2:16,o_n);
plot(2:2:16,o_c);
plot(2:2:16,mmf);
legend('NOMA with caching','NOMA without caching','OMA without caching', 'OMA with caching','MMF')
xlabel('用户数');
ylabel('成功概率')

