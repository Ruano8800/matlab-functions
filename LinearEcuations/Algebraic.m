function PR=Algebraic(file_in,d)
%implementarea metodei algebrice de calculare a page-rank'ului

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

r=sum(A,2);

K=diag(r);
K=inv(K);
M=K*A;
M=M';

f=(1-d)/N;
V=ones(N,1);

I=eye(N);
B=d*M;
T=I-B;

[Q,R]=gram_sc(T);
P=Q';
  for i=1:N
     b(1:N)=P(1:N,i);
     b=b';
     x=sst(R,b);
     w(1:N,i)=x(1:N);
  end
PR=w*f*V;
end

%Intrari: file_in - nume fisier transmis ca parametru
%         d-valoarea probabilitatii ca un utilizator sa continue navigatul
%         pe internet
%Iesiri: PR-valaorea page rank'ului,calculata de algoritm
%Variabile folosite pe parcurs:
%         N-numarul de noduri citit din fisier
%         A-matricea de adiacenta
%         i-indicele nodului
%         C-vectorul de noduri vecine cu nodul i
%         r-suma valorilor pe linii din matricea de adiacenta
%         K-matrice diagonala cu valorile vectorului r pe diagonala
%         V-vector cu N linii si o coloana,numai cu 1,vector unitate
%         I-matricea unitate
%         T-matricea de inversat,calculata conform algoritmului algebric al
%         page rank'ului
%         algoritmul de ortogonalizare Gram-Schmidt precum si cel de
%         rezolvare a unui sistem superior triunghiular au fost luati de pe
%         site'ul cursului de metode numerice din libraria de functii
%         Matricea T este matricea ce trebuie ortogonalizata.Se aplica algoritmul 
%         Gram-Schmidt de ortogonalizare si se obtine matrice Q ortogonala 
%         si matricea R superior triunghiulara.Gram-Schmidt si factorizarea 
%         QR ne permit rezolvare unui sistem supradeterminat de ecuatii.
%         Matricea T este produsul dintre matricea Q ortogonalizata: 
%         Q^T(i)*Q(j)=1,daca i=j sau 0 altfel,si R matrice superior 
%         triunghiulara.Vectorul termenilor liberi pentru rezolvarea 
%         sistemului superior triunghiular este fiecare coloana a matricei 
%         ortogonale Q'.Se calculeaza intai ultima valoare a sistemului 
%         superior triunghiular deoarece este unic determinata,nu depinde 
%         de nicio necunoscuta in plus.Apoi se calculeaza restul valorilor 
%         de la N-1 la 1 pentru fiecare vector coloana in parte.

