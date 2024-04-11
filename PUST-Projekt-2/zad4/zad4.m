clear;
% Ustawienia
Tp=0.5;

kk=200;

Upp=0;
Ypp=0;
Zpp=0;

y(1:kk)=0;
u(1:kk)=0;
z(1:kk)=0;

yzad(1:7)=Ypp;
yzad(8:kk)=1;
ypp(1:kk)=Ypp;

E = 0;


% Ustawienia (wykresy u i y po kolei tak jak podane poniżej parametry)
%N          50, 100, 150 ,200
%Nu         25, 50, 75, 100
%lambda     0.25, 0.5, 0.75, 1

D = 200;
Dz = 200;
N = 200; 
Nu = 100; 
lambda = 1;

%Odpowiedź skokowa wejście-wyjście
u(20:kk)=1;
for k=8:kk
    y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7),z(k-3),z(k-4), ...
        y(k-1),y(k-2));
end

S=(y(21:kk)-ypp(21:kk))/(u(end)-u(1));
S(kk-21:kk)=S(end);

%Odpowiedź skokowa zakłócenie-wyjście
y(1:kk)=0;
u(1:kk)=0;
z(1:kk)=0;
z(20:kk)=1;
for k=8:kk
    y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7),z(k-3),z(k-4), ...
        y(k-1),y(k-2));
end

Sz=(y(21:kk)-ypp(21:kk))/(z(end)-z(1));
Sz(kk-21:kk)=Sz(end);

%Macierz M
M=zeros(N,Nu);
for i=1:N
    for j=1:Nu
        if (i>=j)
            if(i-j+1<=D)
                M(i,j)=S(i-j+1);
            else
                M(i,j)=S(D);
            end
        end
    end
end

%Macierz Mp
Mp = zeros(N, D-1);
for i=1:N
    for j=1:D-1
        if i + j <= D
            Mp(i, j) = S(i + j) - S(j);
        else
            Mp(i, j) = S(D) - S(j);
        end
    end
end

%Macierz Mpz
Mpz = zeros(N, Dz);
Mpz (:,1) = Sz(1:N)';
for i =1:N
    for j =2:Dz
        if i+j-1 <= Dz
            Mpz(i,j) = Sz(i+j-1)-Sz(j-1) ;
        else
            Mpz(i , j ) = Sz(Dz)-Sz(j -1) ;
        end
    end
end

% Wyliczenie K i deklaracja wektorów deltaUp i delta Zp
L = lambda * eye(Nu);
K = (M' * M + L)^(-1) * M';
dUpk(1:D-1)=0;
dUpk=dUpk';
dZpk(1:Dz)=0;
dZpk=dZpk';
u(1:kk) = Upp;
y(1:kk) = Ypp;
z(1:kk) = Zpp;
%DMC
for k=8:kk
    %Wyznaczenie wektorów Y i Yzad
    y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7),z(k-3),z(k-4), ...
        y(k-1),y(k-2));

    Yzad = yzad(k) * ones(N, 1);
    Y = y(k) * ones(N,1);
% Wyznaczenie deltaUp
    for i =1:D-1
        dUpk(i)=0;
        if k-1-i>0
            dUpk(i) = u(k-i) - u(k-1-i) ;
        end
    end
% Wyznaczenie deltaZp
    for i =1:Dz
        dZpk(i)=0;
        if k-1-i>0
            dZpk(i) = z(k-i) - z(k-1-i) ;
        end
    end
%Wyznaczenie dU
    dUk = K * (Yzad - Y - Mp * dUpk  - Mpz * dZpk);
 %Wyznaczenie sterowania
    u(k)=dUk(1)+u(k-1);
%Wyliczenie błędu
    E = E + (yzad(k)- y(k))^2;
end
figure;
stairs((1:kk),u);
title("u, E="+ num2str(E)); xlabel('k'); ylabel('u');
%print('pust4_u_N200_Nu100_lambda1.png','-dpng','-r400')

figure;
hold on
stairs((1:kk),y);
stairs((1:kk),yzad, ':');
title("yzad, y, E="+ num2str(E)); xlabel('k'); ylabel('y');
legend('y','yzad');
title("y, E="+ num2str(E))
%print('pust4_y_N200_Nu100_lambda1.png','-dpng','-r400')