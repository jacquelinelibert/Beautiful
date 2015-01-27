clear 

ScreenSize = get(0, 'MonitorPositions');
screenHeigth = ScreenSize(1, 4);
screenWidth = ScreenSize(1, 3);

% screenHeigth = 1280 ;
% screenWidth = 960;

[X,map,alpha] = imread('BACKGROUND_unscaled.png');
% 1600 	× 	1200
[heigthPic, widthPic, ~] = size(X);

% Resampled signal, returned as a vector or matrix. If x is a signal of 
% length N and you specify p,q, then y is of length ⌈N × p/q⌉.

% y = resample(X(:, :, 1), repmat(heigthPic, 1, heigthPic), ...
%     repmat(screenHeigth, 1, heigthPic));
% 1280 1024
% 1280 960
% y = resample(squeeze(X(:, :, 1)), 1, heigthPic/screenHeigth);

Y = zeros(screenHeigth, widthPic, 3);

for heigthRGB = 1 : 3
    Y(:, :, heigthRGB) = resample(double(squeeze(X(:, :, heigthRGB))), screenHeigth, heigthPic);
end


ScreenRepetitions = widthPic/1600;
LengthScreen = round(ScreenRepetitions * screenWidth);

Y1 = zeros(LengthScreen, screenHeigth, 3);
% Y = Y'; = transpose matrice so that the second dimension can be interpolated too;
Ytransp = zeros(size(Y, 2), size(Y, 1), 3);
for irgb = 1 : 3
    Ytransp(:, :, irgb) = Y(:, :, irgb)';
end

for widthRGB =  1:3
    Y1(:, :, widthRGB) = resample(Ytransp(:, :, widthRGB), LengthScreen, widthPic);
end

% Yretransp = zeros(screenWidth, screenHeigth, 3);
Yretransp = zeros(screenHeigth, LengthScreen, 3);
for irgb = 1 : 3
    Yretransp(:, :, irgb) = Y1(:, :, irgb)';
end

% Y1 = Y1'; % transpose the matrix back to its original shape
% Y2 = round(Y1); % image must have integer values
Y2 = uint8(Yretransp);
image(Y2)
imwrite(Y2)
image(Y2)
imwrite(Y2,'BACKGROUND_scaled.png')