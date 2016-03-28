webim=imread('clutteredDesk.jpg');
% webim=imrotate(webim,180);
status=1;
% for i = 1:4:24
boxImage=imread('4.jpg');
figure;
imshow(boxImage);
if (ndims(boxImage)>2)
    boxImage=rgb2gray(boxImage);
end
title('Guitar template');
boxPoints = detectSURFFeatures(boxImage);
figure;
imshow(boxImage);
title('500 Strongest Feature Points from Box Image');
hold on;
plot(selectStrongest(boxPoints, 500));

im=webim;
figure;
imshow(im);
im=rgb2gray(im);
scenePoints = detectSURFFeatures(im);
title('1000 Strongest Feature Points from Scene Image');
hold on;
plot(selectStrongest(scenePoints, 1000));

[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(im, scenePoints);

boxPairs = matchFeatures(boxFeatures, sceneFeatures);

matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
figure;
showMatchedFeatures(boxImage, im, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');





[tform, inlierBoxPoints, inlierScenePoints, status] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine'); %Make this function return the status


display(status);




if (status == 0)
%     topleft=face(i).label;
%     ii=i;
    fprintf('MATCHED  ');
%     break;
end

