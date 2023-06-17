function mouseclicktest(object,eventdata)
global axes1 n c1 c2 clickpointx clickpointy clickpoint
axes(axes1);
C = get (gca, 'CurrentPoint');
if  C(1,1)>=0 && C(1,1)<=1 && C(1,2)>=0 && C(1,2)<=1
    c1=C(1,1);
    c2=C(1,2);
end
% xlabel(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);
% fprintf('from mouseclicktest %f,%f\n',c1,c2);
clickpointx=[clickpointx c1];
clickpointy=[clickpointy c2];
if n==1
    plot(clickpointx(1),clickpointy(1),'c*','parent',axes1)
    n=n+1;
elseif n==2
    hold(axes1,'off');
    clickpointx(2)=c1;clickpointy(2)=c2;
    plot(clickpointx(2),clickpointy(2),'c*','parent',axes1)
    if  C(1,1)>=0 && C(1,1)<=1 && C(1,2)>=0 && C(1,2)<=1
        plotting;
    end
elseif n==3
    hold(axes1,'off');
    clickpointx(3)=c1;clickpointy(3)=c2;
    plot(clickpointx(3),clickpointy(3),'b*','parent',axes1)
    if  C(1,1)>=0 && C(1,1)<=1 && C(1,2)>=0 && C(1,2)<=1
        plotting;
    end
elseif n==4
    hold(axes1,'off');
    clickpointx(4)=c1;clickpointy(4)=c2;
    plot(clickpointx(4),clickpointy(4),'b*','parent',axes1)
    if  C(1,1)>=0 && C(1,1)<=1 && C(1,2)>=0 && C(1,2)<=1
        plotting;
    end
end
hold(axes1,'on');
plot(clickpointx(1),clickpointy(1),'c*','parent',axes1)
set(axes1,'color','none','layer','top');
xlim(axes1,[0 1]);ylim(axes1,[0 1]);