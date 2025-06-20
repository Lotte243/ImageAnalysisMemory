function [player] = player_turn(match, current_player)
% This function keeps track of whos turn it is. If the previously picked
% cards were a match, the current player keeps playing, otherwise, it is
% the turn of the other player


if match == 1
    player = current_player;
    disp('Congratulations! A matching pair. Please pick up your matching card pair and then you may continue')
else
    if current_player == 1
        player = 2;
        disp('No match! Turn the two cards face down again. Player 2 may then continue')
    else
        player = 1;
        disp('No match! Turn the two cards face down again. Player 1 may then continue')
    end
end