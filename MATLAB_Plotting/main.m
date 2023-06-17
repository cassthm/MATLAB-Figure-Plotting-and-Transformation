clc;close;clear;
figure;
global axes1 clickpointx clickpointy n fig...
    curvepointx curvepointy endcurve curvecase
global clickpoint CP2clicked CP1clicked...
    T1xvalid T1yvalid T2xvalid T2yvalid...
    SPclicked hermiteclicked
clickpointx=[];clickpointy=[];n=1;
curvepointx=[];curvepointy=[];endcurve=false; 
clickpoint=[];
curvecase=1;
CP1clicked=false;
CP2clicked=false;
T1xvalid=false;T1yvalid=false; 
T2xvalid=false;T2yvalid=false;
SPclicked=false;
hermiteclicked=false;

%axes
axes1=axes;
set(axes1,'color','none','layer','top');
% axes(axes1);
axes1.Units='pixels';
axes1.Position=[50 150 500 400];

%set image
global ax im
ax=axes('layer','bottom','position',[0.036 0.231 0.371 0.620]);
matlabImage=imread('bt21.png');
im=imagesc(matlabImage);
set(im.Parent,'XTick',0);
set(im.Parent,'YTick',0);

%Plotting background
ha = axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'bottom');
I=imread('fences.jpg');
hi = imagesc(I);
set(ha,'handlevisibility','off', 'visible','off');
fig=gcf;
set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);

set(gcf,'windowbuttondownfcn',@mouseclicktest)