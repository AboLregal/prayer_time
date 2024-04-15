function varargout = prayer_times(varargin)
% PRAYER_TIMES MATLAB code for prayer_times.fig
%      PRAYER_TIMES, by itself, creates a new PRAYER_TIMES or raises the existing
%      singleton*.
%
%      H = PRAYER_TIMES returns the handle to a new PRAYER_TIMES or the handle to
%      the existing singleton*.
%
%      PRAYER_TIMES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRAYER_TIMES.M with the given input arguments.
%
%      PRAYER_TIMES('Property','Value',...) creates a new PRAYER_TIMES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prayer_times_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prayer_times_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prayer_times

% Last Modified by GUIDE v2.5 14-Apr-2024 21:52:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @prayer_times_OpeningFcn, ...
    'gui_OutputFcn',  @prayer_times_OutputFcn, ...
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


% --- Executes just before prayer_times is made visible.
function prayer_times_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prayer_times (see VARARGIN)
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
result=webread(['https://api.aladhan.com/v1/calendar/',yr,'/',mnth,'?latitude=48.8566&longitude=2.3522']);
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

% Choose default command line output for prayer_times
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prayer_times wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prayer_times_OutputFcn(hObject, eventdata, handles)
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
