function [ output ] = transformImage( I, D, f, d, a )
w = size(I,2);
h = size(I,1);
output = zeros(h,w,3);
C = circleOfConfusion(D,f,d,a); 
step_size = 1;
radius_steps = min(C(:)):step_size:max(C(:))+step_size;
I = double(I);
for i=1:length(radius_steps)-1
    lb = radius_steps(i);
    up = radius_steps(i+1);
    circle = ones(2*ceil(lb)+1,2*ceil(lb)+1);
    [iq,jq] = meshgrid(1:2*ceil(lb)+1,1:2*ceil(lb)+1);
    circle = circle .* double(sqrt(bsxfun(@minus, iq, 2*ceil(lb)).^2 + bsxfun(@minus, jq, 2*ceil(lb)).^2) <= lb);
    numPtsInFilter = sum(circle(:));
    circle = circle / numPtsInFilter;   
    subI = bsxfun(@times, double(I), double( C >= lb & C < up ));
    output = output + convn(subI, circle, 'same');
end
output = mat2Img(output);
end

