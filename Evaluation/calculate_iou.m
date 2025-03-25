function iou = calculate_iou(boxA, boxB)
    xA = max(boxA(1), boxB(1));
    yA = max(boxA(2), boxB(2));
    xB = min(boxA(1) + boxA(3), boxB(1) + boxB(3));
    yB = min(boxA(2) + boxA(4), boxB(2) + boxB(4));
    
    interArea = max(0, xB - xA) * max(0, yB - yA);
    
    areaA = boxA(3) * boxA(4);
    areaB = boxB(3) * boxB(4);
    
    unionArea = areaA + areaB - interArea;
    
    if unionArea == 0
        iou = 0;
    else
        iou = interArea / unionArea;
    end
end