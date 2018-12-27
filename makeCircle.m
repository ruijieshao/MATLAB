function [circ] = makeCircle(d)
    M=zeros(d);
    M(d/2,d/2)=1;
    R=bwdist(M);
    circ=R<=d/2;
end