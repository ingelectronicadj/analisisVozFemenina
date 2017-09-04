clear all; clc; close all;
% [x,fs]=audioread('vozfemenina.wav');
[x,fs]=wavread('vozfemenina.wav');
x = x(1801:2000).*(0.54 - 0.46*cos(pi*(0:199)'/100)); 
%Tomamos una muestra de la se�al desde 1801 y la montamos sobre una ventana Hamming de
%200 muestras
figure(1), subplot(2,1,1);plot(x); title('Seccion de audio para realizar analisis de la S'); hold on;
[N,F,A,W] = firpmord([50 100 400 450], [0 1 0], [1 1 1]/200,fs);%#Coeficientes en el filtro, frecuencia, amplitud, ponderaciones de cada banda
% firpmord([frecuencias], ganancias, rizado) -- Parks-McClellan optimal FIR filter order estimation
h = firpm(N,F,A,W);
x = conv(h,x);
hold on; grid on; grid minor;
x = x(N/2 + (1:200));
plot(x); xlabel('Tiempo'); ylabel('Tono');
fTono = fs/32; %tono con el que pronuncia la S

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,fs]=wavread('vozfemenina.wav');
x = x(12200+(1:200)).*(0.54 - 0.46*cos(pi*(0:199)'/100)); 
%Tomamos una muestra de la se�al desde 1801 y la montamos sobre una ventana Hamming de
%200 muestras
subplot(2,1,2);plot(x); title('Seccion de audio para realizar analisis de la E'); hold on;
[N,F,A,W] = firpmord([50 100 400 450], [0 1 0], [1 1 1]/200,fs);%#Coeficientes en el filtro, frecuencia, amplitud, ponderaciones de cada banda
% firpmord([frecuencias], ganancias, rizado) -- Parks-McClellan optimal FIR filter order estimation
h = firpm(N,F,A,W);
x = conv (h,x);
hold on; grid on; grid minor;
x = x(N/2 + (1:200));
plot(x); xlabel('Tiempo'); ylabel('Tono');
fTono = fs/32; %tono con el que pronuncia la E

y=x;
for i=1:200
    z(i) = (y-x)*(y-x)';
    y = [0 y(1:199)];% vamos a desplazar y
end

figure(3),plot(z);title('Representacion grafica de la energia'); grid on; grid minor;