function [shifted]=alignImg(img1,img2,support)
    %aligns img2 to img1 using cross-correlation
    
    %INPUTS:
    %   img1: image that serves as the reference
    %   img2: image that will be shifted

    %OUTPUTS:
    %   shifted: shifted img2
        
    %normalize and cross-correlate matrices
    c=normxcorr2(support.*normImg(img2),support.*normImg(img1));
    
    %calculate point of highest cross correlation
    [ypeak, xpeak]=find(c==max(c(:)));
    xoffset=round(xpeak-size(img2,2));
    yoffset=round(ypeak-size(img2,1));
    
    %create final image
    %shifted=circshift(img2,[yoffset xoffset]);
    shifted=imtranslate(img2,[xoffset yoffset]);
    %imshowpair(img1,shifted,'montage')
end