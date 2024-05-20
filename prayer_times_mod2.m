function varargout = prayer_times_mod2(varargin)
% PRAYER_TIMES_MOD2 MATLAB code for prayer_times_mod2.fig
%      PRAYER_TIMES_MOD2, by itself, creates a new PRAYER_TIMES_MOD2 or raises the existing
%      singleton*.
%
%      H = PRAYER_TIMES_MOD2 returns the handle to a new PRAYER_TIMES_MOD2 or the handle to
%      the existing singleton*.
%
%      PRAYER_TIMES_MOD2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRAYER_TIMES_MOD2.M with the given input arguments.
%
%      PRAYER_TIMES_MOD2('Property','Value',...) creates a new PRAYER_TIMES_MOD2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prayer_times_mod2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prayer_times_mod2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prayer_times_mod2

% Last Modified by GUIDE v2.5 20-May-2024 06:02:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @prayer_times_mod2_OpeningFcn, ...
    'gui_OutputFcn',  @prayer_times_mod2_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
try
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
catch
    close all
end
% End initialization code - DO NOT EDIT


% --- Executes just before prayer_times_mod2 is made visible.
function prayer_times_mod2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prayer_times_mod2 (see VARARGIN)
a=inputdlg({'Longtitude:(-180,180)','Latitude:(-90,90)'},'input data',[1 50],{'2.3522';'48.8566'});
Long=str2double(a{1});
Lat=str2double(a{2});
c1=isnan(Long)|Long<-180|Long>180;
c2=isnan(Lat)|Lat<-90|Lat>90;
cond=c1+c2;
while cond>0
    if c1==1 & c2==0
        a=inputdlg({'Longtitude:(-180,180)'},'Wrong answer',[1 50],{'2.3522'});
        Long=str2double(a{1});
        c1=isnan(Long)|Long<-180|Long>180;
    elseif c2==1 & c1==0
        a=inputdlg({'Latitude:(-90,90)'},'Wrong answer',[1 50],{'48.8566'});
        Lat=str2double(a{1});
        c2=isnan(Lat)|Lat<-90|Lat>90;
    elseif c1==1 & c2==1
        a=inputdlg({'Longtitude:(-180,180)','Latitude:(-90,90)'},'Wrong answer',[1 50],{'2.3522';'48.8566'});
        Long=str2double(a{1});
        Lat=str2double(a{2});
        c1=isnan(Long)|Long<-180|Long>180;
        c2=isnan(Lat)|Lat<-90|Lat>90;
    end
    cond=c1+c2;
end
set(handles.slider1,'value',Lat)
set(handles.slider2,'value',Long)
set(handles.edit4,'string',a{2})
set(handles.edit5,'string',a{1})

axes(handles.axes1)
x = sin(2*pi*(1:60)/60);
y = cos(2*pi*(1:60)/60);
k = 5:5:60;
axis off
line(x,y,'linestyle','none','marker','o','color','black','markersize',2)
line(x(k),y(k),'linestyle','none','marker','*','color','black','markersize',8)
h = line([0 0],[0 0],'color','blue','linewidth',4);
m = line([0 0],[0,0],'color','blue','linewidth',4);
s = line([0 0],[0 0],'color',[0 2/3 0],'linewidth',2);
% klose = uicontrol('string','close','style','toggle');
c=clock;
set(handles.text13,'string',datestr(datenum(c(1),c(2),c(3))));
mnth=num2str(month(datetime('now')));
yr=num2str(year(datetime('now')));
dy=day(datetime('now'));
result=webread(['https://api.aladhan.com/v1/calendar/',yr,'/',mnth,'?latitude=',a{2},'&longitude=',a{1}]);
% result=webread(['https://api.aladhan.com/v1/calendar/',yr,'/',mnth,'?latitude=48.8566&longitude=2.3522']);
dt=result.data;
a=dt(dy).timings;
nms=fieldnames(a);
pos=[1 3 4 6 7];
q=3;
set(handles.text3,'string',nms{1})
set(handles.text4,'string',nms{3})
set(handles.text5,'string',nms{4})
set(handles.text6,'string',nms{6})
set(handles.text7,'string',nms{7})

set(handles.text8,'string',getfield(a,nms{1}))
set(handles.text9,'string',getfield(a,nms{3}))
set(handles.text10,'string',getfield(a,nms{4}))
set(handles.text11,'string',getfield(a,nms{6}))
set(handles.text12,'string',getfield(a,nms{7}))

while 1
    c = clock;
    af = (c(2)==4 && c(3)==1);
    % text(0,0,datestr(datenum(c(1),c(2),c(3))),'fontsize',16)
    t = c(4)/12 + c(5)/720 + c(6)/43200;
    if af, t = -t; end
    set(h,'xdata',[0 0.8*sin(2*pi*t)],'ydata',[0 0.8*cos(2*pi*t)])
    t = c(5)/60 + c(6)/3600;
    if af, t = -t; end
    set(m,'xdata',[0 sin(2*pi*t)],'ydata',[0 cos(2*pi*t)])
    k = ceil(c(6));
    if af, k = 61-k; end
    set(s,'xdata',[0 x(k)],'ydata',[0 y(k)])
    pause(1.0)
end

% Choose default command line output for prayer_times_mod2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prayer_times_mod2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prayer_times_mod2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
delete(hObject);




% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
g=get(handles.slider1,'value');
set(handles.edit4,'string',num2str(g))

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
g=get(handles.slider2,'value');
set(handles.edit5,'string',num2str(g))

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c=clock;
a{1}=get(handles.edit5,'string');
a{2}=get(handles.edit4,'string');
set(handles.text13,'string',datestr(datenum(c(1),c(2),c(3))));
mnth=num2str(month(datetime('now')));
yr=num2str(year(datetime('now')));
dy=day(datetime('now'));
result=webread(['https://api.aladhan.com/v1/calendar/',yr,'/',mnth,'?latitude=',a{2},'&longitude=',a{1}]);
% result=webread(['https://api.aladhan.com/v1/calendar/',yr,'/',mnth,'?latitude=48.8566&longitude=2.3522']);
dt=result.data;
a=dt(dy).timings;
nms=fieldnames(a);

set(handles.text3,'string',nms{1})
set(handles.text4,'string',nms{3})
set(handles.text5,'string',nms{4})
set(handles.text6,'string',nms{6})
set(handles.text7,'string',nms{7})

set(handles.text8,'string',getfield(a,nms{1}))
set(handles.text9,'string',getfield(a,nms{3}))
set(handles.text10,'string',getfield(a,nms{4}))
set(handles.text11,'string',getfield(a,nms{6}))
set(handles.text12,'string',getfield(a,nms{7}))



function text16_Callback(hObject, eventdata, handles)
% hObject    handle to text16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text16 as text
%        str2double(get(hObject,'String')) returns contents of text16 as a double


% --- Executes during object creation, after setting all properties.
function text16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function text17_Callback(hObject, eventdata, handles)
% hObject    handle to text17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text17 as text
%        str2double(get(hObject,'String')) returns contents of text17 as a double


% --- Executes during object creation, after setting all properties.
function text17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
g=str2double(get(handles.edit4,'string'));
y=num2str(get(handles.slider1,'value'));
if g>=-90 & g<=90
set(handles.slider1,'value',g);
else
    set(handles.edit4,'string',y)
end

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
g=str2double(get(handles.edit5,'string'));
y=num2str(get(handles.slider2,'value'));
if g>=-180 & g<=180
    set(handles.slider2,'value',g);
else
    set(handles.edit5,'string',y)
end

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
