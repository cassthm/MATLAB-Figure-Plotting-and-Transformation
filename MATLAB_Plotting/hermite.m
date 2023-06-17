function [xrange,yrange]=hermite
disp('hermite')
global clickpointx clickpointy axes1 %T1clicked T2clicked
global T1x T2x T1y T2y T1xvalid T1yvalid T2xvalid T2yvalid
axes(axes1);
set(axes1,'color','none','layer','top');
xlim(axes1,[0 1]);ylim(axes1,[0 1]);
hold(axes1,'on');

P1=[clickpointx(1);clickpointy(1)]
if T1xvalid&&T1yvalid
disp('T1 exist')
      T1=[T1x;T1y]
else
    disp('default T1')
    T1=[(clickpointx(1)+clickpointx(2))/2;...
        (clickpointy(1)+clickpointy(2))/2]
end
if T2xvalid&&T2yvalid
disp('T2 exist')
    T2=[T2x;T2y]
else
    disp('default T2')
    T2=T1
end
P2=[clickpointx(2);clickpointy(2)]

MH=[1 0 -3 2;
    0 0 3 -2;
    0 1 -2 1;
    0 0 -1 1];
syms t;
tvector=[1;t;t^2;t^3];
Htsym=[P1 P2 T1 T2]*MH*tvector;
Ht=double(subs(Htsym,t,0:0.01:1));
plot(P1(1),P1(2),'*c'); 
plot(P2(1),P2(2),'*c');
plot(Ht(1,:),Ht(2,:),'-c','linewidth',2);
hold off;
xrange=Ht(1,:);
yrange=Ht(2,:);