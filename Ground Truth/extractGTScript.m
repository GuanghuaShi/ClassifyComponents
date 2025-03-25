img = imread('../Image/NakedTop01.jpg');
imshow(img);
title('Input Image');
groundTruthBoxes = [];

while true
    h = imrect;
    position = wait(h);
    
    if isempty(position)
        break;
    end
    
    groundTruthBoxes = [groundTruthBoxes; position];
    choice = questdlg('Do you want to draw another box?', 'Continue?', 'Yes', 'No', 'Yes');
    
    if strcmp(choice, 'No')
        break;
    end
end

close;
writematrix(groundTruthBoxes, 'ground_truth_boxes.csv');
