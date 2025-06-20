function [width_incr, height_incr] = size_face_up_cards(image)
% This function calculates by how much the face up cards are larger than
% the face down cards so then the boxes of all of the face down cards can
% be increased by this percentage to make them fit around the whole card
% and not just the image.

binary_im = binarize_image(image);
stats = regionprops(binary_im,'Boundingbox','Area');

areas_down = [];
areas_up = [];
widths_down = [];
widths_up = [];
heights_down = [];
heights_up = [];
for j = 1:length(stats)
  
    if stats(j).Area >35000
        area_down = stats(j).Area;
        areas_down = [areas_down area_down];
        width_down = stats(j).BoundingBox(3);
        widths_down = [widths_down width_down];
        height_down = stats(j).BoundingBox(4);
        heights_down = [heights_down height_down];
    elseif stats(j).Area > 2000 && stats(j).Area <35000
        area_up = stats(j).Area;
        areas_up = [areas_up area_up];
        width_up = stats(j).BoundingBox(3);
        widths_up = [widths_up width_up];
        height_up = stats(j).BoundingBox(4);
        heights_up = [heights_up height_up];
    end
end
mean_area_down = mean(areas_down);
mean_area_up = mean(areas_up);
mean_width_down = mean(widths_down);
mean_width_up = mean(widths_up);
mean_height_down = mean(heights_down);
mean_height_up = mean(heights_up);

growth_per = mean_area_down/mean_area_up;
width_incr = mean_width_down/mean_width_up;
height_incr = mean_height_down/mean_height_up;