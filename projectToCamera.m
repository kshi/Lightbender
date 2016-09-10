function [ D ] = projectToCamera( P, V, C, n, S )
% input P: 3D point cloud positions. M-by-3
% input V: "logical" array of points in view. N-by-(3*M)
% input C: camera matrix
% input n: camera index
% input S: size (height, width) of desired output image
% output D: matrix of interpolated depthmaps for the pixels corresponding

t = C(5*(n+1),:);
w = S(2);
h = S(1);
numPoints = size(P,2);
distances = sqrt(sum( (bsxfun(@minus, P, t')).^2,1 ));
view = reshape(V(n+1,:),3,numPoints);
include = logical(view(1,:));
X = view(2,include) + w/2;
Y = view(3,include) + h/2;

[Xq,Yq] = meshgrid(1:w, 1:h);

intp = scatteredInterpolant(X',Y',distances(include)','natural');
D = intp(Xq,Yq);

end

