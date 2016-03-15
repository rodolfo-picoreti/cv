function [handles] = init_gui(handles)

obj_path = 'scarlet-witch.obj';
[V, F] = load_obj(obj_path);
V= [V';ones(1,length(V))];
handles.objectV = Rx(pi/2)*V;
handles.objectF = F;

camera_path = 'reflex_camera.obj';
[V, F] = load_obj(camera_path);
V= [V';ones(1,length(V))];
handles.cameraV = T(50, 50, 50)*S(15)*V;
handles.cameraF = F;

handles.cameraP = T(50, 50, 50)*[0; 0; 0; 1];
set(handles.editObjTX,'Value',handles.cameraP(1));
set(handles.editObjTY,'Value',handles.cameraP(2));
set(handles.editObjTZ,'Value',handles.cameraP(3));

axes(handles.worldFigure);
trisurf(handles.objectF, ...
        handles.objectV(1,:), handles.objectV(2,:), handles.objectV(3,:), ...
        'FaceColor', 'r', 'EdgeColor', 'none');

hold on

trisurf(handles.cameraF, ...
        handles.cameraV(1,:), handles.cameraV(2,:), handles.cameraV(3,:), ...
        'FaceColor', 'b', 'EdgeColor', 'none');

handles.w_axis = [-100, 100, -100, 100, -20, 130];
axis equal;
axis(handles.w_axis);






