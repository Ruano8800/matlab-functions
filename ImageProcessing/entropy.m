function entropy(file_in,a,b,c)
%calcularea valorii entropiei unei imaginii

A=double(imread(file_in));
A=A';
[m,n]=size(A);
A1=zeros(size(A)+2)*0;
A1(2:end-1,2:end-1)=A;
D=floor(A1(2:m+1,2:n+1)-ceil(b*A1(1:m,1:n)+a*A1(1:m,2:n+1)+c*A1(2:m+1,1:n)));
nt=m*n;
x=sort(D(:));
u=unique(D);
na=histc(x,u);
q=length(u);
p=na./nt;
z=log2(p(1:q));
s=sum(p(1:q).*z);
entr=-s;

fid=fopen('entropy.txt','w');
fprintf(fid,'%f',entr);
fclose('all');


end

%Intrari: file_in - fisier transmis ca parametru de unde va fi preluata
%                   matricea imagine
%         a,b,c-valori transmise ca parametru
%Variabile utilizate pe parcurs:
%          A-variabila utilizata la salvarea matricei citita din fisierul
%           transmis ca parametru
%          m,n-numarul de coloane respectiv de linii ale matricei A
%          A1-variabila utilizata pentru bordarea matricei A
%          D-variabila utilizata pentru salvarea elementelor prelucrate
%           ale matricei A1
%          nt-numarul total de valori ale matricei A(respectiv numarul de
%             pixeli ai imaginii)
%          x-liniarizarea si sortarea matricei D
%          u-vector de elemente unice din D
%          na-numarul de aparitii al elementelor vectorului u in vectorul x
%          q-numarul de elemente unice din D
%          p-vectorul procentelor de aparitie al fiecarui element unic
%          z-vectorul prelucrat al procentelor
%          s=variabila de calcul
%          entr=valaorea entropiei