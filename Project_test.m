%% TEST SCRIPT FOR MEMORY PROJECT 

clear all
close all
clc

addpath('./functions');
addpath('./Images_mandatory');

%% Load the images
images = load_images(); 

%% Set-up game 
% At the start of the game, an image with all of the memory cards turned
% down is shown and bounding boxes are drawn around them.

img_n = 1;              % Start with the first image
image = images{img_n};  
binary_im = binarize_image(image);  % Make a binary image of the first image
[rec] = create_boundary_box(binary_im,image);    % Create boundary boxes

figure; 
imagesc(image);
hold on
for i = 1:length(rec)
    pos = rec(i).Position;
    rectangle('Position',pos,'EdgeColor','b','LineWidth',2);
end

disp('Player 1, please choose two cards to turn')

%% Playing game 
% Now the game is being played and it starts with player 1 picking 2 cards
% to turn face up

% Initializing the current player and the scores of player one and 2
current_player = 1;
score_1 = 0;
score_2 = 0;

for n = 2:length(images)
    box = [];
    card_up = [];
    card_down = [];

    image = images{n};
    % 
    % if n == 2 
    %     [width_incr,height_incr] = size_face_up_cards(image);
    % end

    binary_im = binarize_image(image);  % Make a binary image of the first image
    box = create_boundary_box(binary_im,image);     % Create all of the boundary boxes

    % See which cards are face up
    [card_up,card_down] = card_up_or_down(box, image);

    % See from the face up cards if they are matching
    match = matching_cards(card_up,image);

    % if there is a match, increase the score
    if match == 1
        [score_1,score_2] = players_score(current_player,score_1,score_2);

        figure;
        imagesc(image)
        hold on
        for r = 1:2
            pos = card_up(r).Position;
            rectangle('Position',pos,'EdgeColor','g','LineWidth',2);
        end
        hold off
    else
        figure;
        imagesc(image)
        hold on
        for r = 1:2
            pos = card_up(r).Position;
            rectangle('Position',pos,'EdgeColor','r','LineWidth',2);
        end
        hold off
    end

    % Determine whether the current player is switched or not 
    current_player = player_turn(match, current_player);
    

end

declare_winner(score_1,score_2);
