function [ y ] = sinte( x )
p=12;%coeficientes minimos para un error aceptable 
% r=autocorr(x,p) forma rapida
    for k=0:p
        r(1+k)=x(1:(512-k))'*x((k+1):512);
    end
r=r(:);
R=r(1:p);
r=r(2:p+1);

    for k=2:p
        R(:,k)=[R(k,1);R(1:p-1,k-1)];
    end
a=-inv(R)*r;
X=fft(x,2048);X=abs(X(1:1024));%tomamos la senal de 0 a pi
[H,w]=freqz(1,[1;a]',1024);%hallamos la respuesta en frecuencia del flitro
H=H*max(X)/max(H);%ganancia
X=20*log10(X);H=20*log10(H);%expresamos en db
%figure(), plot(w,X,'b-',w,H,'r-'), title('Envolvente Espectral y FFT');

X=zeros(512,p);
X(:,1)=[0;x(1:511)];%primera base de mi espacio vectorial
    for k=2:p 
        X(:,k)=[0;X(1:511,k-1)];%construccion del resto de  col o bases que son la anterior desplazada
    end
x_=-X*a;
%figure(), plot(x,'b-');hold on;plot (x_,'r-');
e=x-x_;
%figure(), plot(e);

    for k=0:180
        r(1+k)=e(1:(512-k))'*e((k+1):512);
    end
%figure(), plot(r)

y=filter(1,[1;a],e);
%figure(), plot(x,'b-');hold on; plot(y,'r--')
d=(0:8191)';
d=(mod(d,32)==0);
y=filter(1,[1;a],d);
%figure(), plot(y,'b-')
end

