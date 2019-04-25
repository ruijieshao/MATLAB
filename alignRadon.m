function stack_aligned=alignRadon(recon,stack,angles)
    %aligns a tilt series to the radon transform of its reconstruction
    
    %INPUTS:
    %   recon: the reconstruction you want to radon transform (should be cubic)
    %   stack: the tilt series stack to compare to 
    %   angles: the angles that each tilt series slice was taken at
    
    %OUTPUTS:
    %   stack_aligned: the stack input with adjustments to align it to the
    %   input reconstruction
    
    %PARAMETERS:
    axis=3;         %axis along which the radon transform will be done (X=1, Y=2, Z=3)
                    %usually, SIRT is along Z and GENFIRE is along Y
    direction=1;    %1 for SIRT, -1 for GENFIRE
    support=double(makeCircle(size(stack,1)));
    %support=ones(size(stack,1),size(stack,2));
                    %if you used a support in GENFIRE, you should replicate
                    %that here. Otherwise, just use a square array of 1s
    
    %perform the radon transform
    radon_transform=radon3(recon,axis,direction*(angles+90));%YOU MAY NEED TO PLAY WITH THIS SINCE IT'S NOT ALWAYS AS DESCRIBED EARLIER
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
    
    %align each projection
    stack_aligned=zeros(size(stack,1),size(stack,2),size(stack,3));
    for i=1:size(stack,3)
        stack_aligned(:,:,i)=alignImg(radon_transform(:,:,i),double(stack(:,:,i)),support);
        %saveas(gcf,strcat('alignRadon',num2str(i),'.png'));
    end
end