function soln = mydescent(A,b,guess,step,tol)

sum= 0;
dfsum = 0;
sumalldf = 0;
grad = [];
syms u v
x =[u;v];

for k = 1:size(x,1)
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            sum = sum + (A(i,j)*x(j) - b(i))^2;
        end
        dfsum = diff(sum, x(k));
        sum = 0;
      
        sumalldf = sumalldf + dfsum;
    end
    
    grad = [grad, sumalldf];
    sumdf=0;
end
%gradient
gi = subs(grad,x,guess)';

M= [];
while norm(gi)>tol
   guess = guess - (step .* gi);
   gi = double(subs(grad,[u;v],guess)');
  
   %sse - sum of squared errors
   sse =(A * guess - b)'*(A * guess - b);
   % matirx with x coord y coord and sse to plot cost funct.
   M = [M; guess(1,1) guess(2,1) sse];
end
figure
plot3(M(:,1), M(:,2) , M(:,3) )
title('3d plot of gradient descent')
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')

grid on

figure
plot(M(:,1), M(:,2))
title('2d plot of xy projection of gradient descent')

soln = double(guess') ;
