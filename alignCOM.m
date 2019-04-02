function aligned=alignCOM(stack,alignment)
    %aligns a stack by calculating their center of masses
    
    %INPUTS:
    %   stack: original stack that will be aligned and outputted
    %   alignment: original stack after strong background subtraction, used
    %   for COM alignment (optional)
    %
    %   these two should be the same data with different thresholding.
    %   stack thresholded for preservation of data and alignment
    %   thresholded for total background removal

    %OUTPUTS:
    %   aligned: aligned stack
                    
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
        %aligned(:,:,i)=circshift(stack(:,:,i),[yoffset xoffset]);
        aligned(:,:,i)=imtranslate(stack(:,:,i),[xoffset yoffset]);
        
        %I can't think of a good reason to use circshift over imtranslate
        %unless you're going to align again afterwards and need to keep all
        %the data for future use but if you do use it, the x and y are 
        %switched from each other
        
        %create final image
        %imshowpair(stack(:,:,i),aligned(:,:,i),'montage')
        %saveas(gcf,strcat('alignCOM',num2str(i),'.png'));
    end
end