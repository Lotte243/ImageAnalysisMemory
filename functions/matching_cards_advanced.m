function [match] = matching_cards_advanced(card_up,image)
% This function extracts the SIFT features of the two face-up cards and
% checks if they are a match by checking if there are more matching points
% than the threshold.

% Make a gray scale image of the image
imgray = rgb2gray(image);

descriptors = [];
% Create the descriptors for the two cards
    for h = 1:2
        box = card_up{h}.BoundingBox;
        card_c{h} = imcrop(imgray,box);
        points_c{h} = detectSIFTFeatures(card_c{h});
        [desc, validpoints{h}] = extractFeatures(card_c{h},points_c{h});
        descriptors{h} = desc;
    end

    % Find the amount of matches
    matches_up = matchFeatures(descriptors{1},descriptors{2},'Method','Exhaustive','MaxRatio',0.7,'MatchThreshold',5);

if length(matches_up) >= 25
    match = 1;
else 
    match = 0;
end