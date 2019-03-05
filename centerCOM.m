function [shifted] = centerCOM(img)
    %aligns the center of mass of an image to the center
    
    %INPUTS:
    %   img: image

    %OUTPUTS:
    %   shifted: shifted image
    
    %calculate center of mass
    [x,y]=meshgrid(1:size(img,1),1:size(img,2));
    xc=ceil(size(img,1)/2);
    yc=ceil(size(img,2)/2);
    wx=x.*img;
    wy=y.*img;
    xcom=sum(wx(:))/sum(img(:));
    ycom=sum(wy(:))/sum(img(:));
    
    %shift image to center of mass
    xoffset=round(xcom-xc);
    yoffset=round(ycom-yc);
    
    %create final image
    shifted=circshift(img,[xoffset yoffset]);
    imshowpair(img,shifted,'montage')
end