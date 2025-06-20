function [card_up,card_down] = card_up_or_down_advaned(stats, image)
% This function determines wether a card is face up or face down by looking
% at the average pixel value of the card. It takes the boundaries of the
% cards earlier determined and then looks at the pixel value of the card
% only look at in the blue channel. Since the backs of the cards are mostly
% yellow, this will not show up through the blue channel and the average
% pixel value will be lower than the front of the cards. 
% By setting a threshold it can then be determined wether the card is
% placed face up or face down. The positions of the face up and the face
% down cards will then be saved.


amount_cards = length(stats);
up = 1;
down = 1;
card_up = [];
card_down = [];
pix_all = [];

for k = 1:amount_cards
    current_card = stats{k};
    box = current_card.BoundingBox;
    card_mask = current_card.MaskBox;

    card_box = imcrop(image,box);       % Crop the image to the size of the BoundingBox
    card_box_blue = card_box(:,:,3);    % Look through only the blue channel

    masked_im = card_box_blue .* uint8(card_mask);   % Place mask over the image

    mean_pix(k) = mean(masked_im(card_mask));
    Area = current_card.Area;
    sum_pix = sum(masked_im(card_mask));
    av_pix = sum_pix/Area;

    pix_all =  [pix_all mean_pix(k)];

end 

mean_pix_all = mean(pix_all);
pix_thres = mean_pix_all* 1.4; % Threshold for how much the mean pixel value must be in order for it to be a face up card

for i = 1:amount_cards
    current_card = stats{i};

    if amount_cards == 2
        card_up{up} = current_card;
        up = up + 1;
        card_down = NaN;
    else  
                  
        if mean_pix(i) > pix_thres
            card_up{up} = current_card;
            up = up + 1;
        else
            card_down{down} = current_card;
            down = down + 1;
        end
    end
end
