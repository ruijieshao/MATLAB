function [rt] = radon3(obj,axis,range)
    %performs a radon transform on a 3D object
    
    %INPUTS:
    %   obj: 3D object to transform
    %   axis: axis along which radon transform will be done (x=1, y=2, z=3)
    %   range: range of angles (in degrees)

    %OUTPUTS:
    %   rt: radon transform performed with the given input parameters

    if axis==1
        sz=size(radon(squeeze(obj(1,:,:)),range));
        rt=zeros(size(obj,1),sz(1),sz(2));
        for i=1:size(obj,1)
            rt(i,:,:)=radon(squeeze(obj(i,:,:)),range);
        end
    elseif axis==2
        sz=size(radon(squeeze(obj(:,1,:)),range));
        rt=zeros(size(obj,2),sz(1),sz(2));
        for i=1:size(obj,2)
            rt(i,:,:)=radon(squeeze(obj(:,i,:)),range);
        end
    elseif axis==3
        sz=size(radon(squeeze(obj(:,:,1)),range));
        rt=zeros(size(obj,3),sz(1),sz(2));
        for i=1:size(obj,3)
            rt(i,:,:)=radon(squeeze(obj(:,:,i)),range);
        end
    else
        error('Invalid axis (use 1 for x-axis, 2 for y-axis, 3 for z-axis)')
    end
end