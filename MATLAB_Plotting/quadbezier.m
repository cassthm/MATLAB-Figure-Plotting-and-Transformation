function [xrange,yrange]=quadbezier
global clickpointx clickpointy axes1
axes(axes1);
hold(axes1,'on');
set(axes1,'color','none','layer','top');
xlim(axes1,[0 1]);ylim(axes1,[0 1]);

P0=[clickpointx(1);clickpointy(1)];
P1=[clickpointx(3);clickpointy(3)];
P2=P1;
P3=[clickpointx(2);clickpointy(2)];
MH=[1 -3 3 -1;
    0 3 -6 3;
    0 0 3 -3;
    0 0 0 1];
syms t;
tvector=[1;t;t^2;t^3];
Htsym=[P0 P1 P2 P3]*MH*tvector;
Ht=double(subs(Htsym,t,0:0.01:1));
plot(P0(1),P0(2),'*c'); 
plot(P1(1),P1(2),'*m'); 
plot(P2(1),P2(2),'*m');
plot(P3(1),P3(2),'*c');
plot(Ht(1,:),Ht(2,:),'-c','linewidth',2);
hold off;
xrange=Ht(1,:);
yrange=Ht(2,:);