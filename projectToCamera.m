function [ D ] = projectToCamera( P, V, C, n, S )
% input P_w: 3D point cloud positions. M-by-3
% input V: "logical" array of points in view. N-by-M
% input C: camera matrix
% input n: camera index
% input S: size (height, width) of desired output image
% output D: matrix of interpolated depthmaps for the pixels corresponding

H_wc = eye(4); % homogenous transform from world to camera frame
H_wc(1:3,1:3) = C(2:4,:);
H_wc(1:3,4) = C(5,:);

P_c = H_wc*[P; ones(1,size(P,2))];

include = logical(V(n+1,:));

w = S(2);
h = S(1);
Z = P_c(3,include)';

P_proj = [-P_c(1,:)'./P_c(3,:)', ...
    P_c(2,:)'./P_c(3,:)'];
rp = 1 + C(1,2)*sum(P_proj.^2,2) + C(1,3)*sum(P_proj.^4,2);
P_i = [C(1,1).*rp.*P_proj(:,1) + w/2, C(1,1).*rp.*P_proj(:,2) + h/2];

X = P_i(include,1);
Y = P_i(include,2);

[Xq,Yq] = meshgrid(1:w, 1:h);


fprintf('interpolating ... ')
intp = scatteredInterpolant(X,Y,Z,'natural');
D = intp(Xq,Yq);
fprintf('done\n')

end

