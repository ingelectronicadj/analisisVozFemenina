clear all
clc
close all
[x,fs]=wavread('vozfemenina.wav');
%sound(x,fs);
E = zeros(194,1);
Z=E;
V=400;
for n=1:194
    i=200*(n-1)+(1:V)';
    y=x(i);
    E(n) = 10*log10(y'*y/V);%dividido en # muestras para energ�a promedio
    %j=(1:399)';
    %p=y(j).*y(j+1);
    Z(n)=sum(abs(sign(y(2:end))-sign(y(1:end-1))))/798;
end
n=1:194;
%Normalizando
E=(E-min(E))/(max(E)-min(E));
Z=(Z-min(Z))/(max(Z)-min(Z));
sE=zeros(194,1);
sZ=sE;
sS=sE;
%para la energ�a
for n=1:194
    if E(n)>0.7
        sE(n)=1;
    elseif E(n)<0.4
        sE(n)=0;
    else
        if(n>1)
            sE(n)=sE(n-1);
        else
            sE(n)=0;
        end
    end
end
%para los cruces por cero
for n=1:194
    if Z(n)>0.2
        sZ(n)=1;
    elseif Z(n)<0.1
        sZ(n)=0;
    else
        if(n>1)
            sZ(n)=sZ(n-1);
        else
            sZ(n)=0;
        end
    end
end
%decisi�n de estado
for n=1:194
    if sE(n)==1 && sZ(n)==0
        sS(n)=1;%vocal
    elseif sE(n)==1 && sZ(n)==1
        sS(n)=0.5;%no vocalizado
    else
        sS(n)=0;%silencio
    end
end

n=1:194;
subplot(411);
k=(0:length(x)-1)/200;
plot(k,x,'b-');
title('Senal de audio');
ylabel('Amplitud');
grid on
grid minor

subplot(412);plot(n,sE(n),'r');
hold on;
plot(n,E(n),'b');
title('Energia');
ylabel('Amplitud Normalizada','FontSize', 8);
grid on
grid minor

subplot(413);plot(n,sZ(n),'r');
hold on;
plot(n,Z(n),'b');
title('Cruces por cero');
ylabel('Amplitud Normalizada','FontSize', 8);
grid on
grid minor

subplot(414);plot(n,sS(n),'r');
text(70,0.5,'vocal =1 ; no vocal=0.5 ; silencio=0','Color','red');   
title('Cuantizacion para la deteccion de vocal & no vocal');
ylabel('Amplitud');
xlabel('Eje de tiempo - 5s a 200 muestras');
hold on;
k=(0:length(x)-1)/200;
plot(k,abs(x)/max(abs(x)),'b-');
grid on
grid minor

figure(2);
t=(0:length(x)-1)'/fs;
n=1:194;
k=(0:length(x)-1)/200;
plot(k,abs(x)/max(abs(x)),'b-',n,E,'r-',n,Z,'g-')
hold on; plot(n,sS(n),'k','linewidth',2)
hold on; stem(n,E,'ro')
hold on; stem(n,Z,'gx')
text(68,0.89,'|x| = Valor absoluto de la senal de audio','Color','b'); 
text(68,0.83,'E = Energia','Color','r');
text(68,0.86,'Z = Cantidad de cruces por cero','Color','g');
text(68,0.8,'sS = Codificacion','Color','k');
text(68,0.78,'vocal =1 ; no vocal=0.5 ; silencio=0','Color','k');
title('All in one - Identificaci�n de fonemas');
ylabel('Amplitud');
xlabel('Eje de tiempo - 5s a 200 muestras');