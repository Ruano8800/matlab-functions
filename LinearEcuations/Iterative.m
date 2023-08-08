function PR=Iterative(file_in,d,eps)
%algoritm iterativ de determinare a Page-rank-ului

fid=fopen(file_in);
N=fscanf(fid,'%i',1);
A=zeros(N,N);
i=0;
  while(i<N)
    i=fscanf(fid,'%i',1);
    p=fscanf(fid,'%i',1);
    C=fscanf(fid,'%i',p);
    sort(C);
    unique(C);
    A(i,C(1:end))=1;
  end
  fclose('all');
  

A=A-diag(diag(A));

PR(1:N,1)=1/N;

r=sum(A,2);

K=diag(r);
K=inv(K);
M=K*A;
M=M';

f=(1-d)/N;
V=ones(N,1);

PR1=d*M*PR+f*V;

while (max(abs(PR1-PR))>eps)
    PR=PR1;
    PR1=d*M*PR+f*V;
end

end

%Intrari: file_in - nume fisier transmis ca parametru
%         d-valoarea probabilitatii ca un utilizator sa continue navigatul
%         pe internet
%         eps-valoarea erorii care apare in calculul page rank'ului
%Iesiri: PR-valaorea page rank'ului,calculata de algoritm
%Variabile folosite pe parcurs:
%         N-numarul de noduri citit din fisier
%         A-matricea de adiacenta
%         i-indicele nodului
%         C-vectorul de noduri vecine cu nodul i
%         r-suma valorilor pe linii din matricea de adiacenta
%         K-matrice diagonala cu valorile vectorului r pe diagonala
%         M-matricea ce contorizeaza inversul numarului de legaturi
%           dintre nodul i si nodul j
%         V-vector cu N linii si o coloana,numai cu 1,vector unitate

  
