clear all
load('vecw.mat');
Fs = 8000;
y = wavrecord(3*Fs,Fs);
h=y;
wavplay(y,Fs);
coef=13;
p = coef-1;
x = y(1:24000).*hamming(24000);
r = zeros(15,1);
for k=0:15
r(k+1) = x(k+1:24000)'*x(1:24000-k);
end
R=r(1:p);
r = r(2:(p+1));
for i=2:p
R(:,i) = [R(i,1); R(1:(p-1),i-1)];
end
a= -inv(R)*r;
a=[1 a'];
for tipfo=1:5
resul(1,tipfo)=a(1,:)*w(:,tipfo);
end;

if resul(1,1)>0
    f=imread('a.jpg');
    imshow(f)
elseif resul(1,2)>0
    f=imread('e.jpg');
    imshow(f)
elseif resul(1,3)>0
    f=imread('i.jpg');
    imshow(f)
elseif resul(1,4)>0
    f=imread('o.jpg');
    imshow(f)
elseif resul(1,5)>0
    f=imread('u.jpg');
    imshow(f)
else
    f=imread('hola.jpg');
    imshow(f)
end;







