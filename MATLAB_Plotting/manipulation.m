function manipulation
clc;close;
global fillPlot x y curve

%temp=load('bt21data.mat');
temp=load('newtestingdata.mat');
x=[temp.curvepointx];
y=[temp.curvepointy];
curve=[x;y];

%Plotting background
ha = axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'bottom');
I=imread('fences.jpg');
hi = imagesc(I);
set(ha,'handlevisibility','off', 'visible','off');
fig=gcf;
set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);

%axes
axes1=axes;
set(axes1,'color','none');
%,'xtick',[],'ytick',[],'xcolor','none','ycolor','none');
axes1.Units='pixels';
axes1.Position=[50 150 500 400];
hold(axes1,'on')
fillPlot=fill(x,y,'b','linewidth',2); %Plot manipulated curve
fill(x,y,'r','linewidth',2); %Plot original curve
axis equal;

% Translation
global TRANSLATE_X TRANSLATE_Y
TRANSLATE=uicontrol(fig,'Style','push','string','Translation'...
    ,'position',[700 150 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@translate,'enable','on');
TRANSLATE_XTEXT = uicontrol(fig,'Style','text',...
                  'string','x',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1000 150 50 70]);
TRANSLATE_YTEXT = uicontrol(fig,'Style', 'text',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1100 150 50 70],...
                  'string','y');
TRANSLATE_X = uicontrol(fig,'Style','edit',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1050 150 50 70],...
                  'enable','off','Callback', @translatex);
TRANSLATE_Y = uicontrol(fig,'Style', 'edit',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1150 150 50 70],...
                  'enable','off',...
                  'Callback', @translatey);

% Reflection
global REFLECT_XRB REFLECT_YRB REFLECT_X REFLECT_Y
REFLECT=uicontrol(fig,'Style','push','string','Reflection'...
    ,'position',[700 250 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@reflect,'enable','on');
REFLECT_XRB = uicontrol(fig,'Style',...
                  'radiobutton',...
                  'String','x',...
                  'Position',[1000 250 50 70],...
                  'fontsize',18,'fontname','timesnewroman',...
                  'enable','off','callback',@reflectxrb);
REFLECT_YRB = uicontrol(fig,'Style',...
                  'radiobutton',...
                  'String','y',...
                  'Position',[1100 250 50 70],...
                  'fontsize',18,'fontname','timesnewroman',...
                  'enable','off','callback',@reflectyrb);
REFLECT_X=uicontrol(fig,'Style','edit',...
                  'fontsize',18,'fontname','timesnewroman',...
                  'Position',[1050 250 50 70],...
                  'enable','off','Callback', @reflectx);
REFLECT_Y=uicontrol(fig,'Style','edit',...
                  'fontsize',18,'fontname','timesnewroman',...
                  'Position',[1150 250 50 70],...
                  'enable','off','Callback', @reflecty);

% Shearing
global SHEAR_SLIDER SHEAR_X SHEAR_Y
SHEAR=uicontrol(fig,'Style','push','string','Shearing'...
    ,'position',[700 350 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@shear,'enable','on');
SHEAR_SLIDER=uicontrol(fig,'Style','slider','String','Degree of Shearing',...
    'Position',[1000 350 200 35],'enable','off','Callback',@shearslider,...
    'min',-180,'max',180,'sliderstep',[1/359,10/180]);
SHEAR_X = uicontrol(fig,'Style',...
                  'radiobutton',...
                  'String','x',...
                  'Position',[1000 385 90 35],...
                  'fontsize',18,'fontname','timesnewroman',...
                  'enable','off','callback',@shearx);
SHEAR_Y = uicontrol(fig,'Style',...
  'radiobutton',...
  'String','y',...
  'Position',[1100 385 90 35],...
  'fontsize',18,'fontname','timesnewroman',...
  'enable','off','callback',@sheary);

% Rotation
global ROTATE_SLIDER ROTATE_X ROTATE_Y
ROTATE=uicontrol(fig,'Style','push','string','Rotation'...
    ,'position',[700 450 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@rotate,'enable','on');
ROTATE_SLIDER=uicontrol(fig,'Style','slider','String','Degree of Rotation',...
    'Position',[1000 450 200 35],'enable','off','Callback',@rotateslider,...
    'min',-360,'max',360,'sliderstep',[1/719,10/719]);
ROTATE_XTEXT = uicontrol(fig,'Style','text',...
                  'string','x',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1000 485 50 35]);
ROTATE_YTEXT = uicontrol(fig,'Style', 'text',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1100 485 50 35],...
                  'string','y');
ROTATE_X = uicontrol(fig,'Style','edit',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1050 485 50 35],...
                  'enable','off','Callback', @rotatex);
