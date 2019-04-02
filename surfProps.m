function [porosity,surfacearea,sav]=surfProps(obj,thresh)
    %porosity calculation using a simple morphological model
    %surface area calculation using isosurface
    
    %INPUTS:
    %   obj: 3D object
    %   thresh: optional threshold value for basic binary segmentation
    %           if no value is provided, threshold will automatically be
    %           determined using minimum error thresholding
    
    %           J. Kittler and J. Illingworth, "Minimum Error Thresholding,"
    %           Pattern Recognition 19, 41-47 (1986)
    
    %OUTPUTS:
    %   porosity: percent of object that is void
    %   surfacearea: surface area of object in square pixels
    %   sav: surface area to volume ratio in inverse pixels
    
    %segment and threshold
    if nargin==1
        [thresh,~]=kittlerMinimimErrorThresholding(255*mat2gray(obj));
    	A=mat2gray(obj)>(thresh/255);
    else
        A=mat2gray(obj)>thresh;
    end
    
    %test4=mat2gray(imsegkmeans3(test3,4));
    
    A=bwmorph3(A,'clean');
    
    %fill volume
    Afill=imfill3(A);
    %se=strel('sphere',round(size(A,2)/20));
    %Afill=imclose(A,se);
    
    %calculate porosity
    volphysical=sum(A(:));
    voltot=sum(Afill(:));
    porosity=1-(volphysical/voltot);
    
    %create isosurface and find total area of triangles
    surf=isosurface(A,0);
    vertices=surf.vertices;
    faces=surf.faces;
    if size(vertices,1)<3
        surfacearea=0;
    else
        a=vertices(faces(:,2),:)-vertices(faces(:,1),:);
        b=vertices(faces(:,3),:)-vertices(faces(:,1),:);
        c=cross(a,b,2);
        surfacearea=0.5*sum(sqrt(sum(c.^2,2)));
    end
    
    %surface area to volume ratio
    sav=surfacearea/voltot;
end