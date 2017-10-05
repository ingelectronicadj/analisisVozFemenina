clear all; clc; close all;
fs = 8000;
[y,fs] = wavread('aeiuoDiego8.wav'); % En matlab version 2012 Unix para Linux
%[y,fs] = audioread('aeiuoDiego.wav'); % En Windows
L = length(y);
% xSeg = 0.0:0.5:6; % Debes ajustar el eje temporal a 6s
%plot(xSeg,y);
plot (y); %temporalmente
grid on
title('Grafica del sonido en funcion del tiempo'); 
xlabel('Tiempo (s)'); ylabel('y(t)')
%sound(y,fs)

h = 0.54 + 0.46*cos(2*pi*(-100:99)'/200); % Ventana Hamming
W = fs/40; % Para 40 se obtienen 100 muestras por ventana
DW = W/2; % Cada 100 muestras empieza la otra ventana
NW = floor((L-W)/DW);
for n = 1:NW
    v = y((n-1)*DW+(1:W)).*h; % Calculo convolucion
end

p = 12; % Orden del filtro
% Se calculan los coeficientes de correlacion de la señal consigo misma
r = zeros(p+1,1);
for i = 1:p+1
    r(i) = v(1:201-i)'*v(i:end);
end