function [r_indiv,r_tot] = rFactor(recon,stack,angles)
    %calculates the r-factor for a given tilt-series and its reconstruction
    
    %INPUTS:
    %   recon: the reconstruction you want to radon transform (should be cubic)
    %   stack: the tilt series stack to compare to 
    %   angles: the angles that each tilt series slice was taken at
    
    %OUTPUTS:
    %   r_indiv: individual r-factor values for each slice in the stack
    %   r_tot: total average r-factor value of all slices
    
    %PARAMETERS:
    axis=2;         %axis along which the radon transform will be done (X=1, Y=2, Z=3)
                    %usually, SIRT is along Z and GENFIRE is along Y
    direction=-1;    %1 for SIRT, -1 for GENFIRE
    support=double(makeCircle(size(stack,1)));
                    %if you used a support in GENFIRE, you should replicate
                    %that here. Otherwise, just use a square array of 1s
    savimg=false;   %if true, it saves a comparison image for each slice
    filename='rfactor';
                    %file name of the saved images
    visualize=true; %plots the r-factors afterwards
    
    %perform the radon transform
    radon_transform=radon3(recon,axis,direction*(angles-90));
    radon_size=size(radon_transform);
    
    %crop into center of radon transform
    if radon_size(1)<radon_size(2)
        radon_transform=radon_transform(1:radon_size(1),floor(radon_size(2)/2-radon_size(1)/2):floor(radon_size(2)/2+radon_size(1)/2),1:radon_size(3));
    else
        radon_transform=radon_transform(floor(radon_size(1)/2-radon_size(2)/2):floor(radon_size(1)/2+radon_size(2)/2),1:radon_size(2),1:radon_size(3));
    end
    radon_transform=rot90(radon_transform,1);
    
    %ensure even dimensions
    if mod(size(radon_transform,1),2)
        radon_transform=radon_transform(1:end-1,:,:);
    end
    if mod(size(radon_transform,2),2)
        radon_transform=radon_transform(:,1:end-1,:);
    end
    
    %align each projection, then normalize and compare r-factors
    radon_aligned=zeros(size(stack,1),size(stack,2),size(stack,3));
    r_indiv=zeros(1,size(stack,3));
    for i=1:size(stack,3)
        radon_aligned(:,:,i)=alignImg(double(stack(:,:,i)),radon_transform(:,:,i),support);
        if savimg
            saveas(gcf,strcat(filename,num2str(i),'.png'));
        end
        r_indiv(i)=rFactorCalc(double(stack(:,:,i)),radon_aligned(:,:,i),support);
    end
    r_tot=mean(r_indiv);
    
    %plot r-factor values as a function of angle
    if visualize
        plot(angles,r_indiv);
        xlabel('Angle $\theta (^\circ)$','Interpreter','latex');
        ylabel('R-factor','Interpreter','latex');
        xlim([angles(1) angles(end)]);
        grid on
    end
end