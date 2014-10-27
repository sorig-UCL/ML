Z=[];
[X,Y] = meshgrid(linspace(0,5,15),linspace(0,5,15));


%column x
for x = 1:size(X,1)
    %row y
    for y = 1:size(X,2)
        vectx= [X(x,y), Y(x,y)]'; 
        %column vector of error terms
        e= A * vectx - b;
        %sum of errors squared
        sum_e_sq= e' * e;
        %populate matrix (??)
        Z(x,y) = sum_e_sq;
    end;
end;

mesh(X,Y,Z) ;
