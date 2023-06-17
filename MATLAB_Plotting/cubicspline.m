function [xrange,yrange] = cubicspline
global clickpointx clickpointy axes1 SPclicked

axes(axes1);
set(axes1,'color','none','layer','top');
xlim(axes1,[0 1]);ylim(axes1,[0 1]);
hold(axes1,'on');

n=2;
x(1)=clickpointx(1);
a(1)=clickpointy(1);
x(3)=clickpointx(2);
a(3)=clickpointy(2);
if SPclicked
    x(2)=clickpointx(3);
    a(2)=clickpointy(3);
else
    x(2)=x(2);
    a(2)=a(2);
end

hold on;
plot(x(1),a(1),'k*');
plot(x(2),a(2),'k*');
m = n - 1;
h = zeros(1,m+1);
for i = 0:m
h(i+1) = x(i+2) - x(i+1);
end
xa = zeros(1,m+1);
for i = 1:m
xa(i+1) = 3.0*(a(i+2)*h(i)-a(i+1)*(x(i+2)-x(i))+a(i)*h(i+1))/(h(i+1)*h(i));
end
xl = zeros(1,n+1);
xu = zeros(1,n+1);
xz = zeros(1,n+1);
xl(1) = 1;
xu(1) = 0;
xz(1) = 0;
for i = 1:m
xl(i+1) = 2*(x(i+2)-x(i))-h(i)*xu(i);
xu(i+1) = h(i+1)/xl(i+1);
xz(i+1) = (xa(i+1)-h(i)*xz(i))/xl(i+1);
end
xl(n+1) = 1;
xz(n+1) = 0;
b = zeros(1,n+1);
c = zeros(1,n+1);
d = zeros(1,n+1);
c(n+1) = xz(n+1);
for i = 0:m
j = m-i;
c(j+1) = xz(j+1)-xu(j+1)*c(j+2);
b(j+1) = (a(j+2)-a(j+1))/h(j+1) - h(j+1) * (c(j+2) + 2.0 * c(j+1)) / 3.0;
d(j+1) = (c(j+2) - c(j+1)) / (3.0 * h(j+1));
end
for i = 0:m
syms X;
S(i+1)=d(i+1)*(X-x(i+1))^3+c(i+1)*(X-x(i+1))^2+b(i+1)*(X-x(i+1))+a(i+1);
end
xrange=[];yrange=[];
for i=1:n
xx=x(i):0.001:x(i+1);
Ht1=double(subs(S(i),X,xx));
xrange=[xrange xx];
yrange=[yrange Ht1];
% plot(xx,Ht1,'-c');
end
% xrange=xx;yrange=Ht1;