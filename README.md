# ClassifyComponents

Feature Engineering Fall 2024

CSCE 5222 Feature Engineering Group #5 

Members: Karthik Venkatasivareddy, Guanghua Shi and Panam Dodia 

# Problem statement - “A method to classify image components based on image texture” 


## **Problem Description:**

  This project aims to develop an automated method for detecting the status of each component in images. And accurately identifying components as "good" or "bad" based on the clearance of the strip or cross patterns. Automated recognition and texture classification can reduce the need for manual inspection and ensure greater consistency and accuracy. The project will assess the quality of components quickly and accurately. The method takes a single image as an input, detects the individual component in the image, detects the textures of the components, and further classifies these components into three classes of components. For some basic ideas and methods, we refer to Article [1] and the references therein. 


## **Importance:**

The project tries to address the need for automated quality assessment in additive manufacturing. Conditions vary within a 3D printer after every layer of printing, which affects the visibility of components. 


## **Project Scope:**

We plan to implement our solution using the following steps as part of our project. 

    1. Image preprocessing to reduce the impact of overexposure.
    2. Implement a component detection function.
    3. Implement a function to extract the components from the images.
    4. Implement a function to classify the components into bad and good components. 
    5. Visualize components based on the classes. 

 

## **Evaluation Metrics used:**

We plan to use mIoU for the evaluation of the detection of components in the images. For the evaluation of the classification task, we plan to use Precision, F1 score, and Recall. 


## **Dataset:**

We use 20 grayscale images as our dataset. We consider label 1 as good components and label 2 as bad components. We consider the red bounding boxes as bad classification labels, and the green bounding boxes as good classification labels. For the prediction, we plan to use a blue color to classify the incorrectly detected components in the images. 


## **Methodology:**


**Image Preprocessing:**

Implement a Median filter to reduce noise. Apply adaptive histogram equalization to address lighting inconsistencies. We uniformly processed 20 images and saved the processed images. Originally, we applied a Gaussian filter to reduce the noise. However, it makes the images too smooth, which is not conducive to component detection and extraction. So, we apply the Median filter which can make the edges of the components sharp and easy to detect and extract. To make full use of the color range and increase the contrast of the texture of the components, we apply Histogram Equalization. We show one of the pre-processed images below (NakedTop01). We observe that the results of our preprocessing step only help us with the results for 2 images (NakedTop01 and NakedTop02) and hence we just modify only these two images from the original dataset. 


**Component detection:**

Steps used in our component detection: 

    1. Additional noise reduction.  
    2. Apply edge detection using Sobel.  
    3. Apply morphological operations to clean up the image.  
    4. Detect the boundaries of the squares and extract bounding boxes.  
    5. Filter the bounding boxes based on the area.  
    6. Combine very close bounding boxes.


**Pattern detection and classification:**

**Option 1:** Hough Transform - Set a threshold based on the minimum length or number of the detected lines to classify the components as good or bad.  Steps for classification components using Hough transform:

    1. Crop the component using its bounding box
    2. Applied Hough Transform to detect lines
    3. Set the maximum number of peaks as 15 (That gave a better result)
    4. Set peak threshold at 20% of maximum value
    5. Set the maximum gap allowed between two-line segments to be connected as 5 pixels
    6. Set the minimum length of the line segment to 15 pixels


**Improvement -** After improving the component extraction code, for a better result we used Gamma correction (imadjust) for contrast enhancement and Unsharp masking (imsharpen) for sharpening details. And then classify them as Good (Green) and Bad (Red). Classify as “Good” if pattern <= 2 different directions of lines. Classify as “Bad” if pattern > 2 different directions or fewer than 2 lines. 


**Option 2:** Gabor filter - Set the threshold for the frequency strength response to classify the components. Steps for classification components using the Gabor filter: 

    1. Initialize a variety of Gabor filter parameters based on our images.
    2. Create Gabor filters based on our parameters.
    3. Apply the Gabor filtering process to the input image based on our derived filters.
    4. Calculate the mean and variance of the Gabor responses.
    5. Compute the Gray-Level Co-occurrence Matrix (GLCM) and extract texture features.
    6. Combine Gabor and GLCM features into a single feature vector.
    7. Compute the meaning of all the combined features.
    8. Use thresholding to classify the components into good and bad components.


## **Overview diagram:**

![image](https://github.com/user-attachments/assets/fd3c6a37-2fe8-4d9b-bcc1-6aca9dedf9fa)


## **Evaluation:**

Manually determine the ground truth for the components as good or bad based on the image appearance. Use evaluation metrics such as precision, recall, and F1 score to compare our model's results with the ground truth. Steps used in our Evaluation:  

    1. Prepare predicted boxes with labels and Ground truth boxes with labels. 
    2. Match Predictions to Ground Truth based on IoUs. 
    3. Create a matched label for each ground truth box. 
    4. Based on ground truth labels and the matched labels calculate metrics TP, FP, and FN.
    5. Calculate Precision, Recall, and F1 score. 

**Evaluation Results:**

We have achieved an average mIoU of 0.7282 over all the images. We have achieved the overall evaluation results of average precision of 0.6395, average recall of 0.7259, 	and average F1 score of 0.6800. 

![image](https://github.com/user-attachments/assets/7454ce1b-805f-4b1b-b6c7-4d7e30cc5b7b)


## References:  

[1] Armi, L., & Fekri-Ershad, S. (2019). Texture image analysis and texture classification 	methods-A review. arXiv preprint arXiv:1904.06554. 
