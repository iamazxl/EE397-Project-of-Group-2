function[alpha, moda] = cal_a(file,use,lambda,epsilon,beta,zeta)
K = size(use,2);
alpha = zeros(1,K);
moda = zeros(1,K/2);

for i = 1:2:K
    lambda_1=lambda(i);
    lambda_2=lambda(i+1);
    beta_1=beta(i);
    beta_2=beta(i+1);
    epsilon_1=epsilon(i);
    epsilon_2=epsilon(i+1);

    u_f_11=ismember(use(i),file(i,:));
    u_f_12=ismember(use(i),file(i+1,:));
    u_f_21=ismember(use(i+1),file(i,:));
    u_f_22=ismember(use(i+1),file(i+1,:));


    if u_f_11 && u_f_22
        moda((i+1)/2) = 0;
    elseif u_f_11 && ~u_f_22 
        alpha(i) = 1;
        moda((i+1)/2) = 2.51;
    elseif ~u_f_11  &&u_f_22
        alpha(i+1) = 1;
        moda((i+1)/2) = 2.52;
    elseif use(i)==use(i+1) && ~u_f_11 && ~u_f_22
        moda((i+1)/2) = 3;
        alpha(i) = 0.5;
        alpha(i) = 0.5;
    elseif ~u_f_11 && ~u_f_12 && u_f_21 && ~u_f_22
        alpha(i) = C1(lambda_1,lambda_2,epsilon_1,epsilon_2,beta_1,beta_2,zeta((i+1)/2));
        alpha(i+1) =1-alpha(i);
        moda((i+1)/2) = 4;
    elseif ~u_f_11 && u_f_12 && ~u_f_21 && ~u_f_22
        moda((i+1)/2) = 5;
        alpha(i) = C2(lambda_1,lambda_2,epsilon_1,epsilon_2,beta_1,beta_2,zeta((i+1)/2));
        alpha(i+1) =1-alpha(i);
    elseif ~u_f_11 && u_f_12 && u_f_21 && ~u_f_22
        moda((i+1)/2) = 6;
        alpha(i) =C3(zeta((i+1)/2));
        alpha(i+1) =1-alpha(i);
    elseif ~u_f_11 && ~u_f_12 && ~u_f_21 && ~u_f_22
        moda((i+1)/2) = 7;
        alpha(i) = C4(lambda_1,lambda_2,epsilon_1,epsilon_2,beta_1,beta_2,zeta((i+1)/2));
        alpha(i+1) =1-alpha(i);
    end
end
end
