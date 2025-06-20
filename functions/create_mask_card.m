function [stats] = create_mask_card(stats, binary_im)
% This function takes the boundingbox regions create with regionprops. Then
% in each of these regions creates boundaries around the cards using
% bwboundaries. Then a mask over the card is created using these boundaries
% and the pixels inside of the boundaries. This mask can then be used to
% see only the area of the card it self and nothing else. 


for i = 1:length(stats)

    box = stats{i}.BoundingBox;                     % Get the BoundingBox determined with regionprops
    card_box = imcrop(binary_im,box);               % Crop the binary image to the size of the BoundingBox

    boundaries = bwboundaries(card_box,'noholes');  % Find the boundaries around the card in the cropped image

    for j = 1:length(boundaries)
        if length(boundaries{j}) > 400
            boundary = boundaries{j};               % Save only the boundary around the card and not any other regions
        end
    end

    mask_box = false(size(card_box));
    mask_box = poly2mask(boundary(:,2),boundary(:,1),size(mask_box,1),size(mask_box,2)) | mask_box; % Create the mask over the card using the boundaries

    stats{i}.MaskBox = mask_box;                   % Save the mask with stats so the mask is coupled with the right BoundingBox for further use
end




