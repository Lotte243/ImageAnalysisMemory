function [] = create_boundary_advanced(card_up,image,binary_im,match)
% This function creates boundaries around the two cards that are face up.
% For this, a mask is placed over the regions in the binary image that
% contain the face-up cards, then using bwboundaries, the boundaries around
% the cards are found. These are then plotted

for i = 1:2 

    card = card_up{i}.BoundingBox;
    x = card(1);
    y = card(2);
    width = card(3);
    height = card(4);

    card_mask = false(size(binary_im));
    card_mask(y:(y + height - 1),x:(x + width - 1)) = true; % Create the mask, only the part of the image containing the card is seen

    masked_bw_im = binary_im & card_mask;

    boundaries = bwboundaries(masked_bw_im,'noholes');                % Find the boundaries around the card

    for j = 1:length(boundaries)
        if length(boundaries{j}) > 400
            boun_card{i} = boundaries{j};
        end
    end

end

figure;
imagesc(image);
hold on 
for k = 1:2
    boundary = boun_card{k};
    if match == 1
        plot(boundary(:,2),boundary(:,1),'g','LineWidth',2)
    else
        plot(boundary(:,2),boundary(:,1),'r','LineWidth',2)
    end
end
hold off


