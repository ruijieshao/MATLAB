function [rf]=rFactorCalc(imeas,icalc,support)
    %calculates the r-factor between a measured and a calculated image
    
    %INPUTS:
    %   imeas: the measured image from the stack
    %   icalc: the calculated image from the reconstruction
    %   support: support matrix to set boundaries
    %       (support weights matrix to shape final summation)

    %OUTPUTS:
    %   rf: the r-factor for a single pair of images

    %normalize images
    imeas=abs(mat2gray(imeas));
    icalc=abs(mat2gray(icalc));
    
    %sum differences between images, with support as weight
    rf=0;
    for i=1:size(imeas,1)
        for j=1:size(imeas,2)
            rf=rf+support(i,j).*abs(icalc(i,j)-imeas(i,j));
        end
    end

    %normalize by original measured image
    rf=rf./sum(sum(imeas));
end