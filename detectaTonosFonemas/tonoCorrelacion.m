clear all; clc; close all;
[x fs] = audioread('../audios/vozfemenina.wav');
[N,F,A,W] = firpmord([50 100 400 450],[0 1 0],[1 1 1]/200,fs);
h = firpm(N,F,A,W);
x = conv(h,x);
LS = length(x);
LV = 256;
DV = 64;
NV = floor((LS - LV)/DV);
ts = (0:LV-1)'/fs;
for v = 1:NV
    y = x(64*(v-1)+(1:LV)');
    E = (y'*y)/LV;
    if E>0.00005
        c1 = 0.35*max(abs(y));
        y = y.*(abs(y)>c1);
        for i = 1:160
            y1 = y(i:LV);
            y2 = y(1:LV-i+1);
            co(i) = y1'*y2;
        end
        co(1:15)=0;
        subplot(211); plot(ts,y);
        subplot(212); plot(ts(1:160),co);
        drawnow
        [~,N] = max(co);
        tono(v) = fs/N;
        if tono(v)>370
            tono(v) = tono(v)/2;
        end
        if v>1
            if ~isnan(tono(v-1))
               if tono(v)>1.5*tono(v-1)
                   tono(v)/2;
               end
            end
        end
    else 
        tono(v) = nan;
    end
end
t = (0:LS-1)'/fs;
figure
subplot(211); plot(t,x)
tt = (0:NV-1)*DV/fs + LV/2/fs;
subplot(212); plot(tt,tono)
%Los picos que se observan en la grafica, en especial uno que manda la
%grafica a un un valor elevado en amplitud es un error considerado por la
%falta de considerar los cruces por cero. Basicamente el error sera notable
%en los fragmentos de audio con no vocal (consonantes)
