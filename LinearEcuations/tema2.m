function tema2(file_in,d,eps)
%implementarea functiei 2

fid=fopen(file_in);
N=fscanf(fid,'%i',1);
i=0;
  while(i<N)
    i=fscanf(fid,'%i',1);
    p=fscanf(fid,'%i',1);
    C=fscanf(fid,'%i',p);
  end

  val1=fscanf(fid,'%f',1);
  val2=fscanf(fid,'%f',1);
  fclose('all');
  a=1/(val2-val1);
  b=-val1/(val2-val1);
  
  fix=strcat(file_in,'.out');
  f=fopen(fix,'w');
  fprintf(f,'%i\n',N);
  fprintf(f,'\n');
  fclose('all');
  PR=Iterative(file_in,d,eps);
  f=fopen(fix,'a');
  fprintf(f,'%f\n',PR);
  fprintf(f,'\n');
  fclose('all');
  PR=Algebraic(file_in,d);
  f=fopen(fix,'a');
  fprintf(f,'%f\n',PR);
  fprintf(f,'\n');
  
  PR1=sort(PR,'descend');
  
  for i=1:N
      for j=1:N
          if PR1(i)==PR(j) k=j;
          end
      end
      j=k;
      if PR1(i)<val1 u=0;
      else if PR1(i)>=val1 && PR1(i)<=val2 u=a*PR1(i)+b;
          else u=1;
          end
      end
      
      fprintf(f,'%i %i %f\n',i,j,u);
  end

fclose('all');
end

%Intrari: file_in - nume fisier transmis ca parametru
%         d-valoarea probabilitatii ca un utilizator sa continue navigatul
%         pe internet
%         eps-valoarea erorii care apare in calculul page rank'ului
%Iesiri: PR-valaorea page rank'ului,calculata de algoritm
%Variabile folosite pe parcurs:
%         N-numarul de noduri citit din fisier
%         i-indicele nodului
%         C-vectorul de noduri vecine cu nodul i
%         val1,val2 - valorile intre care se incadreaza page rank'ul pentru
%         calculul functiei u
%         coeficientii functiei u(x)=ax+b
%         u-vector in care retinem valorile intoarse de functia u(x)=ax+b

