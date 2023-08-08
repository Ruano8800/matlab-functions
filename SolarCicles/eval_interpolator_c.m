function [N,x,z,fNk,pNk] = eval_interpolator_c(tip, eps)
%functie de evaluare continua
% eval_interpolator - determina cat de repede converge un polinom
%de interpolare
% tip - 1 lagrange
%       2 newton
%       3 linear spline
%       4 natural
%       5 cubic spline
%       6 fourrier
% eps - toleranta acceptata pentru convergenta
% Intrari:tip-numar natural de la 1-6,care are semnificatia de mai sus
%         eps-toleranta amxima acceptata in calcularea erorii la aproximarea
%             polinomului de interpolare cu functia intr-unul din cele Nr+1 puncte 
%             generate aleator
%Iesiri:N-numarul de puncte pentru care interpolantul converge
%       x-vectorul punctelor generate aleator intre [-pi.pi],puncte
%         necesare la trasarea graficului
%       z-vectorul celor Nk(i) puncte generate aleator intre
%         [-pi,pi],necesar la trasarea graficului
%       fNk-vectorul valorilor functiei in cele Nk(i) puncte,necesar la
%           trasarea graficului
%       pNk-vectorul valorilo polinomului in fiecare din cele Nr+1
%           puncte,necesar la trasarea graficului
%Variabile generale:I0-functia besseli in punctul (0,3)
%                   Nr=1000-numarul de puncte pe care se face interpolarea
%                   Nk(i)-numarul de puncte intermediare din [-pi,pi]
%                         pentru care se calculeaza coeficientii interpolantului
%                   x-vectorul celor Nr+1 puncte aleatoare generate intre
%                     [-pi,pi] pentru care se va calcula valoarea interpolantului
%                   f-functia f pentru fiecare dintre valorile vecotrului x
%                   h-constanta folosita in calcularea normei Euclidiene

a=3;
I0=besseli(0,a);
Nr=1000;
for i=2:10
    Nk(i)=2^i;
end

x=linspace(-pi,pi,Nr+1);

f(1:Nr+1)=(exp(a*cos(x(1:Nr+1))))/(2*pi*I0);
h=2*pi/(Nr+1);

