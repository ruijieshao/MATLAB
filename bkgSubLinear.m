function [stack] = bkgSubLinear(stack)
    %performs a linear background subtraction on the input stack

    stack = mat2gray(stack);
    histogram(stack,100);
    set(gca,'YScale','log');
    xlim([0 1]);
    prompt='Threshold level: ';
    thresh=input(prompt);
    if isempty(thresh)
        thresh=graythresh(stack);
        disp(['Threshold level automatically set to ' num2str(thresh)]);
    end
    close(gcf);
    stack(stack < thresh) = 0;
end