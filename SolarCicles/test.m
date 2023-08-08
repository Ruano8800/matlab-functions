function test
% script de afisare al matricei rezultatelor pentru convergenta functiilor 
% eval_interpolator_c si eval_interpolator_d
% rezultatele pentru functia eval_interpolator_d nu pot fi accesate
% deoarece nu am reusit sa scriu codul aferent acestei functii

N=zeros(2,6);

% fiecare valoare din matricea N primeste valoarea corespunzatoare a
% numarului de interpolare aferent functiei
% eval_interpolator_c/eval_interpolator_d

[N(1,1),x,y,z]=eval_interpolator_c(1,0.16);
[N(1,2),x,y,z]=eval_interpolator_c(2,0.16);
[N(1,3),x,y,z]=eval_interpolator_c(3,0.1);
[N(1,4),x,y,z]=eval_interpolator_c(4,0.000001);
[N(1,5),x,y,z]=eval_interpolator_c(5,0.000001);
[N(1,6),x,y,z]=eval_interpolator_c(6,0.1);
    

%daca fisierul eval_interpolator_d ar contine functia corespunzatoarea
%aceasta ar fi secventa de apel pentru memorarea valorilor matricei N

%[N(2,1),x,y,z]=eval_interpolator_d(1,0.1);
%[N(2,2),x,y,z]=eval_interpolator_d(2,0.1);
%[N(2,3),x,y,z]=eval_interpolator_d(3,0.1);
%[N(2,4),x,y,z]=eval_interpolator_d(4,0.000001);
%[N(2,5),x,y,z]=eval_interpolator_d(5,0.000001);
%[N(2,6),x,y,z]=eval_interpolator_d(6,0.1);

N    %afisarea matricei N
end

