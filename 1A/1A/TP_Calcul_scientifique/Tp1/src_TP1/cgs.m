%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% cgs.m
%--------------------------------------------------------------------------

function Q = cgs(A)

    % Recuperation du nombre de colonnes de A
    [m, n] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    
    %------------------------------------------------
    % A remplir
    % Algorithme de Gram-Schmidt classique
    %------------------------------------------------
%composantes=zeros(m,m);
    
    %for i=1:m
       %y=(A:i);
      % composantes
    
      R = zeros(n)
      R(1,1)=norm(A(:,1));
      Q(:,1)=A(:,1)/R(1,1);
      for k=2:n
          R(1:k-1,k)=Q(:,1:k-1)'*A(:,k);
          Q(:,k)=A(:,k)-Q(:,1:k-1)*R(1:k-1,k);
          R(k,k)=norm(Q(:,k));
          Q(:,k)=Q(:,k)/R(k,k);
      end
    
end