ROTATE_Y = uicontrol(fig,'Style', 'edit',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1150 485 50 35],...
                  'enable','off',...
                  'Callback', @rotatey);

% Scaling
global SCALE_X SCALE_Y SCALE_XRATIO SCALE_YRATIO 
SCALE=uicontrol(fig,'Style','push','string','Scaling'...
    ,'position',[700 550 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@scale,'enable','on');
SCALE_XTEXT = uicontrol(fig,'Style','text',...
                  'string','x',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1000 585 50 35]);
SCALE_YTEXT = uicontrol(fig,'Style', 'text',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1100 585 50 35],...
                  'string','y');
SCALE_X = uicontrol(fig,'Style','edit',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1050 585 50 35],...
                  'enable','off','Callback', @scalex);
SCALE_Y = uicontrol(fig,'Style', 'edit',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1150 585 50 35],...
                  'enable','off',...
                  'Callback', @scaley);
SCALE_XRATIOTEXT = uicontrol(fig,'Style','text',...
                  'string','x scale',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1000 550 50 35]);
SCALE_YRATIOTEXT = uicontrol(fig,'Style', 'text',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1100 550 50 35],...
                  'string','y scale');
SCALE_XRATIO = uicontrol(fig,'Style','edit',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1050 550 50 35],...
                  'enable','off','Callback', @scale_xratio);
SCALE_YRATIO = uicontrol(fig,'Style', 'edit',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1150 550 50 35],...
                  'enable','off',...
                  'Callback', @scale_yratio);

function scale(PushButton,EventData)
global SCALE_X
set(SCALE_X,'enable','on')

function scalex(hObject,event)
global SCALE_Y scaleXval
scaleXval = str2double(get(hObject, 'String'));
set(SCALE_Y,'enable','on')

function scaley(hObject,event)
global SCALE_XRATIO scaleYval
scaleYval = str2double(get(hObject, 'String'));
set(SCALE_XRATIO,'enable','on')

function scale_xratio(hObject,event)
global SCALE_YRATIO scaleXRATIOval
scaleXRATIOval = str2double(get(hObject, 'String'));
set(SCALE_YRATIO,'enable','on')

function scale_yratio(hObject,event)
global scaleXval scaleYval scaleXRATIOval x y curve fillPlot
scaleYRATIOval = str2double(get(hObject, 'String'));
% global curve AllCurve fillPlot;
% x=str2double(get(handles.xScaling,'string'));
% y=str2double(get(handles.yScaling,'string'));
% plot(50,200,'*r');
R=[scaleXRATIOval 0 scaleXval*(1-scaleXRATIOval);...
    0 scaleYRATIOval scaleYval*(1-scaleYRATIOval);0 0 1];
newCoordinate=R*[x;y;ones(1,length(curve))];
% set(AllCurve,'xdata',newCoordinate(1,:),'ydata',newCoordinate(2,:));
curve=[newCoordinate(1,:);newCoordinate(2,:)];
set(fillPlot,'xdata',curve(1,:),'ydata',curve(2,:));

% Translation
function translate(PushButton,EventData)
global TRANSLATE_X 
set(TRANSLATE_X,'enable','on');

function translatex(hObject,event)
global TRANSLATE_Y transXval
transXval = str2double(get(hObject, 'String'));
set(TRANSLATE_Y,'enable','on');

