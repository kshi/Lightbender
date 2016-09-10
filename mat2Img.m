function [ I ] = mat2Img( M )
I = uint8( M / max(M(:)) * 255);
end

