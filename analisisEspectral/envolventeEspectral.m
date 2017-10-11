clear all; clc; close all;
%[y,fs] = audioread('aeiuoDiego8.wav'); % AEIUO
[y,fs] = audioread('vozfemenina.wav'); 
L = length(y);
figure(1), plot(y); grid on;
title('Grafica del sonido en funcion del tiempo'); 
xlabel('Tiempo (s)'); ylabel('y(t)');
%sound(y,fs)

h = 0.54 + 0.46*cos(2*pi*(-100:99)'/200); % Ventana Hamming
W = fs/40; % Para 40 se obtienen 100 muestras por ventana
DW = W/2; % Cada 100 muestras empieza la otra ventana
NW = floor((L-W)/DW);
for n = 1:NW
    v = y((n-1)*DW+(1:W)).*h; % Calculo convolucion
end

p = 12; % Orden del filtro
% Se calculan los coeficientes de correlacion de la seÃ±al consigo misma
r = zeros(p+1,1);
for i = 1:p+1
    r(i) = v(1:201-i)'*v(i:end);
end

% Se procede a construir la matriz, la primer columna de r
R = r(1:p);
r = r(2:p+1); % Vector independiente
% Se construyen las columnas
for j = 2:p
    R(:,j) = [R(j,1); R(1:p-1,j-1)];
end

a = -inv(R)*r; % Coeficientes
V = fft(v,2048);
[H,w] = freqz(1,[1:a],1024); % Rta en frecuencia y la frecuencia; con estas
% dos se obtiene la envolvente espectral, que son las frecuencias de
% resonancia; A partir de eso se puede indentificar el fonema

V = V(1:1024);

H = H*max(abs(V))/max(abs(H));
H = 20*log10(abs(H));
V = 20*log10(abs(V)); % Envolvente espectral
figure(2), plot(w,[H,V]); grid on;
title('Envolvente Espectral'); 
xlabel('Frecuencia Angular'); ylabel('Amplitud en dB');
