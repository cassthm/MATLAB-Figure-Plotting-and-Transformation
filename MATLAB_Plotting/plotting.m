function plotting
global clickpointx clickpointy axes1 fig curvecase...
    curvepointx curvepointy SPLINE_P 
global NEXTCURVE CUBIC_CP1 CUBIC_CP2 QUAD_CP...
    HERMITE_T1x HERMITE_T2x HERMITE_T1y HERMITE_T2y
axes(axes1);
hold(axes1,'on');

LINEARFCN=uicontrol(fig,'Style','push','string','Linear'...
    ,'position',[700 150 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@linearfcn,'enable','on');

QUADBEZIER=uicontrol(fig,'Style','push','string',...
    'Quadratic Bezier','position',[700 350 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@quadBez,'enable','on');
QUAD_CP = uicontrol(fig,'Style',...
                  'radiobutton',...
                  'String','Control Point',...
                  'Position',[1000 350 200 70],...
                  'fontsize',20,'fontname','timesnewroman',...
                  'enable','off','callback',@quadCP);
              
CUBICBEZIER=uicontrol(fig,'Style','push','string',...
    'Cubic Bezier','position',[700 250 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@cubicBez,'enable','on');
CUBIC_CP1 = uicontrol(fig,'Style',...
                  'radiobutton',...
                  'String','Control Point 1',...
                  'Position',[1000 285 200 35],...
                  'fontsize',10,'fontname','timesnewroman',...
                  'enable','off','callback',@cubicCP1);
CUBIC_CP2 = uicontrol(fig,'Style','radiobutton',...
                  'String','Control Point 2',...
                  'fontsize',10,'fontname','timesnewroman',...
                  'Position',[1000 250 200 35],...
                  'enable','off','callback',@cubicCP2);

HERMITE=uicontrol(fig,'Style','push','string',...
    'Hermite','position',[700 450 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@hermitefcn,'enable','on');
HERMITE_T1xText = uicontrol(fig,'Style','text',...
                  'string','T1x',...
                  'fontsize',18,'fontname','timesnewroman',...
                  'Position',[1000 485 50 35]);
HERMITE_T1x = uicontrol(fig,'Style', 'edit',...
                  'fontsize',10,'fontname','timesnewroman',...
                  'Position',[1050 485 50 35],...
                  'enable','off',...
                  'Callback', @T1x);
HERMITE_T1yText = uicontrol(fig,'Style','text',...
                  'string','T1y',...
                  'fontsize',18,'fontname','timesnewroman',...
                  'Position',[1100 485 50 35]);
HERMITE_T1y = uicontrol(fig,'Style', 'edit',...
                  'fontsize',10,'fontname','timesnewroman',...
                  'Position',[1150 485 50 35],...
                  'enable','off',...
                  'Callback', @T1y);
HERMITE_T2xText = uicontrol(fig,'Style','text',...
                  'string','T2x',...
                  'fontsize',18,'fontname','timesnewroman',...
                  'Position',[1000 450 50 35]);
HERMITE_T2x = uicontrol(fig,'Style', 'edit',...
                  'fontsize',10,'fontname','timesnewroman',...
                  'Position',[1050 450 50 35],...
                  'enable','off',...
                  'Callback', @T2x);
HERMITE_T2yText = uicontrol(fig,'Style','text',...
                  'string','T2y',...
                  'fontsize',18,'fontname','timesnewroman',...
                  'Position',[1100 450 50 35]);
HERMITE_T2y = uicontrol(fig,'Style', 'edit',...
                  'fontsize',10,'fontname','timesnewroman',...
                  'Position',[1150 450 50 35],...
                  'enable','off',...
                  'Callback', @T2y);
SPLINE=uicontrol(fig,'Style','push','string','Natural Cubic Spline'...
    ,'position',[700 550 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@spline,'enable','on');
% SPLINE_P2 = uicontrol(fig,'Style','radiobutton',...
%                   'String','Spline Point 2',...
%                   'fontsize',10,'fontname','timesnewroman',...
%                   'Position',[1000 585 200 35],...
%                   'enable','off','callback',@splineP2);
SPLINE_P = uicontrol(fig,'Style','radiobutton',...
                  'String','Spline Point 3',...
                  'fontsize',20,'fontname','timesnewroman',...
                  'Position',[1000 550 200 70],...%35],...
                  'enable','off','callback',@splineP);
              
NEXTCURVE=uicontrol(fig,'Style','push','string','Next Curve'...
    ,'position',[700 50 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@nextcurve,'enable','on');
ENDPLOT=uicontrol(fig,'Style','push','string','End Plotting'...
    ,'position',[1000 50 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@endplot,'enable','off');
%reset button
RESET=uicontrol(fig,'Style','push','string','Reset'...
    ,'position',[200 50 200 70],'fontsize',20,...
    'fontname','timesnewroman',...
    'callback',@reset,'enable','on');

if length(curvepointx)>1
    set(ENDPLOT,'enable','on');
end

%main plotting function
switch curvecase
    case 1 %Linear
        hold(axes1,'off')
        plot([clickpointx(1),clickpointx(2)],...
            [clickpointy(1),clickpointy(2)],...
            '-c','parent',axes1,'linewidth',2);
    case 2
        [x,y]=quadbezier;
        plot(x,y,'-c','parent',axes1,'linewidth',2);
    case 3
        [x,y]=cubicbezier;
        plot(x,y,'-c','parent',axes1,'linewidth',2);
    case 4
        hold(axes1,'off')
        [x,y]=hermite;
        plot(x,y,'-c','parent',axes1,'linewidth',2);
    case 5
        [x,y]=cubicspline;
        plot(x,y,'-c','parent',axes1,'linewidth',2);
end
hold(axes1,'on')
plot(clickpointx(1),clickpointy(1),'c*','parent',axes1)
plot(clickpointx(2),clickpointy(2),'c*','parent',axes1)
plot(curvepointx,curvepointy,'-c','parent',axes1,'linewidth',2);
set(axes1,'color','none','layer','top');
xlim(axes1,[0 1]);ylim(axes1,[0 1]);

% Functions of uicontrol
function linearfcn(PushButton,EventData)
global curvecase
curvecase=1;

function quadBez(PushButton,EventData)
global curvecase QUAD_CP
curvecase=2;
set(QUAD_CP,'enable','on')

function quadCP(source,event)
global n
n=3;

function cubicBez(PushButton,EventData)
global curvecase CUBIC_CP1 CUBIC_CP2 CP1clicked
curvecase=3;
set(CUBIC_CP1,'enable','on')
if CP1clicked==true
    set(CUBIC_CP2,'enable','on')
end

function cubicCP1(source,event)
global CUBIC_CP2 n CP1clicked
set(CUBIC_CP2,'value',0)
CP1clicked=true;
n=3;

function cubicCP2(source,event)
global CUBIC_CP1 n CP2clicked
set(CUBIC_CP1,'value',0)
CP2clicked=true;
n=4;

function hermitefcn(PushButton,EventData)
global curvecase hermiteclicked HERMITE_T1x HERMITE_T2x HERMITE_T1y HERMITE_T2y
disp('hermitefcn')
curvecase=4;
hermiteclicked=true;
set(HERMITE_T1x,'enable','on')
set(HERMITE_T1y,'enable','on')
set(HERMITE_T2x,'enable','on')
set(HERMITE_T2y,'enable','on')
hermite;

function T1x(hObject,event)
global T1x T1xvalid T1yvalid axes1 
current_string = get(hObject, 'String');
T1x=str2double(current_string)
T1xvalid=true;
if T1xvalid && T1yvalid
hold(axes1,'off')
plotting
end

function T1y(hObject,event)
global T1y T1yvalid T1xvalid axes1
current_string = get(hObject, 'String');
T1y=str2double(current_string)
T1yvalid=true;
if T1xvalid && T1yvalid
hold(axes1,'off')
plotting
end

function T2x(hObject,event)
global T2x T2xvalid T2yvalid axes1
current_string = get(hObject, 'String');
T2x=str2double(current_string)
T2xvalid=true;
if T2xvalid && T2yvalid
hold(axes1,'off')
plotting
end

function T2y(hObject,event)
global T2y T2xvalid T2yvalid axes1
current_string = get(hObject, 'String');
T2y=str2double(current_string)
T2yvalid=true;
if T2xvalid && T2yvalid
hold(axes1,'off')
plotting
end

function spline(PushButton,EventData)
global curvecase SPLINE_P 
curvecase=5;
% set(SPLINE_P2,'enable','on')
% if SP2clicked==true
set(SPLINE_P,'enable','on')
% end

% function splineP2(source,event)
% global SPLINE_P3 n SP2clicked
% set(SPLINE_P3,'value',0)
% SP2clicked=true;

function splineP(source,event)
global n SPclicked
% set(SPLINE_P2,'value',0)
SPclicked=true;
n=3;

function nextcurve(PushButton,EventData)
global clickpointx clickpointy n curvecase...
    curvepointx curvepointy axes1 tempx tempy...
    CP1clicked CP2clicked SPclicked...
    T1xvalid T1yvalid T2xvalid T2yvalid
switch curvecase
    case 1
        x=[clickpointx(1),clickpointx(2)];
        y=[clickpointy(1),clickpointy(2)];
    case 2
        [x,y]=quadbezier;
    case 3
        [x,y]=cubicbezier;
    case 4
        [x,y]=hermite;
    case 5
        [x,y]=cubicspline;
end
curvepointx=[curvepointx x];
curvepointy=[curvepointy y];
hold(axes1,'on')
plot(curvepointx(1),curvepointy(1),'-c','parent',axes1);
plot(curvepointx(2),curvepointy(2),'-c','parent',axes1);
tempx=clickpointx(1);
tempy=clickpointy(1);
clickpointx(1)=clickpointx(2);
clickpointy(1)=clickpointy(2);
clickpointx(2:end)=[];
clickpointy(2:end)=[];
n=2;
CP1clicked=false;CP2clicked=false;
T1xvalid=false;T1yvalid=false; 
T2xvalid=false;T2yvalid=false;
SPclicked=false;
hermiteclicked=false;
curvecase=1;
set(axes1,'color','none','layer','top');
xlim(axes1,[0 1]);ylim(axes1,[0 1]);

function endplot(PushButton,EventData)
global axes1 curvepointx curvepointy clickpointx clickpointy...
    endcurve NEXTCURVE tempx tempy
hold(axes1,'on')
endcurve=true;
if endcurve==true && length(clickpointx)==1
    disp('backup')
    clickpointx(2)=clickpointx(1);
    clickpointy(2)=clickpointy(1);
    clickpointx(1)=tempx;
    clickpointy(1)=tempy;
end
nextcurve;
set(NEXTCURVE,'enable','off');
curvepointx=[curvepointx curvepointx(1)];
curvepointy=[curvepointy curvepointy(1)];
hold(axes1,'off');
plot(curvepointx,curvepointy,'-c','linewidth',2);
set(axes1,'color','none','layer','top');
xlim(axes1,[0 1]);ylim(axes1,[0 1]);
% plot([curvepointx(1),curvepointx(end)],...
%     [curvepointy(1),curvepointy(end)],'-c','parent',axes1);
saveplot = questdlg('Would you like to save the curve?', ...
	'Save curve','Yes','No','Cancel');
% Handle response
switch saveplot
    case 'Yes'
        save('newtestingdata.mat','curvepointx','curvepointy');
        close;
        manipulation;
    case 'No'
        close;
        manipulation;
end


function reset(PushButton,EventData)
main;