%Skrypt Sterowanie procesami ci¹g³ymi
syms c1 c2 c3 c4 m1 m2 m3 m4
%Dane wejœæiowe
c1=250;c2=250;c3=250;c4=250;
m1=1000;m2=1000;m3=1000;m4=1000;
Aa=zeros(4,4);
Aav=[-1 0 0 0
      1 -1 0 0
      0 1 -1 0 
      0 0 1 -1];
av=[-c1/m1 -c2/m2 -c3/m3 -c4/m4];
Av=diag(av);
Ava=zeros(4,4);

%A
A=[Aa Aav;
  Ava Av];


Ba=zeros(4,4);
b0=[1 2 3 4 5 6 7 8]';
bv=[1/m1 1/m2 1/m3 1/m4];
Bv=diag(bv);

%B

B=[Ba
   Bv];
%C i D
%C=eye(8);
C=[1 0 0 0 0 0 0 0;
    0 1 0 0 0 0 0 0;
    0 0 1 0 0 0 0 0;
    0 0 0 1 0 0 0 0;];
D=zeros(8,4);
D=zeros(4,4);
[lo,mo]=ss2tf(A,B,C,D,1);
[lm,mm]=minreal(lo(1,:),mo)
[zo,po,ko]=ss2zp(A,B,C,D,1);

Qs=ctrb(A,B);
rank(Qs)
%Bieguny uk³adu otwartego
po=eig(A);
[z,p,k]=besself(8,0.3)
%[z,p,k] = besselap(8);
%[p,f,p1,f1]=optimitaestep(8);p=roots(p);
%wydluzenie czasu regulacji ----> zmniejszenie sterowania
alfa=1;
p=alfa*p;
K=place(A,B,p);

%bieguny uk³adu zamkniêtego
Ac=A-B*K;

[l,m]=ss2tf(Ac,B,C,D,1);
t=0:0.1:20;
y=step(l,m,t);
plot(t,y)
pz=eig(Ac);
[zz,pz,kz]=ss2zp(Ac,B,C,D,1);


%Obliczanie N

L=[A B; C D];

zero=zeros(8,4);
jeden=[1 0 0 0;
  0 0 0 0 ;
  0 1 0 0 ;
  0 0 0 0;
  0 0 1 0;
  0 0 0 0;
 0 0 0 1;
 0 0 0 0];

zero=zeros(8,4);
jeden=eye(4);
     
%zero=zeros(8,8);
%jeden=eye(8);


  
P=[zero;jeden];
P=[zeros(8,4);eye(4)];
nn=L\P;
Nx=nn(1:8,:); Nu=nn(9:12,:);
N=Nu+K*Nx;




