function [aligned] = alignCOM(stack)
    %aligns a stack by calculating their center of masses
    
    %INPUTS:
    %   stack: stack of images

    %OUTPUTS:
    %   aligned: aligned stack
    
    %PARAMETERS:
    savimg=true;   %if true, it saves a comparison image for each slice
    filename='St3_';
                    %file name of the saved images
        
    aligned=stack;
    
    for i=1:size(stack,3)
        aligned(:,:,i)=centerCOM(stack(:,:,i));
        if savimg
            saveas(gcf,strcat(filename,num2str(i),'.png'));
        end
    end
end