function translatey(hObject,event)
global transXval fillPlot x y curve
transYval = str2double(get(hObject, 'String'));
R=[1 0 transXval;0 1 transYval;0 0 1];
newCoordinate=R*[x;y;ones(1,length(x))];
%set(AllCurve,'xdata',newCoordinate(1,:),'ydata',newCoordinate(2,:));
curve=[newCoordinate(1,:);newCoordinate(2,:)];
set(fillPlot,'xdata',curve(1,:),'ydata',curve(2,:));

% Reflection
function reflect(PushButton,EventData)
global REFLECT_XRB REFLECT_YRB
set(REFLECT_XRB,'enable','on');
set(REFLECT_YRB,'enable','on');

function reflectxrb(hObject,event)
global REFLECT_X REFLECT_Y REFLECT_YRB 
set(REFLECT_X,'enable','on');
set(REFLECT_YRB,'value',0);
set(REFLECT_Y,'enable','off');

function reflectyrb(hObject,event)
global REFLECT_Y REFLECT_X REFLECT_XRB 
set(REFLECT_Y,'enable','on')
set(REFLECT_XRB,'value',0);
set(REFLECT_X,'enable','off');

function reflectx(hObject,event)
global curve fillPlot x y
refXval = str2double(get(hObject, 'String'));
R=[-1 0 2*refXval;0 1 0;0 0 1];
newCoordinate=R*[x;y;ones(1,length(curve))];
curve=[newCoordinate(1,:);newCoordinate(2,:)];
set(fillPlot,'xdata',curve(1,:),'ydata',curve(2,:));

function reflecty(hObject,event)
global curve fillPlot x y
refYval = str2double(get(hObject, 'String'));
R=[1 0 0;0 -1 2*refYval;0 0 1];
newCoordinate=R*[x;y;ones(1,length(curve))];
curve=[newCoordinate(1,:);newCoordinate(2,:)];
set(fillPlot,'xdata',curve(1,:),'ydata',curve(2,:));

% Shearing
function shear(PushButton,EventData)
global SHEAR_X SHEAR_Y
set(SHEAR_X,'enable','on')
set(SHEAR_Y,'enable','on')

function shearx(hObject,event)
global SHEAR_Y SHEAR_SLIDER
set(SHEAR_Y,'value',0)
set(SHEAR_SLIDER,'enable','on')

function sheary(hObject,event)
global SHEAR_X SHEAR_SLIDER
set(SHEAR_X,'value',0)
set(SHEAR_SLIDER,'enable','on')

function shearslider(hObject,event)
global fillPlot curve x y SHEAR_X SHEAR_Y SHEAR_SLIDER
theta=SHEAR_SLIDER.Value*pi/180;
if SHEAR_X.Value==1
   R=[1 tan(theta) 0;0 1 0;0 0 1]; 
elseif SHEAR_Y.Value==1
    R=[1 0 0;tan(theta) 1 0;0 0 1];
end
newCoordinate=R*[x;y;ones(1,length(curve))];
curve=[newCoordinate(1,:);newCoordinate(2,:)];
set(fillPlot,'xdata',newCoordinate(1,:),'ydata',newCoordinate(2,:));

% Rotate
function rotate(PushButton,EventData)
global ROTATE_X ROTATE_Y
set(ROTATE_X,'enable','on')

function rotatex(hObject,event)
global ROTATE_Y rotateXval
rotateXval = str2double(get(hObject, 'String'));
set(ROTATE_Y,'enable','on')

function rotatey(hObject,event)
global ROTATE_SLIDER rotateYval
set(ROTATE_SLIDER,'enable','on')
rotateYval = str2double(get(hObject, 'String'));

function rotateslider(hObject,event)
global curve x y fillPlot rotateXval rotateYval ROTATE_SLIDER
theta=-ROTATE_SLIDER.Value*pi/180;
R=[cos(theta) -sin(theta) rotateXval*(1-cos(theta))+rotateYval*sin(theta);
    sin(theta) cos(theta) rotateYval*(1-cos(theta))-rotateXval*sin(theta);...
    0 0 1 ];
newCoordinate=R*[x;y;ones(1,length(curve))];
curve=[newCoordinate(1,:);newCoordinate(2,:)];
set(fillPlot,'xdata',curve(1,:),'ydata',curve(2,:));
