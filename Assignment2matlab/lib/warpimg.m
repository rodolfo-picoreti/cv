function [imgw,Tw] = warpimg(img1,H)

%img1 = imread('Image_00012.bmp');
%H = [0.3659 0.0120 104.5521;-0.0716 0.5707 26.1787;-0.0003 0.0001 0.6859];

img1 = double(img1);
[rows,cols] = size(img1);

% Pontos das bordas transformadas
% 1-----------2
% |           |
% 4-----------3
b1 = [1 cols cols 1;1 1 rows rows;1 1 1 1];
b1w = H*b1;
% Normalizando os pontos da borda na imagem warped
b1w(1,:) = round(b1w(1,:)./b1w(3,:));
b1w(2,:) = round(b1w(2,:)./b1w(3,:));
b1w(3,:) = 1;

% Decide o tamanho novo da imagem
nrows = max(b1w(2,:))-min(b1w(2,:))+1;
ncols = max(b1w(1,:))-min(b1w(1,:))+1;
% Transformacao de mudanca do ponto da origem (1,1)
Tw = [1 0 (-min(b1w(1,:))+1);0 1 (-min(b1w(2,:))+1);0 0 1];

% Transformacao completa da warped pra imagem 1
Hwinv = inv(Tw*H);

% Transformando os pontos da warped pro referencial da imagem 1
% para descobrir os valores de intensidade de pixel da imagem
% warped na imagem 1
[xw,yw] = meshgrid(1:ncols,1:nrows);
xw = reshape(xw,1,[]);
yw = reshape(yw,1,[]);
indw = 1:length(xw); % indices para facilitar mexer na imagem
Pw = [xw;yw;ones(size(xw))];
P1 = Hwinv*Pw;
P1(1,:) = round(P1(1,:)./P1(3,:));
P1(2,:) = round(P1(2,:)./P1(3,:));
P1(3,:) = 1;

% Retira os pontos fora dos limites da imagem 1
cols_fora = (P1(1,:)<1)|(P1(1,:)>cols)|(P1(2,:)<1)|(P1(2,:)>rows);
P1(:,cols_fora) = [];
indw(cols_fora) = [];

% Descobre o valor de cada pixel novo:
P1min = floor(P1(1:2,:));
P1max = ceil(P1(1:2,:));
dr = P1(2,:)-P1min(2,:);
dc = P1(1,:)-P1min(1,:);
indmm = sub2ind(size(img1),P1min(2,:),P1min(1,:));
indmM = sub2ind(size(img1),P1min(2,:),P1max(1,:));
indMm = sub2ind(size(img1),P1max(2,:),P1min(1,:));
indMM = sub2ind(size(img1),P1max(2,:),P1max(1,:));

linha1 = img1(indmm).*(1-dc) + img1(indmM).*dc;
linha2 = img1(indMm).*(1-dc) + img1(indMM).*dc;
imgw = zeros(nrows,ncols);
imgw(indw) = linha1.*(1-dr) + linha2.*dr;

% figure,imshow(img1,[]);
% figure,imshow(imgw,[]);