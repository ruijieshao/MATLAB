function [sub] = bkgSub(stack)
    %automatic background subtraction of a stack of images using Otsu's
    %method
    
    %INPUTS:
    %   stack: input stack of images

    %OUTPUTS:
    %   sub: background-subtracted stack of images
    
    stack=mat2gray(stack);
    stack=stack-min(stack(:));
    sub=stack;
        
    for i=1:size(stack,3)
       img=stack(:,:,i);
       mask=imbinarize(img,graythresh(img));
       sub(:,:,i)=img.*mask;
    end
end