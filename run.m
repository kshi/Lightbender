I = imread('IMG_0739.jpg');
[C, P, ~, V] = parseDataScript('bundle.out');
D = projectToCamera(P, V, C, 0, size(I));
im = transformImage(I,D,1,2.5,10);
imshow(im);