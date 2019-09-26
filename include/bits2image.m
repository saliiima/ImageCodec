function I = bits2image( B, MN, P )
% Recover a digital image from a matrix of raw bits.
%
% @input:   B, a binary matrix composed of the image into bits.
%           MN = [M, N], number of rows (M) and columns (N) of the image.
%           P, the image quantization order (number of bits per pixel) per
%               channel (e.g. R, G and B).
%
% @output:  I, a digital image (three or two-dimensional matrix).

L = size(B, 2);
M = MN(1);
N = MN(2);

I = zeros(M, N, L);

for l = 1:L
    for n = 1:N
        for m = 1:M
            I(m, n, l) = bin2dec(char(...
                            B((n-1)*M*P+(m-1)*P+1:(n-1)*M*P+m*P, l)'+48 ...
                         ));
        end
    end
end

switch P
    case 8
        I = uint8(I);
    case 16
        I = uint16(I);
    case 1
        I = logical(I);
    otherwise
        warning(['No matching image conversion. Default to 8-bit ' ...
            'unsigned integer'])
        I = uint8(I);
end

end