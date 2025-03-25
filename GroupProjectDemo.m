clc;
close all;
clear;

ImgNum = 19;
ImgName = strcat("NakedTop", sprintf("%02d", ImgNum));
Img = imread(strcat("Image/", ImgName, ".jpg"));

% Define Gabor filter parameters
wavelengths = [2 3 4 5];
orientations = [130 135 140];
thresholdValue = 8.0e+05;   % Define threshold for classification

% Extract components using the provided function
% figure(1);
pred = extractComponents(Img);
GT = readmatrix("GroundTruth/GroundTruth_boxes.csv");

mIoU_value = calculate_mIoU(GT, pred);
fprintf('Mean IoU: %.4f\n', mIoU_value);

GTClass = "GroundTruth/GroundTruth_classify.csv";
GTClassMat = readmatrix(GTClass);
GTClassMatImg = GTClassMat(:,ImgNum);
figure(2);
subplot(1,2,1)
imshow(Img);
hold on;
% Plot ground truth boxes
for i = 1:size(GT, 1)
    if GTClassMatImg(i) == 1
        rectangle('Position', GT(i,:), 'EdgeColor', 'g', 'LineWidth', 2);
    else
        rectangle('Position', GT(i,:), 'EdgeColor', 'r', 'LineWidth', 2);
    end
end
hold off;
title('Ground Truth for classification');

% Classify components using Gabor filters
subplot(1,2,2);
[predBoxes, predLabels] = classifyComponents(Img, pred, ...
                                    wavelengths, orientations, ...
                                    thresholdValue);
pause(0.05);

[precision, ...
    recall, ...
    f1_score] = evaluateClassification1(GT, GTClassMatImg, ...
                                       predBoxes, predLabels, 0.5);
