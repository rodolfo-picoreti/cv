function [handles] = initGui (handles)
    handles = initHandles(handles);
    handles = initObject(handles);
    handles = initCamera(handles);

    handles = resetAll(handles);

    r3d = rotate3d;
    r3d.Enable = 'on';
    z3d = zoom;
    z3d.Enable = 'on';
    setAllowAxesRotate(r3d,handles.cameraFigure,false); 
    setAllowAxesZoom(z3d,handles.cameraFigure,false);
    set( gcf, 'toolbar', 'figure' )
    set(handles.cameraFigure, 'Ydir', 'reverse')

    plotWorld(handles);

    axes(handles.worldFigure);
    view([-25, 30]);
