function A=imfill3(A)
    %fills in holes in a 3D array by performing imfill in 3 dimensions
    
    for i=1:3
        for j=1:size(A,3)
            A(:,:,j)=imfill(A(:,:,j),'holes');
        end
        A=shiftdim(A,1);
    end
end