function [ data ] = genData2
% generate data

A1=[0.5 0.2; 0 2];
u1=[4 0];

A2=[0.5 0.2; 0 0.3];
u2=[5 7];

A3=[0.8 0; 0 0.8];
u3=[7 4];

data = randn(150,2) ;
for i=1:50
data(i,:)    = u1' + A1 * data(i,:)' ;
end
for i=51:100
data(i,:)  = u2' + A2 * data(i,:)' ;
end
for i=101:150
data(i,:) = u3' + A3 * data(i,:)' ;
end

end
