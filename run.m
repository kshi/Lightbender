root = 'platypus/';
I = imread([root,'IMG_6193.jpg']);
[C, P, ~, V] = parseDataScript([root,'bundle/bundle.out']);
D = projectToCamera(P, V, C, 1, size(I));
im = transformImage(I,D,1,3,10);
imshow(im);