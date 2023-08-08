function test_grafic
%functie de trasare a graficelor celor doua functii de interpolare
%  eval_interpolator_c si eval_interpolator_d
%  am trasat graficul functiei eval_interpolator_c folosind comanda subplot
%  comanda ce mi-a permis trasarea tuturor celor 6 grafice in acelasi
%  sistem de coordonate 
%  graficul functiei eval_interpolator_d nu poate fi accesat deoarece nu am
%  reusit sa scriu codul corespunzator pentru aceasta functie

subplot(2,2,1);
[N,x,z,fNk,pNk]=eval_interpolator_c(1,0.16);
plot(z,fNk);
hold on;
plot(x,pNk);

subplot(2,2,1);
[N,x,z,fNk,pNk]=eval_interpolator_c(2,0.16);
plot(z,fNk);
hold on;
plot(x,pNk);

subplot(2,2,1);
[N,x,z,fNk,pNk]=eval_interpolator_c(3,0.1);
plot(z,fNk);
hold on;
plot(x,pNk);

subplot(2,2,1);
[N,x,z,fNk,pNk]=eval_interpolator_c(4,0.000001);
plot(z,fNk);
hold on;
plot(x,pNk);

subplot(2,2,1);
[N,x,z,fNk,pNk]=eval_interpolator_c(5,0.000001);
plot(z,fNk);
hold on;
plot(x,pNk);

subplot(2,2,1);
[N,x,z,fNk,pNk]=eval_interpolator_c(4,0.1);
plot(z,fNk);
hold on;
plot(x,pNk);

%daca functia eval_interpolator_d ar fi fost scrisa asa ar arata codul
%necesar pentru trasarea graficului 

%subplot(2,2,1);
%[N,x,z,fNk,pNk]=eval_interpolator_d(1,0.16);
%plot(z,fNk);
%hold on;
%plot(x,pNk);

%subplot(2,2,1);
%[N,x,z,fNk,pNk]=eval_interpolator_d(2,0.16);
%plot(z,fNk);
%hold on;
%plot(x,pNk);

%subplot(2,2,1);
%[N,x,z,fNk,pNk]=eval_interpolator_d(3,0.1);
%plot(z,fNk);
%hold on;
%plot(x,pNk);

%subplot(2,2,1);
%[N,x,z,fNk,pNk]=eval_interpolator_d(4,0.000001);
%plot(z,fNk);
%hold on;
%plot(x,pNk);

%subplot(2,2,1);
%[N,x,z,fNk,pNk]=eval_interpolator_d(5,0.000001);
%plot(z,fNk);
%hold on;
%plot(x,pNk);

%subplot(2,2,1);
%[N,x,z,fNk,pNk]=eval_interpolator_d(6,0.1);
%plot(z,fNk);
%hold on;
%plot(x,pNk);
end

