function y = kbregr(data,k,guess,step,tol)
% k basis linear regression 
% 
X= data(:,1:end-1);
b = data(:,end);


% figure
% scatter(X,b,50,'MarkerEdgeColor',[0 .5 .5],...
%               'MarkerFaceColor',[0 .7 .7],...
%               'LineWidth',2.5)
% axis([0,5,-5,8])
% hold on


x = sym('x', 'real');
f=[];
for m = 1:k
    f= [f,x^(m-1)];
end
disp(f)

phi = [];
for i = 1:size(X,1)
phi = [phi ;subs(f,x,X(i,1))];
end
disp(phi)
w= sym('w', [k 1]);
w = sym(w, 'real');


SSE = (phi*w -b)'*(phi*w -b)

%We want to find w to reduce SSE

dSSE = [ ];

for d = 1:k
  dSSE = [ dSSE, diff(SSE, w(d,1))];
end

disp(dSSE)

gi = subs(dSSE,w,guess); 
es = [ ];
while norm(gi)>tol

    es = [es, subs(SSE,w,guess)];
     if subs(SSE,w,guess) > subs(SSE, w,(guess - (step .* gi)'))
          step = step*1.2;
        guess = guess - (step .* gi)';
        gi = double(subs(dSSE,w, guess));    
     else
         step = step*0.5;
     end
%   disp((double(guess))')
%   disp('gradient')
%   disp(gi)
%   disp(step)


end


fx = guess' .* f;

ffx=0;
for d = 1:k
    ffx = ffx + fx(d);
end

vpa(ffx)
ezplot(ffx)
axis([0,5,-5,8])
title( 'plot with curve' )

xL = xlim;
yL = ylim;
line([0 0], yL, 'Color', 'black','LineWidth',1.5);  %x-axis
line(xL, [0 0], 'Color', 'black','LineWidth',1.5);  %y-axis

disp(double(subs(SSE,w,guess)/size(X,1)))
end

