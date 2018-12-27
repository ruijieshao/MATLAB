function [shifted] = alignStack(img1,img2,support)
    %aligns two images
    
    %INPUTS:
    %   img1: image that serves as the reference
    %   img2: image that will be shifted

    %OUTPUTS:
    %   shifted: shifted img2
        
    %normalize and cross-correlate matrices
    c=normxcorr2(support.*mat2gray(img2),support.*mat2gray(img1));
    minv=double(min(min(min(img2))));
    
    %calculate point of highest cross correlation
    [ypeak, xpeak]=find(c==max(c(:)));
    xoffset=xpeak-size(img2,2);
    yoffset=ypeak-size(img2,1);
    xbegin=round(xoffset+1);
    xend=round(xoffset+size(img2,1));
    ybegin=round(yoffset+1);
    yend=round(yoffset+size(img2,2));
    
    %perform image shifts for x
    if xbegin<1
        df=1-xbegin;
        img2=padarray(img2,[df 0],minv,'pre');
        xbegin=1;
        xend=xend+df;
    elseif xend>size(img2,1)
        df=xend-size(img2,1);
        img2=padarray(img2,[df 0],minv,'post');
    end
    
    %perform image shifts for y
    if ybegin<1
        df=1-ybegin;
        img2=padarray(img2,[0 df],minv,'pre');
        ybegin=1;
        yend=yend+df;
    elseif yend>size(img2,2)
        df=yend-size(img2,2);
        img2=padarray(img2,[0 df],minv,'post');
    end
    
    %create final image
    shifted=img2(xbegin:xend,ybegin:yend);
    imshowpair(img1,shifted,'montage')
end