switch(tip)
    case 1
        %polinomul de interpolare Lagrange
        N=0;
        for i=2:10
          E(1)=inf;
          z=linspace(-pi,pi,Nk(i));
          fNk(1:Nk(i))=(exp(a*cos(z(1:Nk(i)))))/(2*pi*I0);
          
          %calculul coeficientilor polinomului Lagrange
          A=zeros(Nk(i),1);
          Z=zeros(Nk(i),1);
          c=poly(z);
          
          for j=1:Nk(i)
              % calcul coeficienţi b impartirii
 		      % polinomului prin x-x(i)
              [b,r]=deconv(c,[1 -z(j)]);
              % calcul
              % p=(x(i)-x(1))...(x(i)-x(i-1))(x(i)-x(i+1))(x(i)-x(n))
              Z=z(j)-z;
              Z(j)=1;
              p=prod(Z);
              A(1:Nk(i))=A(1:Nk(i))+fNk(j)*b(1:Nk(i))'/p;
          end
          
          S=0;
          for j=1:Nr+1
             pNk(j)=polyval(A,x(j));
             S=S+(abs(f(j)-pNk(j)))^2;
          end 
          %calculul erorii comise prin aproximare functiei cu polinomul de
          %interpolare Lagrange
          E(i)=(h*S)^(1/2);
          
          %daca eroarea de la pasul curent este mai mica decat eroarea de
          %la pasul anterior si daca diferenta in modul dintre cele doua
          %este mai mica decat toleranta amxima a erorii atunci metoda
          %converge
          if E(i-1)>E(i) && abs(E(i)-E(i-1))<eps
              N=Nk(i);
              break;
          end
          
        end
      %daca N=0,atunci nu am gasit niciun punct care sa indeplineasca conditiile 
      %de convergenta deci metoda nu converge,N=infinit
      if N==0
            N=inf;
      end
        
        
    case 2
         %polinomul de interpolare Newton
         N=0;
         for i=2:10
             E(1)=inf;
           z=linspace(-pi,pi,Nk(i));
    
           fNk(1:Nk(i))=(exp(a*cos(z(1:Nk(i)))))/(2*pi*I0);
           
           for k=1:Nk(i)-1
               fNk(k+1:Nk(i))=(fNk(k+1:Nk(i))-fNk(k))./(z(k+1:Nk(i))-z(k));
           end
           b=fNk(:);
           %calculul coeficientilor polinomului Newton
           
           A=zeros(Nk(i),Nk(i));
           A(1,Nk(i))=b(1);
           c=zeros(Nk(i),1);
           
           for j=2:Nk(i)
               A(j,Nk(i)-j+1:Nk(i))=poly(z(1:j-1))*b(j);
           end
           
           for j=1:Nk(i)
               c(j)=sum(A(:,j));
           end
           
           %calculul erorii comise prin aproximare functiei cu polinomul de
           %interpolare Newton
           S=0;
           for j=1:Nr+1
              pNk(j)=polyval(c,x(j));
              S=S+(abs(f(j)-pNk(j)))^2;
           end  
           E(i)=(h*S)^(1/2);
    
           %daca eroarea de la pasul curent este mai mica decat eroarea de
           %la pasul anterior si daca diferenta in modul dintre cele doua
           %este mai mica decat toleranta amxima a erorii atunci metoda
           %converge
           if E(i-1)>E(i) && abs(E(i)-E(i-1))<eps
              N=Nk(i);
              break;
           end
    
       end
       if N==0
            N=inf;
       end
        
        
    case 3 
        %interpolarea cu functii spline liniare
        N=0;
        for i=2:10
          E(1)=inf;
          z=linspace(-pi,pi,Nk(i));
          fNk(1:Nk(i))=(exp(a*cos(z(1:Nk(i)))))/(2*pi*I0);
          
          %calculul coeficientilor functiilor spline liniare
          for j=2:Nk(i)
              H(j-1)=z(j)-z(j-1);
              A(j-1)=(fNk(j)-fNk(j-1))/H(j-1);
              B(j-1)=(z(j)*fNk(j-1)-z(j-1)*fNk(j))/H(j-1);
          end
          
          %calculul valorii acesto functii in cele Nr+1 puncte generate
          %aleator
          j=1;
          for k=1:Nr+1
            while (~(x(k)>=z(j) && x(k)<=z(j+1)))
                j=j+1;
            end
                pNk(k)=A(j)*x(k)+B(j);      
          end
          
          %calculul erorii de interpolare pentru functiile spline liniare
          S=0;
          for k=2:Nr
               S=S+(abs(f(k)-pNk(k)))^2;
          end          
          E(i)=(h*S)^(1/2);
          
          %daca eroarea de la pasul curent este mai mica decat eroarea de
          %la pasul anterior si daca diferenta in modul dintre cele doua
          %este mai mica decat toleranta amxima a erorii atunci metoda
          %converge
          if E(i-1)>E(i) && abs(E(i)-E(i-1))<eps
               N=Nk(i);
               break;
          end
      end
      if N==0
            N=inf;
      end
               
        
    case 4
        %interpolarea cu functii spline cubice,naturale
        N=0;
        for i=2:10
          E(1)=inf;
          z=linspace(-pi,pi,Nk(i));
          fNk(1:Nk(i))=(exp(a*cos(z(1:Nk(i)))))/(2*pi*I0);
          
          
          A=zeros(Nk(i),Nk(i));
          b=zeros(Nk(i),1);
          A(1,1)=1;
          A(Nk(i),Nk(i))=1;
          
          %formare si rezolvare sistem pentru a determina coeficientii celor n-1 
          %splineuri
          for j=2:Nk(i)-1
             A(j,j-1)=z(j)-z(j-1);
             A(j,j+1)=z(j+1)-z(j);
             A(j,j)=2*(A(j,j-1)+A(j,j+1));
             b(j)=3*(fNk(j+1)-fNk(j))/A(j,j+1)-3*(fNk(j)-fNk(j-1))/A(j,j-1);
          end
          
          c=A\b;
          %calcularea coeficientilor splineurilor folosind solutia sistemului,
          %calculata anterior
          for j=1:Nk(i)-1
              H=z(j+1)-z(j);
              c1(j)=fNk(j);
              c2(j)=(fNk(j+1)-fNk(j))/H-H/3*(2*c(j)+c(j+1));
              c3(j)=c(j);
              c4(j)=(c(j+1)-c(j))/3*H;
          end
          
          %calcularea valorii functiilor spline in cele Nr+1 puncte
          j=1;
          for k=1:Nr+1
            while (~(x(k)>=z(j) && x(k)<=z(j+1)))
                j=j+1;
            end
                pNk(k)=c1(j)+c2(j)*(x(k)-z(j))+c3(j)*(x(k)-z(j))^2+c4(j)*(x(k)-z(j))^3;      
          end
        
          S=0;
          for j=1:Nr+1
             S=S+(abs(f(j)-pNk(j)))^2;
          end
        
          E(i)=(h*S)^(1/2);
          
          %daca eroarea de la pasul curent este mai mica decat eroarea de
          %la pasul anterior si daca diferenta in modul dintre cele doua
          %este mai mica decat toleranta amxima a erorii atunci metoda
          %converge
          if E(i-1)>E(i) && abs(E(i)-E(i-1))<eps
                N=Nk(i);
                break
          end
               
          if N==0
              N=inf;
          end
        
      end  
        
        
    case 5
        %interpolarea cu functii spline cubice tensionate
        N=0;
        for i=2:10
          E(1)=inf;
          z=linspace(-pi,pi,Nk(i));
          fNk(1:Nk(i))=(exp(a*cos(z(1:Nk(i)))))/(2*pi*I0);
          
          A=zeros(Nk(i),Nk(i));
          b=zeros(Nk(i),1);
          d=zeros(Nk(i),1);
          
          %formare si rezolvare sistem pentru a determina coeficientii celor n-1 
          %splineuri
          A(1,1)=2*(z(2)-z(1));
          A(1,2)=z(2)-z(1);
          A(Nk(i),Nk(i))=2*(z(Nk(i))-z(Nk(i)-1));
          A(Nk(i),Nk(i)-1)=z(Nk(i))-z(Nk(i)-1);
          b(1)=3*(fNk(2)-fNk(1))/(z(2)-z(1))-3*(fNk(2)-fNk(1))/(z(2)-z(1));
          b(Nk(i))=3*(z(Nk(i))-z(Nk(i)-1))/(z(Nk(i))-z(Nk(i)-1))-3*(z(Nk(i))-z(Nk(i)-1))/(z(Nk(i))-z(Nk(i)-1));
          
          for j=2:Nk(i)-1
              A(j,j-1)=z(j)-z(j-1);
              A(j,j+1)=z(j+1)-z(j);
              A(j,j)=2*(A(j,j-1)+A(j,j+1));
              b(j)=3*(fNk(j+1)-fNk(j))/A(j,j+1)-3*(fNk(j)-fNk(j-1))/A(j,j-1);
          end
          c=A\b;
          
          %calcularea coeficientilor splineurilor folosind solutia sistemului,
          %calculata anterior
          for j=1:Nk(i)-1
              H=z(j+1)-z(j);
              b(j)=(fNk(j+1)-fNk(j))/H-H/3*(2*c(j)+c(j+1));
              d(j)=(c(j+1)-c(j))/3*H;
          end
       
          %calcularea valorii functiilor spline in cele Nr+1 puncte
          j=1;
          for k=1:Nr+1
              while (~(x(k)>=z(j) && x(k)<=z(j+1)))
                j=j+1;
              end
              pNk(k)=fNk(j)+b(j)*(x(k)-z(j))+c(j)*(x(k)-z(j))^2+d(j)*(x(k)-z(j))^3;      
          end
        
         S=0;
      
         for j=1:Nr+1
            S=S+(abs(f(j)-pNk(j)))^2;
         end
        
         E(i)=(h*S)^(1/2);
         
         %daca eroarea de la pasul curent este mai mica decat eroarea de
         %la pasul anterior si daca diferenta in modul dintre cele doua
         %este mai mica decat toleranta amxima a erorii atunci metoda
         %converge
         if E(i-1)>E(i) && abs(E(i)-E(i-1))<eps
             N=Nk(i);
             break;
         end
        
         if N==0
            N=inf;
         end
        
     end
      
    case 6
        %interpolarea cu metoda trigonometrica
        N=0;
        for i=2:10
          E(1)=inf;
          z=linspace(-pi,pi,Nk(i)+1);
          fNk(1:Nk(i)+1)=(exp(a*cos(z(1:Nk(i)+1))))/(2*pi*I0);
          
          A=zeros(Nk(i)+1,1);
          B=zeros(Nk(i)+1,1);
          
          %formare si rezolvare sistem pentru a determina coeficientii
          %polinomului de interpolare trigonometrica
          for j=2:Nk(i)+1
              A(1)=0;
              B(1)=0;
              a=3;
              for k=1:2*j
                  A(1)=A(1)+(exp(a*cos((2*k*pi)/(2*j+1))))/(2*pi*I0);
              end
              
              A(1)=A(1)*(sqrt(2)/(2*j+1));
              
              for k=2:2*j
                  A(j)=A(j)+((exp(a*cos((2*k*pi)/(2*j+1))))/(2*pi*I0))*(sin((2*k*pi*j)/(2*Nk(i)+1)));
                  B(j)=B(j)+((exp(a*cos((2*k*pi)/(2*j+1))))/(2*pi*I0))*(cos((2*k*pi*j)/(2*Nk(i)+1)));
              end
          
              A(j)=A(j)*(2/(2*j+1));
              B(j)=B(j)*(2/(2*j+1));
         
          end
          
          S=0;
          pNk(1)=A(1)/(sqrt(2));
          var=length(A);
          %calcularea valorii polinomului de interpolare trigonometrica in
          %cele NR+1 puncte
          for k=1:var
          for j=2:Nr+1
              pNk(j)=pNk(j-1)+A(k)*cos(j*x(j))+B(k)*sin(j*x(j));
          end
          
          pNk=pNk/(Nr/2);
          
          for j=1:Nr+1
            S=S+(abs(f(j)-pNk(j)))^2;
          end
          
          E(i)=(h*S)^(1/2);
          
          if E(i-1)>E(i) && abs(E(i)-E(i-1))<eps
             N=Nk(i);
             break;
          end
          end
      if N==0
          N=inf;
      end
            
   end

 end  
end

        

        

      

        

