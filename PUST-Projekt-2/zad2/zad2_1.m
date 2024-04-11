% Wejście-Wyjście:

clear;
kk=200;
u(1:kk)=0;
y(1:kk)=0;
z(1:kk)=0;
U=[-10,-5,-1,1,5,10];

Y=zeros(length(U),kk);

for i=1:length(U)
    u(20:kk)=U(i);
    for k=8:kk
        y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7), ...
            z(k-3),z(k-4), ...
            y(k-1),y(k-2));
    end
    Y(i,:)=y;
end

U_m10(1:kk)=0;
U_m5(1:kk)=0;
U_m1(1:kk)=0;
U_1(1:kk)=0;
U_5(1:kk)=0;
U_10(1:kk)=0;
U_m10(20:kk)=U(1);
U_m5(20:kk)=U(2);
U_m1(20:kk)=U(3);
U_1(20:kk)=U(4);
U_5(20:kk)=U(5);
U_10(20:kk)=U(6);

figure
hold on
stairs(1:kk,Y(1,:))
stairs(1:kk,Y(2,:))
stairs(1:kk,Y(3,:))
stairs(1:kk,Y(4,:))
stairs(1:kk,Y(5,:))
stairs(1:kk,Y(6,:))
title('Odpowiedzi skokowe toru wejście-wyjście:')
xlabel('k')
ylabel('y(k)')
legend('U=-10',"U=-5","U=-1","U=1","U=5","U=10")
hold off
print('zad2_ster_y.png','-dpng','-r400')

figure
hold on
stairs(1:kk,U_m10)
stairs(1:kk,U_m5)
stairs(1:kk,U_m1)
stairs(1:kk,U_1)
stairs(1:kk,U_5)
stairs(1:kk,U_10)
title('Sterowanie dla odpowiedzi skokowych toru wejście-wyjście:')
xlabel('k')
ylabel('u(k)')
legend('U=-10',"U=-5","U=-1","U=1","U=5","U=10")
hold off
print('zad2_ster_u.png','-dpng','-r400')

% Zakłócenie-Wyjście:

kk=200;
u(1:kk)=0;
y(1:kk)=0;
z(1:kk)=0;
Z=[-10,-5,-1,1,5,10];

Yz=zeros(length(Z),kk);

for i=1:length(Z)
    z(20:kk)=Z(i);
    for k=8:kk
        y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7), ...
            z(k-3),z(k-4), ...
            y(k-1),y(k-2));
    end
    Yz(i,:)=y;
end

Z_m10(1:kk)=0;
Z_m5(1:kk)=0;
Z_m1(1:kk)=0;
Z_1(1:kk)=0;
Z_5(1:kk)=0;
Z_10(1:kk)=0;
Z_m10(20:kk)=Z(1);
Z_m5(20:kk)=Z(2);
Z_m1(20:kk)=Z(3);
Z_1(20:kk)=Z(4);
Z_5(20:kk)=Z(5);
Z_10(20:kk)=Z(6);

figure
hold on
stairs(1:kk,Yz(1,:))
stairs(1:kk,Yz(2,:))
stairs(1:kk,Yz(3,:))
stairs(1:kk,Yz(4,:))
stairs(1:kk,Yz(5,:))
stairs(1:kk,Yz(6,:))
title('Odpowiedzi skokowe toru zakłócenie-wyjście:')
xlabel('k')
ylabel('y(k)')
legend('Z=-10',"Z=-5","Z=-1","Z=1","Z=5","Z=10")
hold off
print('zad2_zak_y.png','-dpng','-r400')

figure
hold on
stairs(1:kk,U_m10)
stairs(1:kk,U_m5)
stairs(1:kk,U_m1)
stairs(1:kk,U_1)
stairs(1:kk,U_5)
stairs(1:kk,U_10)
title(['Sterowanie dla odpowiedzi skokowych toru ' ...
    'zakłócenie-wyjście:'])
xlabel('k')
ylabel('z(k)')
legend('Z=-10',"Z=-5","Z=-1","Z=1","Z=5","Z=10")
hold off
print('zad2_zak_u.png','-dpng','-r400')