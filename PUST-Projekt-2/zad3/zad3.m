% Wejście-Wyjście:

clear;
kk=200;
u(1:kk)=0;
y(1:kk)=0;
z(1:kk)=0;
Zpp=0;
Upp=0;
Ypp=0;
ypp(1:kk)=Ypp;

u(20:kk)=1;
for k=8:kk
    y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7),z(k-3),z(k-4), ...
        y(k-1),y(k-2));
end

S=(y(21:kk)-ypp(21:kk))/(u(end)-u(1));
S(kk-21:kk)=S(end);

figure
stairs(1:kk,S)
xlabel('k')
ylabel('s')
title('Odpowiedź skokowa toru wejście-wyjście:')
print('Odpowiedź skokowa toru wejście-wyjście.png', ...
    '-dpng','-r400')

% Zakłócenie-Wyjście:

kk=200;
u(1:kk)=0;
y(1:kk)=0;
z(1:kk)=0;
Zpp=0;
Upp=0;
Ypp=0;
ypp(1:kk)=Ypp;

z(20:kk)=1;
for k=8:kk
    y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7),z(k-3),z(k-4), ...
        y(k-1),y(k-2));
end

Sz=(y(21:kk)-ypp(21:kk))/(z(end)-z(1));
Sz(kk-21:kk)=Sz(end);

figure
stairs(1:kk,Sz)
xlabel('k')
ylabel('s_{z}')
title('Odpowiedź skokowa toru zakłócenie-wyjście:')
print('Odpowiedź skokowa toru zakłócenie-wyjście.png', ...
    '-dpng','-r400')