%% normscale: function description

function [x] = normscale(x)
    for i = 1:size(x,2)
        x(:,i) = x(:,i)/x(3,i);
    end