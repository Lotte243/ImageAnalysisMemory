function [] = declare_winner(score_1,score_2)

if score_1 > score_2
    disp(['Player 1 won the game with ' num2str(score_1) ' points, congratulations!']);
elseif score_2 > score_1
    disp(['Player 2 won the game with ' num2str(score_2) ' points, congratulations!']);
else
    disp(['It is a draw, both players have ' num2str(score_1) ' points.'])
end