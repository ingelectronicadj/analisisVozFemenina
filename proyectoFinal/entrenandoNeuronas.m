clear all
load('vect.mat');
load('veca.mat');
Nm=300; %numero de muestras;
Nne=5; %numero de neuronas o tipo de fonemas
ent=13; %entradas o coeficientes
yeta=a;
t=t';
t = [t==1 t==2 t==3 t==4 t==5]; % t(k,j) es la función objetivo de la neurona j ante la muestra k
a = [ones(Nm,1) a']; % a(k,i) es la entrada i de la muestra k
w = 1-2*rand(ent,Nne); % w(i,j) es el peso de la entrada i de la neurona j
eta = 0.01; % constante de aprendizaje
errores=1; % esto lo hice yo
z=zeros(Nm,Nne);

%for co=2:13
%a(:,co)=(a(:,co)-min(a(:,co)))/(max(a(:,co))-min(a(:,co)));
%end;


while(errores>0.3)  % Criterio de parada (¿bueno?)
    for k=1:Nm % Recorre todas las muestras

         for j=1:Nne % Recorre todas las neuronas
             z(k,j) = 1/(1+exp(-a(k,:)*w(:,j))); % salida de la neurona j ante la muestra k
             % talvez para w toque dejarlo asi: w(j,:)' pero deberia estar
             % seguro
         end
         
          for i=1:ent % Recorre todas las entradas
              for j=1:Nne % Recorre todas las neuronas
                  w(i,j) = w(i,j)+eta*(t(k,j)-z(k,j))*a(k,i)*z(k,j)*(1-z(k,j)); % Actualiza w
              end
          end
    end
   %errores = sum(sum(abs(t-(z>0.5)))); % Numero de equivocaciones
   errores = sum(sum(abs(t-(z))))/(Nm); % Numero de equivocaciones
    eta = eta+0.001;
end
for mus=1:Nm
for tipfo=1:5
resul(mus,tipfo)=a(mus,:)*w(:,tipfo);
end;
end;

%end;