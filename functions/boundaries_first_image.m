function [] = boundaries_first_image(binary_im,image)
% This function draws boundaries around the first image of the cards where
% all of the cards are placed face down.

[B,L,n] = bwboundaries(binary_im,'noholes');        % Find the boundaries of the cards


m = 1;
h = 1;
for k = 1:n
    b = B{k};
% Only save the boundaries that are actually around the cards by making sure 
% the list of boundary points has a minimum length
    if length(b) > 400                              
        boun{m} = b;
        m = m + 1;
       
    end
end

% Create the figure with the boundaries around it
figure;
imshow(image);
hold on
for h = 1:length(boun)
    boundary = boun{h};
    plot(boundary(:,2),boundary(:,1),'b','LineWidth',2)

end

% Tell player one to start the game
disp('Player 1, please choose two cards to turn')

