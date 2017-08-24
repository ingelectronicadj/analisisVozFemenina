clear all; clc; close all;
[x,fs]=wavread('vozfemenina.wav');%Si usas una version superior a 2003 usa la siguiente linea
%[x,fs]=audioread('vozfemenina.wav');
N=length(x);
t = (0:N-1)'/fs;

figure(1), subplot(311), plot(t,x);
title('Senal de Audio');
X1=fft(x);
X1=X1(1:N/2);
f=(0:N/2-1)'*fs/N;
subplot(312);plot(f,abs(X1)); title('Valor Absoluto de la FFT');grid on; grid minor;
subplot(313);plot(f,unwrap(angle(X1))); title('Fase de la FFT');grid on; grid minor;

LV=1024;
DV=64;
NV=floor((N-LV)/DV);
Hamming=0.54-0.46*cos(2*pi*(0:LV-1)'/LV);
for v=0: NV-1
    y=x(DV*v + (1:LV)).*Hamming;
    Y=20*log10(abs(fft(y)));
    Y=Y(1:LV/2);
    X(:,v+1)=Y;
end
figure(2), mesh(X); view(2);