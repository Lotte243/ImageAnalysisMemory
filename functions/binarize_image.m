function binary_im = binarize_image(image)
% This function will turn a normal image into a binary image so boundary
% boxes can be placed over the cards
      
% look at only the blue output of the image, since the backs of the cards are red with
% yellow, this will give a high contrast between the cards and the table
im = rgb2gray(image); 

% Turn the image into a binary image
BW = imbinarize(im);

% Fill the wholes in the binary image, so most of the card is covered with
% a binary mask
binary_im = imfill(BW,'holes');