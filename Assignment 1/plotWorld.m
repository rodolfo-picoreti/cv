function [] = plotWorld (handles)
  %% --- Object Position in the World
  Robj = Rxyz(...
        str2num(get(handles.editObjRX, 'String')), ...
        str2num(get(handles.editObjRY, 'String')), ...
        str2num(get(handles.editObjRZ, 'String')));
  
  Tobj = T(...
    str2num(get(handles.editObjTX, 'String')), ...
    str2num(get(handles.editObjTY, 'String')), ...
    str2num(get(handles.editObjTZ, 'String')) ...
  );

  Vobj = Tobj*Robj*handles.object.V;

  %% --- Camera Position in the World
  Rcam = Rxyz(...
      str2num(get(handles.editCamRX, 'String')), ...
      str2num(get(handles.editCamRY, 'String')), ...
      str2num(get(handles.editCamRZ, 'String')));
  
  Tcam = T(...
    str2num(get(handles.editCamTX, 'String')), ...
    str2num(get(handles.editCamTY, 'String')), ...
    str2num(get(handles.editCamTZ, 'String')) ...
  );

  Vcam = Tcam*Rcam*handles.camera.V;

  %% --- Plot World 
  axes(handles.worldFigure);
  cla
  hold on
  axis equal;
  grid on;
  range = [handles.ranges('ObjTX'), handles.ranges('ObjTY'), handles.ranges('ObjTZ')];
  axis(range);
  
  trisurf(handles.object.F, ...
          Vobj(1,:), ...
          Vobj(2,:), ...
          Vobj(3,:), ...
          'FaceColor', 'r', 'EdgeColor', 'none');

  trisurf(handles.camera.F, ...
          Vcam(1,:), ...
          Vcam(2,:), ...
          Vcam(3,:), ...
          'FaceColor', 'b', 'EdgeColor', 'none');

  
  %% --- Camera Projection
  H = inv(Tcam*Rcam); % world to camera
  P = [eye(3) zeros(3,1)];
  K = composeIntrinsicMatrix();

  Vobj_cam = K*P*H*Vobj;
  
  itZpos = find(Vobj_cam(3,:)>0); %% filter points with positive values of Z
  Vobj_cam(1, itZpos) = Vobj_cam(1, itZpos)./Vobj_cam(3, itZpos);
  Vobj_cam(2, itZpos) = Vobj_cam(2, itZpos)./Vobj_cam(3, itZpos);
  
  %% --- Plot Projection
  axes(handles.cameraFigure);
  cla
  hold on
  axis equal;
  axis(getCameraResolution());

  plot(Vobj_cam(1,:), Vobj_cam(2,:),'r');