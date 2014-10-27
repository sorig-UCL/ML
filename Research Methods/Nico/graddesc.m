function soln = graddesc(f, g, i, e, t)
% gradient descent
% f -- function
% g -- gradient
% i -- initial guess
% e -- step size
% t -- tolerance

gi = feval(g,i) ;

M =[] ;
while(norm(gi)>t)  % crude termination condition
  % new x y values for i
  i = i - e .* feval(g,i) ; 
% new gradient values  at i
  gi = feval(g,i)  ;
  M= [M; i feval(f, i)] ;
end

figure
%3d plot of figure 2 
plot3(M(:,1), M(:,2) , M(:,3), 'Color', [1,0,0] )
title('3d plot of gradient descent')
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')

grid on

%2d plot of figure 3
figure
plot(M(:,1), M(:,2)) 
title('2d xy projection of gradient descent')

soln = i;

