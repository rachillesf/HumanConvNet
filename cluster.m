function [groups] = cluster(U,raio)
%Funcao dedicada a agrupar pontos que estao em um determinado raio
%=====================================================================
groups = [];


while( length(U)>0)
[m, n] = size(U); 
%montar a matriz de distancias -D
D = ones(m);
for i = 1: (m)
    p  = U(i,:);
    for j = 1:(m)
       D(i,j) = pdist([p ; U(j,:)],'euclidean' );
    end
end

%extrai pontos proximos ao raio
X = D(:,1);
pos = find(X<raio);
points =  U(pos,:);

%calcula ponto medio
mean_point = [mean(points(:,1)) mean(points(:,2))];

%adiciona ponto medio ao vetor de grupos
groups = [groups; mean_point];

%remove elementos do grupo do conjunto U
npos = find(X>raio);
U = U(npos,:);

end











