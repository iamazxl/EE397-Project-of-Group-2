function[result1,result2] = final(P,alpha_i,moda,lambda_1,lambda_2,beta_1,beta_2,epsilon_1,epsilon_2)
result1 = 0;
result2 = 0;
if moda == 0 
    result1 = 1;
    result2 = 1;
elseif moda ==  2.51 
    result1 = 1;
    if rand < exp(-lambda_2*epsilon_2*beta_2/P)
        result2 = 1;
    end
elseif moda == 2.52
    result2 = 1;
    if rand < exp(-lambda_1*epsilon_1*beta_1/P)
        result1 = 1;
    end
elseif moda == 3
    if rand < exp(-max(epsilon_1,epsilon_2)*(lambda_1*beta_1+lambda_2*beta_2)/P)
        result1 = 1;
        result2 = 1;
    end
elseif moda == 4 
    if alpha_i<=0.5 && rand<exp(-(lambda_1*epsilon_1*beta_1/alpha_i+lambda_2*epsilon_2*beta_2/(1-(1+epsilon_2)*alpha_i))/P)
        result1 = 1;
        result2 = 1;
    elseif rand<exp(-(lambda_1*epsilon_1*beta_1/alpha_i+max(lambda_2*epsilon_2*beta_2/(1-alpha_i),lambda_2*epsilon_1*beta_2/((1+epsilon_1)*alpha_i-epsilon_1)))/P)
        result1 = 1;
        result2 = 1;
    end
elseif moda == 5   
    if alpha_i>=0.5 && rand<exp(-(lambda_1*epsilon_1*beta_1/((1+epsilon_1)*alpha_i-epsilon_1)+lambda_2*epsilon_2*beta_2/(1-alpha_i))/P)
        result1 = 1;
        result2 = 1;
    elseif rand<exp(-(max(lambda_1*epsilon_2*beta_1/(1-(1+epsilon_2)*alpha_i),lambda_1*epsilon_1*beta_1/alpha_i)+lambda_2*epsilon_2*beta_2/(1-alpha_i))/P)
        result1 = 1;
        result2 = 1;
    end
elseif moda == 6
    if rand<exp(-(lambda_1*epsilon_1*beta_1/alpha_i+lambda_2*epsilon_2*beta_2/(1-alpha_i))/P)
        result1 = 1;
        result2 = 1;
    end
elseif moda == 7
    if alpha_i>=0.5 && rand<exp(-(lambda_1*epsilon_1*beta_1/((1+epsilon_1)*alpha_i-epsilon_1)+max(lambda_2*epsilon_1*beta_2/((1+epsilon_1)*alpha_i-epsilon_1),lambda_2*epsilon_2*beta_2/(1-alpha_i)))/P)
        result1 = 1;
        result2 = 1;
    elseif rand<exp(-(max(lambda_1*epsilon_2*beta_1/(1-(1+epsilon_2)*alpha_i),lambda_1*epsilon_1*beta_1/alpha_i)+lambda_1*epsilon_1*beta_1/(1-(1+epsilon_2)*alpha_i))/P)
        result1 = 1;
        result2 = 1;
    end
end
end