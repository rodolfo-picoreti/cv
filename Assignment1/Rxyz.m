function R = Rxyz(tx, ty, tz)

aux_axis = eye(3);
RX = Rodrigues(tx, aux_axis(:,1));
aux_axis = RX*aux_axis;
RY = Rodrigues(ty, aux_axis(:,2));
aux_axis = RY*aux_axis;
RZ = Rodrigues(tz, aux_axis(:,3));

R = [   RZ*RY*RX,   zeros(3,1); ...
        zeros(1,3), 1];