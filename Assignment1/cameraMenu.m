function varargout = cameraMenu(varargin)
% CAMERAMENU MATLAB code for cameraMenu.fig
%      CAMERAMENU, by itself, creates a new CAMERAMENU or raises the existing
%      singleton*.
%
%      H = CAMERAMENU returns the handle to a new CAMERAMENU or the handle to
%      the existing singleton*.
%
%      CAMERAMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERAMENU.M with the given input arguments.
%
%      CAMERAMENU('Property','Value',...) creates a new CAMERAMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cameraMenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cameraMenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cameraMenu

% Last Modified by GUIDE v2.5 30-Mar-2016 09:23:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cameraMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @cameraMenu_OutputFcn, ...
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


% --- Executes just before cameraMenu is made visible.
function cameraMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cameraMenu (see VARARGIN)

% Choose default command line output for cameraMenu
  handles.output = hObject;
  handles.onExit = varargin{1};

  parameters = getCameraIntrinsicParameters();
  focalLength = parameters.focalLength;
  resolution = parameters.resolution;
  scales = parameters.scales;

  set(handles.editFocalLength, 'String', num2str(focalLength));
  set(handles.editResolutionWidth, 'String', num2str(resolution(1)));
  set(handles.editResolutionHeight, 'String', num2str(resolution(2)));
  set(handles.editScaleX, 'String', num2str(scales(1)));
  set(handles.editScaleY, 'String', num2str(scales(2)));
  
  guidata(hObject, handles);

% UIWAIT makes cameraMenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cameraMenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



% --- Executes on button press in buttonApply.
function buttonApply_Callback(hObject, eventdata, handles)
% hObject    handle to buttonApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
  focalLength = str2num(get(handles.editFocalLength, 'String'));
  resolutionWidth = str2num(get(handles.editResolutionWidth, 'String'));
  resolutionHeight = str2num(get(handles.editResolutionHeight, 'String'));
  scaleX = str2num(get(handles.editScaleX, 'String'));
  scaleY = str2num(get(handles.editScaleY, 'String'));

  setCameraIntrinsicParameters( ...
    focalLength, ...
    [resolutionWidth resolutionHeight], ...
    [scaleX scaleY] ...
  );
  handles.onExit();
  close(handles.output)


function editFocalLength_Callback(hObject, eventdata, handles)
% hObject    handle to editFocalLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFocalLength as text
%        str2double(get(hObject,'String')) returns contents of editFocalLength as a double


% --- Executes during object creation, after setting all properties.
function editFocalLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFocalLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
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



function editScaleX_Callback(hObject, eventdata, handles)
% hObject    handle to editScaleX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editScaleX as text
%        str2double(get(hObject,'String')) returns contents of editScaleX as a double


% --- Executes during object creation, after setting all properties.
function editScaleX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editScaleX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonCancel.
function buttonCancel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  close(handles.output)


function editResolutionWidth_Callback(hObject, eventdata, handles)
% hObject    handle to editResolutionWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editResolutionWidth as text
%        str2double(get(hObject,'String')) returns contents of editResolutionWidth as a double


% --- Executes during object creation, after setting all properties.
function editResolutionWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editResolutionWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editResolutionHeight_Callback(hObject, eventdata, handles)
% hObject    handle to editResolutionHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editResolutionHeight as text
%        str2double(get(hObject,'String')) returns contents of editResolutionHeight as a double


% --- Executes during object creation, after setting all properties.
function editResolutionHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editResolutionHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editScaleY_Callback(hObject, eventdata, handles)
% hObject    handle to editScaleY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editScaleY as text
%        str2double(get(hObject,'String')) returns contents of editScaleY as a double


% --- Executes during object creation, after setting all properties.
function editScaleY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editScaleY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
