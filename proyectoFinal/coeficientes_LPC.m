coef=13;
p = coef-1;
[x,fs,nb]=wavread('unarc.wav');
yellow=x(1:40000);
y=x;
Nm=300;
for cont=0:Nm-1
x = y(cont*4000+1:4000*(cont+1)).*hamming(4000);
r = zeros(15,1);
for k=0:15
r(k+1) = x(k+1:4000)'*x(1:4000-k);
end
R=r(1:p);
r = r(2:(p+1));
for i=2:p
R(:,i) = [R(i,1); R(1:(p-1),i-1)];
end
a(:,cont+1) = -inv(R)*r;
end;