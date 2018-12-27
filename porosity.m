function p = porosity(obj)
    %porosity calculation using a simple morphological model
    
    A=imbinarize(obj,graythresh(obj));
    A=bwmorph3(A,'majority');
    A=bwmorph3(A,'majority');
    A=bwmorph3(A,'clean');
    Afill=imfill3(A);
    
    vol_phys=sum(sum(sum(A)));
    vol_tot=sum(sum(sum(Afill)));
    
    p=(vol_tot-vol_phys)/vol_tot;
end