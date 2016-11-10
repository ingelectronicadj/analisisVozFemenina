clear all;
%%%%%%%%-----------Senal Original-----------%%%%%%%%
% Cargamos fichero .wav para su respectivo analisis
% Donde y=(sin(fr*2*pi*t)) y fs= frecuencia de muestreo
[y fs] = wavread('/home/asus/Escritorio/U2016/senales/analisisVozFemenina/vozfemenina.wav');
vozFemenina = wavread('/home/asus/Escritorio/U2016/senales/analisisVozFemenina/vozfemenina.wav');
% Graficamos el sonido en funcion del tiempo
figure (1)
plot (y) %. plot(y.^2)
grid
title('Grafica del sonido en funcion del tiempo')
xlabel('Tiempo (s)')
ylabel('y(t)')
% Reproducimos el audio con la siguiente linea
sound (y,fs)

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
%Llave=> 32500/240=135
muestra=1;
tramo=0;
%-----Grafica de las muestras de la señal--------%
for div = 1 : 35
    tramo=tramo+1;
    grafica=muestra+135;
    figure(3)
    subplot(7,5,div),
    plot(nuevaSenal(muestra:grafica))
    %title('Primer plot de muestras 0..35 frames')
    muestra=muestra+135;
end                                       
for div = 1 : 35
    tramo=tramo+1;
    grafica=muestra+135;
    figure(4)
    subplot(7,5,div),
    plot(nuevaSenal(muestra:grafica)) 
    %title('Primer plot de muestras 35..70 frames')
    muestra=muestra+135;
end
for div = 1 : 35
    tramo=tramo+1;
    grafica=muestra+135;
    figure(5)
    subplot(7,5,div),
    plot(nuevaSenal(muestra:grafica))
    %title('Primer plot de muestras 70..105 frames')
    muestra=muestra+135;
end
for div = 1 : 35
    tramo=tramo+1;
    grafica=muestra+135;
    figure(6)
    subplot(7,5,div),
    plot(nuevaSenal(muestra:grafica)) 
    %title('Primer plot de muestras 105..140 frames')
    muestra=muestra+135;
end
for div = 1 : 35
    tramo=tramo+1;
    grafica=muestra+135;
    figure(7)
    subplot(7,5,div),
    plot(nuevaSenal(muestra:grafica)) 
    %title('Primer plot de muestras 140..175 frames')
    muestra=muestra+135;
end
for div = 1 : 35
    tramo=tramo+1;
    grafica=muestra+135;
    figure(8)
    subplot(7,5,div),
    plot(nuevaSenal(muestra:grafica))
    %title('Primer plot de muestras 175..210 frames')
    muestra=muestra+135;
end
for div = 1 : 35
    tramo=tramo+1;
    grafica=muestra+135;
    figure(9)
    subplot(7,5,div),
    plot(nuevaSenal(muestra:grafica)) %Primer plot de muestras 210..240 frames
    %title('Primer plot de muestras 210..240 frames')
    muestra=muestra+135;
end
