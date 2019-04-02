function [sphere]=makeSphere(d)
    M=zeros(d,d,d);
    M(d/2,d/2,d/2)=1;
    R=bwdist(M);
    sphere=R<=d/2;
end