clear;
kk=200;
u(1:kk)=0;
y(1:kk)=0;
z(1:kk)=0;
U=(-10:1:10);
Z=(-10:1:10);
Yv=zeros(length(U),length(Z));
[U,Z]=meshgrid(-10:1:10);

for i=1:length(U)
    for j=1:length(Z)
        for k=8:kk
            y(k)=symulacja_obiektu15y_p2(U(1,i),U(1,i), ...
                Z(i,j),Z(i,j), ...
                y(k-1),y(k-2));
        end
        Y(i,j)=y(end);
    end
end
figure
surf(U,Z,Y);
title('Charakterystyka statyczna y(u,z):')
xlabel('u')
ylabel('z')
zlabel('y')
print('zad2_y(u,z).png','-dpng','-r400')

%Charakterystyka statyczna sterowania:

y(1:kk)=0;
Y=[];
U=(-10:1:10);
for i=1:length(U)
        for k=3:kk
            y(k)=symulacja_obiektu15y_p2(U(i),U(i),0,0, ...
                y(k-1),y(k-2));
        end
        Y(i)=y(end);
end

Kustat=(Y(end)-Y(1))/(U(end)-U(1));
figure
plot(U,Y);
title("Charakterystyka statyczna sterowania:  " + ...
    "K_{ustat}="+num2str(Kustat))
xlabel('u')
ylabel('y')
%print('zad2_y(u,0).png','-dpng','-r400')
% Charakterystyka statyczna zakłócenia:

y(1:kk)=0;
Y=[];
Z=(-10:1:10);
for i=1:length(Z)
        for k=3:kk
            y(k)=symulacja_obiektu15y_p2(0,0,Z(i),Z(i), ...
                y(k-1),y(k-2));
        end
        Y(i)=y(end);
end

Kzstat=(Y(end)-Y(1))/(Z(end)-Z(1));
figure
plot(Z,Y);
title("Charakterystyka statyczna zakłócenia:  " + ...
    "K_{zstat}="+num2str(Kzstat))
xlabel('u')
ylabel('y')
print('zad2_y(0,z).png','-dpng','-r400')