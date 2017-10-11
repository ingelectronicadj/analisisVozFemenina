clear all;
%%%%%%%%-----------Senal Original-----------%%%%%%%%
% Cargamos fichero .wav para su respectivo analisis
% Donde y=(sin(fr*2*pi*t)) y fs= frecuencia de muestreo
[y fs] = audioread('../audios/vozfemenina.wav');
vozFemenina = audioread('vozfemenina.wav');
% Graficamos el sonido en funcion del tiempo
figure (1)
plot (y) %. plot(y.^2)
grid
title('Grafica del sonido en funcion del tiempo')
xlabel('Tiempo (s)')
ylabel('y(t)')
% Reproducimos el audio con la siguiente linea
%sound (y,fs)

%%%%%%%%-----------Nueva Senal-----------%%%%%%%%
% A continuacion se rompe la senal en frames de 0.1 segundos para
% identificar y suprimir los frames en silencio
duracionFrame = 0.1;
frame_len = duracionFrame*fs;
N = length(vozFemenina);
numFrames = floor(N/frame_len);
nuevaSenal = zeros(N,1);
contador = 0;
for k = 1 : numFrames
    % Extraemos frame por frame
    frame = vozFemenina((k-1)*frame_len + 1 : frame_len*k);
    % Identificamos silencio entre frames con amplitud max < 0.008
    max_val = max(frame);
    if(max_val > 0.008)
        %Este frame no esta en silencio
        contador = contador + 1;
        nuevaSenal((contador-1)*frame_len + 1 : frame_len*contador) = frame;
    end
end

nuevaSenal(30700:end) = [];
figure (2)
plot(nuevaSenal)
grid
xlim ([0 30700])
title('Grafica del sonido en funcion del tiempo')
xlabel('Tiempo (s)')
ylabel('y(t)')
sound(nuevaSenal,fs)

%%%%%%%%-----------240 Muestras-----------%%%%%%%%
%Tamaño de la nueva senal:32500
%Numero de frames 240
%Llave=> 30699/240=127

num=240;

tamano=floor(size(nuevaSenal,1) / num);
grupoSenales=zeros(num,tamano);
Ex=zeros(num,1);

for i=1:num
    inf=(tamano*(i-1))+1;
    sup=tamano*i;
    grupoSenales(i,:)=nuevaSenal(inf:sup);
    X=grupoSenales(i,:);
    Ex(i) = sum((abs(X)).^2)/tamano;
end
[B,I] = sort(Ex,'descend');
B=B(1:10) 
I=I(1:10)

dF = fs/tamano;
f = -fs/2:dF:fs/2-dF;

for i=1:size(I)
    indice=I(i)
    X=fftshift(fft(grupoSenales(indice,:)));
    figure();
    plot(f,abs(X)/tamano);
    grid;
   	title('Amplitud del espectro');
    xlabel('f(Hz)');
    ylabel('|y_i(t)|');
end


