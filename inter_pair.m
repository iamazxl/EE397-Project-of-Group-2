function[P_array]=inter_pair(K,P_max,alpha_array,moda)
%功率对间分配
%输入：用户个数，总功率，功率对分配数组
%输出：分配给每个功率对的功率

ss = sum(sqrt(alpha_array));
P_array = zeros(1,K/2);
for i =1:K/2
    P_array(i)=sqrt((alpha_array(2*i)+alpha_array(2*i-1))*moda(i))*P_max/ss;
end
end