%% dlt: function description

function [Hdlt] = dlt(u1, u2)
    [u1, Txi] = normalize(u1);
    [u2, Txli] = normalize(u2);

    A = zeros(30, 9);

    for i = 1:size(u1,2)
        a = kron(u1(:,i)', skew(u2(:,i)));
        A = [A; a];
    end

    [U,S,V] = svd(A);
    Hdlt = reshape(V(:,9), 3, 3);
    Hdlt = inv(Txli) * Hdlt * Txi;

function [points, Tx] = normalize(points)

    xc = mean(points(1,:));
    yc = mean(points(2,:));
    
    T = [ 
        1  0  -xc;
        0  1  -yc;
        0  0    1;
    ];
    
    points = T*points;

    meannorm = sum(sqrt(sum(points.*points, 1))) / size(points, 2);
    s = sqrt(2.0) / meannorm;
    
    S = [
        s  0  0;
        0  s  0;
        0  0  1;
    ];

    points = S*points;

    Tx = S*T;