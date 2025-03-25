imageName = 'NakedTop02';
img = imread(strcat('../Image/', imageName,'.jpg'));
imshow(img);
title('Input Image');

groundTruthBoxes = []; % To store bounding boxes and labels

while true
    % Draw a rectangle and get its position
    h = imrect;
    position = wait(h);
    
    if isempty(position)
        break;
    end
    
    % Prompt the user to label the rectangle as "Good" or "Bad"
    labelChoice = questdlg('Label this component:', 'Component Label', '1', '2', '1');
    
    if isempty(labelChoice)
        labelChoice = '1'; % Default to "Good" if no choice is made
    end
    
    % Append the position and label to the groundTruthBoxes array
    groundTruthBoxes = [groundTruthBoxes; position, string(labelChoice)];
    
    % Ask if the user wants to draw another box
    choice = questdlg('Do you want to draw another box?', 'Continue?', 'Yes', 'No', 'Yes');
    
    if strcmp(choice, 'No')
        break;
    end
end

close;

% Save the bounding boxes and labels to a CSV file
% Convert cell array to table for easier saving
groundTruthTable = array2table(groundTruthBoxes, ...
    'VariableNames', {'X', 'Y', 'Width', 'Height', 'Label'});
writetable(groundTruthTable, strcat(imageName, '_GT_classify.csv'));