function [Sc] = S (scale)
    Sc = [eye(3)*scale zeros(3,1); [0 0 0 1]];
