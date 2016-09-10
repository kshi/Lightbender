function [ output ] = transformImage( I, D, f, d, a )
w = size(I,2);
h = size(I,1);
output = zeros(h,w,3);
C = circleOfConfusion(D,f,d,a); 
radius_steps = min(C(:)):max(C(:))+1;
I = double(I);
for i=1:length(radius_steps)-1
    lb = radius_steps(i);
    up = radius_steps(i+1);
    circle = ones(2*ceil(lb)+1,2*ceil(lb)+1);
    [iq,jq] = meshgrid(1:2*ceil(lb)+1,1:2*ceil(lb)+1);
    circle = circle .* double(sqrt(bsxfun(@minus, iq, ceil(lb)).^2 + bsxfun(@minus, jq, ceil(lb)).^2) <= lb);
    numPtsInFilter = sum(circle(:));
    circle = circle / numPtsInFilter;
    subI = bsxfun(@times, double(I), double( C >= lb & C < up ));
    output = output + convn(subI, circle, 'same');
end
output = mat2Img(output);
end

