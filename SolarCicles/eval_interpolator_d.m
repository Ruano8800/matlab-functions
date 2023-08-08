function [N,x,z,pNk,fNk] = eval_interpolator_d(tip, eps)
%functie de evaluare discreta -functia nu realizeaza nicio operatie
%concreta,deoarece nu am reusit sa o implementez

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


end

