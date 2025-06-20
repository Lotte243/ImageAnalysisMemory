function  [rec] = create_boundary_box(binary_image,normal_image)
% This function will place boundary boxes over the cards using a binary
% image of the cards

% Find the postion of the boundary boxes and their area
stats = regionprops(binary_image,'Boundingbox','Area');

% Calculate the average area of the cards
areas = [];
widths = [];
heights = [];
n_boxes = length(stats);
n_down = 0;

n = 1;

figure; 
imagesc(normal_image);
hold on 
% Run through all of the boxes 

for i = 1:n_boxes
    
    % Only take the areas that are larger than 30000 pixels, since sometimes
    % there are some small binary islands not seen as background
        if stats(i).Area > 30000 
        % Create the bounding box by drawing a rectangle using the corners
        % found with regionprops
        rec(n) = rectangle('Position',[stats(i).BoundingBox(1),stats(i).BoundingBox(2),...
            stats(i).BoundingBox(3),stats(i).BoundingBox(4)],'EdgeColor','b','LineWidth',2);
        n = n + 1;

       end 
  
    
hold off

end