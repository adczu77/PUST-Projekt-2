kk =400;
u(1:kk)=0;
y(1:kk)=0;
z(1:kk)=0;
for k=8:kk
    y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7), ...
        z(k-3),z(k-4),y(k-1),y(k-2));
end

figure
plot(1:kk,u);
xlabel('k')
ylabel('u(k)')
print('zad1_u.png','-dpng','-r400')

figure
plot(1:kk,y);
xlabel('k')
ylabel('y(k)')
print('zad1_y.png','-dpng','-r400')

figure
plot(1:kk,z);
xlabel('k')
ylabel('z(k)')
print('zad1_z.png','-dpng','-r400')

