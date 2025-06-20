function [score_1,score_2] = players_score(current_player,score_1,score_2)
% This function keeps the score of the 2 players, if there is a match, one
% point is added to the score of the current player.

if current_player == 1
    score_1 = score_1 + 1;
else
    score_2 = score_2 + 1;
end
