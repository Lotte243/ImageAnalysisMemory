function [card_up,card_down] = card_up_or_down(rec, img)
% This function determines wether a card is face up or face down by looking
% at the average pixel value of the card. It takes the boundaries of the
% cards earlier determined and then looks at the pixel value of the card
% only look at in the blue channel. Since the backs of the cards are mostly
% yellow, this will not show up through the blue channel and the average
% pixel value will be lower than the front of the cards. 
% By setting a threshold it can then be determined wether the card is
% placed face up or face down. The positions of the face up and the face
% down cards will then be saved.

amount_cards = length(rec);
up = 1;
down = 1;


for k = 1:amount_cards
    pos = rec(k).Position;   % position of the rectangle 
    one_card = imcrop(img,pos);
    one_card_blue = one_card(:,:,3);   % Since there is a lot of yellow on the back, and were looking through only the blue channel, a lot of pixels will have a value of zero
    mean_pix = mean(one_card_blue,'all'); % Find the mean pixel value of the card
    pix_thres = 100;               % Threshold for how much the mean pixel value must be in order for it to be a face up card
    if mean_pix > pix_thres
        card_up(up) = rec(k);
        up = up + 1;
    else
        card_down(down) = rec(k);
        down = down + 1;
    end
end

if down == 1
    card_down = NaN;
end