%% Project advanced test
% This script is to test the advanced part of the project

clear all
close all
clc

warning off
addpath('./functions');
addpath('./Images_advanced');

%% Load images

images = load_images_advanced(); 

img_n = 1;              % Start with the first image
image = images{img_n};  
im = rgb2gray(image); 

% Turn the image into a binary image
binary_im = binarize_image(image);

% Create regions around the cards
stats = regionprops(binary_im,'Boundingbox','Area','Centroid', 'Orientation');

% Draw boundaries around the cards in the first image
boundaries_first_image(binary_im,image);




%% To play the game 
% To play the game, first create with region props squares around the cards
% like before to extract them. Then look if they are face up or face down
% with percentage of yellow in the images. If they are face up do SIFT
% description and use BWbounderies on only that part to create the
% boundaries around the card, so the boundaries have the shape of the
% cards.

% Initialize the scores and the players
current_player = 1;
score_1 = 0;
score_2 = 0;

for n = 2:length(images)
    % Initialize the variables
    box = [];
    card_up = [];
    card_down = [];
    matches_up = [];
    box_c = [];

    % Take the current image
    image = images{n};

    % Create a binary image of the image
    binary_im = binarize_image(image);  

    % create bounding boxes around cards
    stats_c = regionprops(binary_im,'Boundingbox','Area','Centroid', 'Orientation');

    % Take only bounding boxes around the cards it self by checking that
    % area is large enough to be around a card
    c = 1;
    for i = 1:length(stats_c)
        if stats_c(i).Area > 10000
            box_c{c} = stats_c(i);
            c = c + 1;
        end 
    end 

    % Create masks over the cards in the bounding box
    stats_mask = create_mask_card(box_c, binary_im);

    % See which cards are up and which are down
    [card_up,card_down] = card_up_or_down_advaned(stats_mask, image);

    % Check if the cards are a match by looking at the amount of matching
    % SIFT features
    match = matching_cards_advanced(card_up,image);


    % Create boundaries around the face-up cards, the color depends on
    % whether or not they are a matching pair
    create_boundary_advanced(card_up,image,binary_im,match)

    % If there is a match, increase the score of the current player 
    if match == 1
        [score_1,score_2] = players_score(current_player,score_1,score_2);
    end

    % Determine whether the current player is switched or not 
    current_player = player_turn(match, current_player);


end
declare_winner(score_1,score_2);
