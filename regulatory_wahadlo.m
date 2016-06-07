%k/(s^2+omega^2) %kulka
%k/s^2 %wozek

t = pomiary1.time(:,1); %czas
u = pomiary1.signals.values(:,1); %sterowanie
l1 = -pomiary1.signals.values(:,2); %enkoder obrotowy na silniku
l2 = -pomiary1.signals.values(:,3); %enkoder liniowy
om = pomiary1.signals.values(:,4); %ekoder wahadlo

%pomiary tylko dla skoku = 1
%plot(t(1:end-1),diff(l1))
ii=find(u>0);
t=t(ii);
u=u(ii);
l1=l1(ii);
l2=l2(ii);
om=om(ii);
t=t-t(1);
ii=find(t<0.05);
t=t(ii);
u=u(ii);
l1=l1(ii);
l2=l2(ii);
om=om(ii);

%syms a,b
%y=ax+b
%pomiary2 do odczytania drgan wlasnych
T = 1.5; %okolo
k1 = 10.4; %eksperyment wozek
k2 = 1200; %eksperyment kulka
omega = 2*pi/T; 

%wozek
y1 = u(1)*step([0 0 k1], [1 0 0],t);
%kulka
y2 = u(1)*step([0 0 k2],[1 0 omega^2],t); 

A =[
     0 1 0 0;
     0 0 0 0;
     0 0 0 1;
     0 0 omega*omega 0;
   ];

%podmienilem k2 z k1
B=[0;
   k1;
   0;
   k2;];

C=eye(4);

D=[0;0;0;0];

Q=diag([200 10 5 1]);
Q=diag([20000 10 5 1]);
R=100000;
R=10000;

k = lqr(A,B,Q,R);

figure(1)
plot(t,l1, t, y1);
title('przemieszczenie liniowe wozka');
figure(2)
plot(t,om, t, y2)
title('przemieszczenie katowe kulki');

%sprobowac algorytm z lqr
%options = simset('SrcWorkspace','current');
%sim('stany',k);
tr=1;
kp = 216/(k1*tr^2);
ki = 432/(k1*tr^3);
kd = 27/(k1*tr);

