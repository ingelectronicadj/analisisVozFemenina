clear all;
%%%%%%%%-----------Senal Original-----------%%%%%%%%
% Cargamos fichero .wav para su respectivo analisis
% Donde y=(sin(fr*2*pi*t)) y fs= frecuencia de muestreo
[y fs] = wavread('/home/asus/Escritorio/U2016/senales/vozfemenina.wav');
vozFemenina = wavread('/home/asus/Escritorio/U2016/senales/vozfemenina.wav');
% Graficamos el sonido en funcion del tiempo
figure (1)
plot (y) %. plot(y.^2)
title('Grafica del sonido en funcion del tiempo')
xlabel('Tiempo (s)')
ylabel('y(t)')
% Reproducimos el audio con la siguiente linea
sound (y,fs)

%%%%%%%%-----------Nueva Senal-----------%%%%%%%%
% A continuacion se rompe la senal en frames de 0.1 segundos
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

nuevaSenal(32500:end) = [];
figure (2)
plot(nuevaSenal)
xlim ([0 30700])
title('Grafica del sonido en funcion del tiempo')
xlabel('Tiempo (s)')
ylabel('y(t)')
sound(nuevaSenal,fs)

%%%%%%%%-----------240 Muestras-----------%%%%%%%%
%Tamaño de la nueva senal:32500
%Numero de frames 240
%Llave=> 32500/240=135
muestra=1;
tramo=0;
%-----Grafica de las muestras de la señal--------%
for div = 1 : 50
    tramo=tramo+1;
    grafica=muestra+135;
    figure(3)
    subplot(10,5,div),
    plot(nuevaSenal(muestra:grafica))
    muestra=muestra+135;
end
for div = 1 : 50
    tramo=tramo+1;
    grafica=muestra+135;
    figure(4)
    subplot(10,5,div),
    plot(nuevaSenal(muestra:grafica))
    muestra=muestra+135;
end
for div = 1 : 50
    tramo=tramo+1;
    grafica=muestra+135;
    figure(5)
    subplot(10,5,div),
    plot(nuevaSenal(muestra:grafica))
    muestra=muestra+135;
end
for div = 1 : 50
    tramo=tramo+1;
    grafica=muestra+135;
    figure(6)
    subplot(10,5,div),
    plot(nuevaSenal(muestra:grafica))
    muestra=muestra+135;
end
for div = 1 : 40
    tramo=tramo+1;
    grafica=muestra+135;
    figure(7)
    subplot(10,4,div),
    plot(nuevaSenal(muestra:grafica))
    muestra=muestra+135;
end
