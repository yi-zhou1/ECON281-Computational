function [gg] = kf_equation(A,grid,num)

AT = A';
b = zeros(2*num.a_n,1);

%need to fix one value, otherwise matrix is singular
i_fix = 1;
b(i_fix)=.1;
row = [zeros(1,i_fix-1),1,zeros(1,2*num.a_n-i_fix)];
AT(i_fix,:) = row;

%Solve linear system
gg = AT\b;
g_sum = gg'*ones(2*num.a_n,1)*grid.da;
gg = gg./g_sum;

%because we are solving a linear system and AT is singular, and AT is
%singluar since its each column adds up to zero. So such linear system has
%infinite solutions, and we can't use ATinverse to solve for g. Then we use
%this "fixing one value" approach to get an approximate solution.

%we can use another approach to verify this approach gets us the correct
%answer (because after fixing one value, we are solving a different linear
%system). We can guess one g, and iterate AT*g until it converges.

end