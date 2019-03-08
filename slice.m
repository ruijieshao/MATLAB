function slice(stack)
    %saves stacks of slices along different axes of a stack
    
    for i=1:size(stack,3)
        imshow(stack(:,:,i));
        saveas(gcf,strcat('slice_xy_',num2str(i),'.png'));
    end
    stack=shiftdim(stack,1);
    for i=1:size(stack,3)
        imshow(stack(:,:,i));
        saveas(gcf,strcat('slice_xz_',num2str(i),'.png'));
    end
    stack=shiftdim(stack,1);
    for i=1:size(stack,3)
        imshow(stack(:,:,i));
        saveas(gcf,strcat('slice_yz_',num2str(i),'.png'));
    end
end