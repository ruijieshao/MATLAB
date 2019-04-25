function [out]=normImg(in)
    %normalizes an image matrix or stack
    m=min(in(in>0));
    in(in<m)=m;
    out=mat2gray(in-m);
end