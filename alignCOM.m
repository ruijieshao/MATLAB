function [aligned] = alignCOM(stack,alignment)
    %aligns a stack by calculating their center of masses
    
    %INPUTS:
    %   stack: original stack that will be aligned and outputted
    %   alignment: original stack after strong background subtraction, used
    %   for COM alignment (optional)
    %
    %   these two should be the same data with different thresholding.
    %   stack thresholded for preservation of important data and alignment
    %   thresholded for minimal background

    %OUTPUTS:
    %   aligned: aligned stack
    
    %PARAMETERS:
    savimg=true;   %if true, it saves a comparison image for each slice
    filename='AlignCOM';
                    %file name of the saved images
                    
    if nargin==1
    	alignment=stack;
    end
    aligned=stack;
    
    for i=1:size(stack,3)
        %calculate center of mass
        align=alignment(:,:,i);
        [x,y]=meshgrid(1:size(align,1),1:size(align,2));
        wx=x.*align;
        wy=y.*align;
        xcom=sum(wx(:))/sum(align(:));
        ycom=sum(wy(:))/sum(align(:));        

        %shift image to center of mass
        xoffset=round(ceil(size(align,1)/2)-xcom);
        yoffset=round(ceil(size(align,2)/2)-ycom);
        aligned(:,:,i)=circshift(stack(:,:,i),[yoffset xoffset]);
        
        %create final image
        
        imshowpair(stack(:,:,i),aligned(:,:,i),'montage')
        if savimg
            saveas(gcf,strcat(filename,num2str(i),'.png'));
        end
    end
end