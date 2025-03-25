function [precision, recall, f1_score] = evaluateClassification(gtBoxes, gtlabels, predictedBoxes, predictedLabels, iouThreshold)
    TP = 0; 
    FP = 0; 
    FN = 0;

    numGTBoxes = size(gtBoxes, 1);  
    numPredBoxes = size(predictedBoxes, 1);  

    matchedGT = false(numGTBoxes, 1);  

    for i = 1:numPredBoxes
        predBox = predictedBoxes(i,:);   
        predLabel = predictedLabels(i);  
        maxIoU = 0;
        bestMatchIdx = -1;

        for j = 1:numGTBoxes
            gtBox = gtBoxes(j,:);
            gtLabel = gtlabels(j);

            currentIoU = calculate_iou(gtBox, predBox);

            if currentIoU > maxIoU && predLabel == gtLabel
                maxIoU = currentIoU;
                bestMatchIdx = j;
            end
        end

        if maxIoU >= iouThreshold && ~matchedGT(bestMatchIdx)
            TP = TP + 1;
            matchedGT(bestMatchIdx) = true;
        else
            FP = FP + 1;
        end
    end

    FN = FN + sum(~matchedGT);

    precision= TP / (TP + FP);
    recall= TP / (TP + FN);
    
    if precision + recall == 0 
       f1_score=0;
     else 
       f1_score=2 * (precision * recall) / (precision + recall);
     end
    
     fprintf('Precision: %.4f\n', precision);
     fprintf('Recall: %.4f\n', recall);
     fprintf('F1-Score: %.4f\n', f1_score);
end
