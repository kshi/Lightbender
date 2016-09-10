function [ C ] = circleOfConfusion( D, f, d, a )
% input D: depth map for each pixel
% input f: focal length
% input d: focal distance
% input a: aperture diameter
% output C: radius of circle of confusion for each pixel

dconverge = bsxfun(@rdivide, f*D,bsxfun(@minus, D, f)); % l'
dfocal = f*d/(d-f); % d'_{focus}
%dimage = bsxfun(@rdivide,1,bsxfun(@minus, 1/f, bsxfun(@rdivide, 1, D)));
C = abs(bsxfun(@rdivide,bsxfun(@minus,dconverge, dfocal),dfocal) * a);

end

