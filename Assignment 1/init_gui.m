function [handles] = init_gui(handles)

obj_path = 'scarlet-witch.obj';
[V, F] = load_obj(obj_path);
V= [V';ones(1,length(V))];
handles.objectV = Rx(pi/2)*V;
handles.objectF = F;

camera_path = 'reflex_camera.obj';
[V, F] = load_obj(camera_path);
V= [V';ones(1,length(V))];
handles.cameraV = T(30, 40, 50)*S(15)*V;
handles.cameraF = F;

handles.cameraP = T(30, 40, 50)*[0; 0; 0; 1];
handles.w_axis = [-100, 100, -100, 100, -20, 130];


set(handles.editObjTX,'String',num2str(handles.cameraP(1)));
set(handles.editObjTY,'String',num2str(handles.cameraP(2)));
set(handles.editObjTZ,'String',num2str(handles.cameraP(3)));

set(handles.sliderObjTX,'Value',handles.cameraP(1)/(handles.w_axis(2)-handles.w_axis(1)));
set(handles.sliderObjTY,'Value',handles.cameraP(2)/(handles.w_axis(4)-handles.w_axis(3)));
set(handles.sliderObjTZ,'Value',handles.cameraP(3)/(handles.w_axis(6)-handles.w_axis(5)));

axes(handles.worldFigure);
trisurf(handles.objectF, ...
        handles.objectV(1,:), handles.objectV(2,:), handles.objectV(3,:), ...
        'FaceColor', 'r', 'EdgeColor', 'none');

hold on

trisurf(handles.cameraF, ...
        handles.cameraV(1,:), handles.cameraV(2,:), handles.cameraV(3,:), ...
        'FaceColor', 'b', 'EdgeColor', 'none');

axis equal;
axis(handles.w_axis);






