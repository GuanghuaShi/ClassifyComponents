function mIoU = calculate_mIoU(groundTruthBoxes, predictedBoxes)
    numGTBoxes = size(groundTruthBoxes, 1);
    numPredBoxes = size(predictedBoxes, 1);
    ious = zeros(numGTBoxes, 1);
    
    for i = 1:numGTBoxes
        gtBox = groundTruthBoxes(i,:);
        maxIoU = 0;
        for j = 1:numPredBoxes
            predBox = predictedBoxes(j,:);
            currentIoU = calculate_iou(gtBox, predBox);
            if currentIoU > maxIoU
                maxIoU = currentIoU;
            end
        end
        ious(i) = maxIoU;
    end
    mIoU = mean(ious);
end