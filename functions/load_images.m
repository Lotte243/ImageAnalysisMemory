function images = load_images()


img_names = {'Img_1.jpeg', 'Img_2.jpeg', 'Img_3.jpeg', 'Img_4.jpeg', 'Img_5.jpeg'...
    'Img_6.jpeg', 'Img_7.jpeg','Img_8.jpeg', 'Img_9.jpeg', 'Img_10.jpeg', 'Img_11.jpeg',...
    'Img_12.jpeg', 'Img_13.jpeg', 'Img_14.jpeg', 'Img_15.jpeg', 'Img_16.jpeg','Img_17.jpeg','Img_18.jpeg','Img_19.jpeg'};

images = {};
for i = 1:19

    img = img_names{i};
    images{i} = imread(img);

end