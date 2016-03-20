function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 20-Mar-2016 16:20:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function value = saturate(range, value)
  if value > range(2) value = range(2); end
  if value < range(1) value = range(1); end

function result = map(from_range, to_range, value)
  df = from_range(2) - from_range(1);
  dt = to_range(2) - to_range(1);
  result = dt/df*(value - from_range(1)) + to_range(1);

function handles = resetObject(handles)
  handles.sliderObjTX.Value = 0.5;
  handles.sliderObjTY.Value = 0.5;
  handles.sliderObjTZ.Value = 0.5;
  handles.sliderObjRX.Value = 0.5;
  handles.sliderObjRY.Value = 0.5;
  handles.sliderObjRZ.Value = 0.5;  
  handles.editObjTX.String = '0';
  handles.editObjTY.String = '0';
  handles.editObjTZ.String = '0';
  handles.editObjRX.String = '0';
  handles.editObjRY.String = '0';
  handles.editObjRZ.String = '0';

function handles = resetCamera(handles)
  handles.sliderCamTX.Value = 0.5;
  handles.sliderCamTY.Value = 0.5;
  handles.sliderCamTZ.Value = 0.5;
  handles.sliderCamRX.Value = 0.5;
  handles.sliderCamRY.Value = 0.5;
  handles.sliderCamRZ.Value = 0.5;  
  handles.editCamTX.String = '0';
  handles.editCamTY.String = '0';
  handles.editCamTZ.String = '0';
  handles.editCamRX.String = '0';
  handles.editCamRY.String = '0';
  handles.editCamRZ.String = '0';

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
handles = init_gui(handles);
handles = resetObject(handles);
handles = resetCamera(handles);
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in resetCameraPosition.
function resetCameraPosition_Callback(hObject, eventdata, handles)
  handles = resetCamera(handles);


% --- Executes on button press in resetObjectPosition.
function resetObjectPosition_Callback(hObject, eventdata, handles)
  handles = resetObject(handles);


function editObjRY_Callback(hObject, eventdata, handles)
  from_range = [-180, 180];
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderObjRY.Value = value;


% --- Executes during object creation, after setting all properties.
function editObjRY_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderObjRX_Callback(hObject, eventdata, handles)
  to_range = [-180,180];
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editObjRX.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderObjRX_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editObjRX_Callback(hObject, eventdata, handles)
  from_range = [-180, 180];
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderObjRX.Value = value;


% --- Executes during object creation, after setting all properties.
function editObjRX_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderObjRZ_Callback(hObject, eventdata, handles)
  to_range = [-180,180];
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editObjRZ.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderObjRZ_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editObjRZ_Callback(hObject, eventdata, handles)
  from_range = [-180, 180];
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderObjRZ.Value = value;


% --- Executes during object creation, after setting all properties.
function editObjRZ_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderObjRY_Callback(hObject, eventdata, handles)
  to_range = [-180,180];
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editObjRY.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderObjRY_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


% --- Executes on slider movement.
function sliderObjTY_Callback(hObject, eventdata, handles)
  to_range = handles.world.axis(3:4);
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editObjTY.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderObjTY_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editObjTZ_Callback(hObject, eventdata, handles)
  from_range = handles.world.axis(5:6);
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderObjTZ.Value = value;


% --- Executes during object creation, after setting all properties.
function editObjTZ_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderObjTZ_Callback(hObject, eventdata, handles)
  to_range = handles.world.axis(5:6);
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editObjTZ.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderObjTZ_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editObjTX_Callback(hObject, eventdata, handles)
  from_range = handles.world.axis(1:2);
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderObjTX.Value = value;


% --- Executes during object creation, after setting all properties.
function editObjTX_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderObjTX_Callback(hObject, eventdata, handles)
  to_range = handles.world.axis(1:2);
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editObjTX.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderObjTX_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editObjTY_Callback(hObject, eventdata, handles)
  from_range = handles.world.axis(3:4);
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderObjTY.Value = value;


% --- Executes during object creation, after setting all properties.
function editObjTY_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
  end


function editCamTY_Callback(hObject, eventdata, handles)
  from_range = handles.world.axis(3:4);
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderCamTY.Value = value;


% --- Executes during object creation, after setting all properties.
function editCamTY_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderCamTX_Callback(hObject, eventdata, handles)
  to_range = handles.world.axis(1:2);
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editCamTX.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderCamTX_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editCamTX_Callback(hObject, eventdata, handles)
  from_range = handles.world.axis(1:2);
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderCamTX.Value = value;


% --- Executes during object creation, after setting all properties.
function editCamTX_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderCamTZ_Callback(hObject, eventdata, handles)
  to_range = handles.world.axis(5:6);
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editCamTZ.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderCamTZ_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editCamTZ_Callback(hObject, eventdata, handles)
  from_range = handles.world.axis(5:6);
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderCamTZ.Value = value;


% --- Executes during object creation, after setting all properties.
function editCamTZ_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderCamTY_Callback(hObject, eventdata, handles)
  to_range = handles.world.axis(3:4);
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editCamTY.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderCamTY_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


% --- Executes on slider movement.
function sliderCamRY_Callback(hObject, eventdata, handles)
  to_range = [-180,180];
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editCamRY.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderCamRY_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editCamRZ_Callback(hObject, eventdata, handles)
  from_range = [-180, 180];
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderCamRZ.Value = value;


% --- Executes during object creation, after setting all properties.
function editCamRZ_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


% --- Executes on slider movement.
function sliderCamRZ_Callback(hObject, eventdata, handles)
  to_range = [-180,180];
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editCamRZ.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderCamRZ_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editCamRX_Callback(hObject, eventdata, handles)
  from_range = [-180, 180];
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderCamRX.Value = value;


% --- Executes during object creation, after setting all properties.
function editCamRX_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white'); 
  end


% --- Executes on slider movement.
function sliderCamRX_Callback(hObject, eventdata, handles)
  to_range = [-180,180];
  value = map([0,1], to_range, get(hObject, 'Value'));
  handles.editCamRX.String = num2str(value);


% --- Executes during object creation, after setting all properties.
function sliderCamRX_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end


function editCamRY_Callback(hObject, eventdata, handles)
  from_range = [-180, 180];
  value = saturate(from_range, str2double(get(hObject,'String')));
  set(hObject, 'String', num2str(value));
  value = map(from_range, [0,1], value);
  handles.sliderCamRY.Value = value;


% --- Executes during object creation, after setting all properties.
function editCamRY_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end


function slider20_CreateFcn(hObject, eventdata, handles)
function slider19_CreateFcn(hObject, eventdata, handles)
function slider18_CreateFcn(hObject, eventdata, handles)
function slider17_CreateFcn(hObject, eventdata, handles)
function edit20_CreateFcn(hObject, eventdata, handles)
function edit19_CreateFcn(hObject, eventdata, handles)
function edit18_CreateFcn(hObject, eventdata, handles)
function edit17_CreateFcn(hObject, eventdata, handles)