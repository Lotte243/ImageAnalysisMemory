function images = load_images_advanced()


img_names = {'Img_1.jpg', 'Img_2.jpg', 'Img_3.jpg', 'Img_4.jpg', 'Img_5.jpg'...
    'Img_6.jpg', 'Img_7.jpg','Img_8.jpg', 'Img_9.jpg', 'Img_10.jpg', 'Img_11.jpg',...
    'Img_12.jpg', 'Img_13.jpg', 'Img_14.jpg', 'Img_15.jpg'};

images = {};
for i = 1:15

    img = img_names{i};
    images{i} = imread(img);

end