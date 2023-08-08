function filter(file_in,filter_type)
%functie de aplicare a diferitelor filtre
%'smooth','blur','sharpen','emboss'

A=double(imread(file_in,'pgm'));
[m,n]=size(A);
A1=zeros(size(A)+2)*0;
A1(2:end-1,2:end-1)=A;

if strcmp(filter_type,'smooth')
    B(1:m,1:n)=A1(1:m,1:n)+A1(1:m,2:n+1)+A1(1:m,3:n+2)+A1(2:m+1,1:n)+A1(2:m+1,2:n+1)+A1(2:m+1,3:n+2)+A1(3:m+2,1:n)+A1(3:m+2,2:n+1)+A1(3:m+2,3:n+2);
    B(1:m,1:n)=uint8(floor(B(1:m,1:n)/9));
    f=fopen('out_smooth.pgm','w');
    B=B';
    fprintf(f,'P2\n%i %i\n255\n',n,m);
    fprintf(f,'%i\n',B);
end
 
if strcmp(filter_type,'blur')
    B(1:m,1:n)=A1(1:m,1:n)+2*A1(1:m,2:n+1)+A1(1:m,3:n+2)+2*A1(2:m+1,1:n)+4*A1(2:m+1,2:n+1)+2*A1(2:m+1,3:n+2)+A1(3:m+2,1:n)+2*A1(3:m+2,2:n+1)+A1(3:m+2,3:n+2);
    B=uint8(floor(B(1:m,1:n)/16+0));
    f=fopen('out_blur.pgm','w');
    B=B';
    fprintf(f,'P2\n%i %i\n255\n',n,m);
    fprintf(f,'%i\n',B);
end

if strcmp(filter_type,'sharpen')
    B(1:m,1:n)=0*A1(1:m,1:n)+(-2)*A1(1:m,2:n+1)+0*A1(1:m,3:n+2)+(-2)*A1(2:m+1,1:n)+11*A1(2:m+1,2:n+1)+(-2)*A1(2:m+1,3:n+2)+0*A1(3:m+2,1:n)+(-2)*A1(3:m+2,2:n+1)+0*A1(3:m+2,3:n+2);
    B=uint8(floor(B(1:m,1:n)/3+0));
    f=fopen('out_sharpen.pgm','w');
    B=B';
    fprintf(f,'P2\n%i %i\n255\n',n,m);
    fprintf(f,'%i\n',B);
end

if strcmp(filter_type,'emboss')
    B(1:m,1:n)=(-1)*A1(1:m,1:n)+0*A1(1:m,2:n+1)+(-1)*A1(1:m,3:n+2)+0*A1(2:m+1,1:n)+4*A1(2:m+1,2:n+1)+0*A1(2:m+1,3:n+2)+(-1)*A1(3:m+2,1:n)+0*A1(3:m+2,2:n+1)+(-1)*A1(3:m+2,3:n+2);
    B=uint8(floor(B(1:m,1:n)/1+127));
    f=fopen('out_emboss.pgm','w');
    B=B';
    fprintf(f,'P2\n%i %i\n255\n',n,m);
    fprintf(f,'%i\n',B);
end

fclose('all');

end
%Intrari: file_in-fisier transmis ca parametru
%         filter_type-tipul filtrului ales sa fie aplicat imaginii
%Variabile utilizate pe parcurs:
%         A-variabila utilizata la salvarea matricei citita din fisierul
%           transmis ca parametru
%         A1-variabila utilizata pentru bordarea matricei A
%         B-variabila utilizata pentru salvarea elementelor prelucrate
%           ale matricei A1
%         m,n-numarul de linii,respectiv coloane,ale matricei A din
%             fisierul de intrare