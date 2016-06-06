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

% Last Modified by GUIDE v2.5 28-Mar-2016 21:19:45

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

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
handles = initGui(handles);
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

%% --- EDIT OBJ FUNCTIONS
function editObjTX_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'ObjTX');
function editObjTY_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'ObjTY');
function editObjTZ_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'ObjTZ');

function editObjRX_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'ObjRX');
function editObjRY_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'ObjRY');
function editObjRZ_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'ObjRZ');

%% --- EDIT CAM FUNCTIONS
function editCamTX_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'CamTX');
function editCamTY_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'CamTY');
function editCamTZ_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'CamTZ');
  
function editCamRX_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'CamRX');
function editCamRY_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'CamRY');
function editCamRZ_Callback(hObject, eventdata, handles)
  updateEdit(handles, 'CamRZ');

%% --- SLIDER OBJ FUNCTIONS
function sliderObjTX_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'ObjTX');
function sliderObjTY_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'ObjTY');
function sliderObjTZ_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'ObjTZ');

function sliderObjRX_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'ObjRX');
function sliderObjRY_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'ObjRY');
function sliderObjRZ_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'ObjRZ');  

%% --- SLIDER CAM FUNCTIONS
function sliderCamTX_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'CamTX');
function sliderCamTY_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'CamTY');
function sliderCamTZ_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'CamTZ');

function sliderCamRX_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'CamRX');
function sliderCamRY_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'CamRY');
function sliderCamRZ_Callback(hObject, eventdata, handles)
  updateSlider(handles, 'CamRZ');

  
  
  
  
  
  
  
  
  
  
  
  %% --- Executes during object creation, after setting all properties.
function editObjRY_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end

function sliderObjRX_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function editObjRX_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end

function sliderObjRZ_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function editObjRZ_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end

function sliderObjRY_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function sliderObjTY_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function sliderObjTZ_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end
  
function editObjTZ_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
  
function editObjTX_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
  
function sliderObjTX_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end
  
function editObjTY_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
  end

function editCamTY_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end

function sliderCamTX_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function editCamTX_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end

function editCamTZ_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end

function sliderCamTZ_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function sliderCamTY_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function sliderCamRY_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function editCamRX_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white'); 
  end

function editCamRZ_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end

function sliderCamRZ_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

function sliderCamRX_CreateFcn(hObject, eventdata, handles)
  if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
  end

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
  
% --------------------------------------------------------------------
function cameraMenu_Callback(hObject, eventdata, handles)
% hObject    handle to cameraMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  cameraMenu(@() plotWorld(handles));

