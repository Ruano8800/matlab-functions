function contrast(file_in,a,b)
%functie de stabilire a contrastului unei imagini

C=double(imread(file_in));
max1=max(max(C));
min1=min(min(C));
c=b-a;
d=max1-min1;
B=(C-min1).*c;
B=uint8(floor(B./d+a));
B=B';
[m,n]=size(B);
f=fopen('out_contrast.pgm','w');
fprintf(f,'P2\n%i %i\n255\n',m,n);
fprintf(f,'%i\n',B);
fclose(f);

end
%Intrari: file_in - nume fisier transmis ca parametru
%         a-valaore minima,transmisa ca parametru,fata de care valoarea fiecarui pixel 
%         trebuie sa fie mai mare sau cel putin egala     
%         b-vraloarea maxima,transmisa ca parametru,fata de care valoarea fiecarui
%         pixel trebuie sa fie mai mica sau cel mult egala
%Variabile utilizate pe parcurs:
%         C-matricea in care se salveaza matricea citita din fisierul 
%         de intrare
%         max1,min1 valorile maxima,respectiv minima ale matricei C
%         c-diferenta dintre parametrii b si a
%         d-diferenta dintre valoarea maxima si minima a matricei C
%         B-matricea rezultata in urma prelucrarilor