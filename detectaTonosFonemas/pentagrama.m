close all; clear all; clc;
[x,fs]= wavread('vozfemenina.wav');
%[x,fs]= audioread('vozfemenina.wav');% Carga voz
L = length(x) ; % Obtener el tamano de x
figure(1), subplot(3,1,1), plot(x); grid on; title('Audio Voz Femenina'); xlabel('Tiempo'); ylabel('Amplitud');
h = 0.54+0.46*cos(2*pi*(-100:99)'/200) ; % Ventana hamming selecciona porcion de la senal
subplot(3,1,2), plot(h); title('Ventana de Hamming');
text(70,0.62,'h = 0.54+0.46*cos(2*pi*(n)/200)','Color','b', 'FontSize', 12);  
xlabel('Numero de Muestras'); ylabel('Amplitud');grid on;


W = fs/40; % Para 40 se obtienen 100 muestras por ventana
DW = W/2; % Cada 100 muestras empieza la otra ventana
NW = floor((L-W)/DW); % floor (39120-200) /10 = 389.2 --> 389
E= zeros(NW,1); % Vector para guardar los valores de Energia.
z = E; % Vector que almacena los cruces por cero .

for n= 1 :NW
    y = x((n-1)*DW+(1:W)); % Vector para calcular energia
    E(n)=10*log10(y'*y); % Energia en decibeles
    z(n)=sum(abs(sign(y(2:end)) - sign(y(1:end-1))))/2/W; %cruces por zero
end
x=abs(x)/max(x) ;
E=(E-min(E))/(max(E)-min(E)) ;
z=(z-min(z))/(max(z)-min(z)) ;
subplot(3,1,3), plot(E); hold on; plot(z,'r');grid on; 
title('Zero Crossing Rate y Energia en dB'); xlabel('Numero de Ventanas'); ylabel('Amplitud')
text(150,0.7,'Energia','Color','b');  
text(150,0.8,'Zero Crossing Rate','Color','r');

for n = 1:NW
    v = x((n-1)*DW+(1:W)).*h ; % Vector que calcula la convolucion
    for N = 0:50
        phi = v(N+(1:199-N)') ;
        Ep = phi'* phi ; % Energ?a de phi <la proyeccion>
        a(N+1) = (v(1:199-N)'*phi)/Ep;
    end
    if E(n) < 0.1
        f(n+1) = 0;
    else
        t = max(a(10:50)); % Se busca el maximo
        posx(n+1) = find(t==a) ;
        pos(n+1) = posx(n+1)-1;
        f(n+1) = 8000/pos(n+1) ;
    end
% Se calculan los tonos para la grafica
    if E(n) < 0.1
        tono(n+1) = -100;
    else
        tono (n+1) = 12*log2(f(n+1)/440) ;
    end
end
s = 0:0.01218:4.74;
figure(2), plot(s,tono ,'o');
axis([0 4.75 -17 13]);
Ev=v'*v ;
title('Pentagrama de la Voz Femenina');grid on;
ylabel('Tono'); xlabel('Tiempo')
ytickangle(90);
yticks([-17:13]);
hold on
text(0.08,-17,'Re','Color','b'); 
text(0.08,-16,'Re#','Color','b'); 
text(0.08,-15,'Mi','Color','b'); 
text(0.08,-14,'Fa','Color','b'); 
text(0.08,-13,'Fa#','Color','b'); 
text(0.08,-12,'Sol','Color','b'); 
text(0.08,-11,'Sol#','Color','b'); 
text(0.08,-10,'La','Color','b'); 
text(0.08,-9,'La#','Color','b'); 
text(0.08,-8,'Si','Color','b'); 
text(0.08,-7,'Do','Color','b'); 
text(0.08,-6,'Do#','Color','b'); 
text(0.08,-5,'Re','Color','b'); 
text(0.08,-4,'Re#','Color','b'); 
text(0.08,-3,'Mi','Color','b'); 
text(0.08,-2,'Fa','Color','b'); 
text(0.08,-1,'Fa#','Color','b'); 
text(0.08,0,'Sol','Color','b');
text(0.08,1,'Sol#','Color','b');
text(0.08,2,'La','Color','b');
text(0.08,3,'La#','Color','b');
text(0.08,4,'Si','Color','b');
text(0.08,5,'Do','Color','b');
text(0.08,6,'Do#','Color','b');
text(0.08,7,'Re','Color','b');
text(0.08,8,'Re#','Color','b');
text(0.08,9,'Mi','Color','b');
text(0.08,10,'Fa','Color','b');
text(0.08,11,'Fa#','Color','b');
text(0.08,12,'Sol','Color','b');
text(0.08,13,'Sol#','Color','b');

