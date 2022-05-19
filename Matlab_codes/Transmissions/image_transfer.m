clc; clear all;

%% Reading values from the image
% import image
rgb_img = imread('ngc6543a.jpg');   %y = 650;  x =600;
%rgb_img = imread('satya.jpg');     %y = 1536; x =2048;

% get the size
[y x d] = size(rgb_img);

figure;
image(rgb_img); % Display the RGB image
red(:,:)=rgb_img(:,:,1); % extracted integers for red color
blue(:,:)=rgb_img(:,:,2); % extracted integers for blue color
green(:,:)=rgb_img(:,:,3); % extracted integers for green color

%%  Conversion of integers to bits
red_int_to_bits=(de2bi(red));
blue_int_to_bits=(de2bi(blue));
green_int_to_bits=(de2bi(green));


%%  binary symmetric channel that flips the bits with a given probability --------------------------------------------

probability_of_flipping=0.1; 
generate_uniform_random_numbers=rand(size(red_int_to_bits));
bits_flipped=find(generate_uniform_random_numbers<probability_of_flipping);


%% flipping bits and conve for each color 
red_int_to_bits(bits_flipped)=~red_int_to_bits(bits_flipped);
blue_int_to_bits(bits_flipped)=~blue_int_to_bits(bits_flipped);
green_int_to_bits(bits_flipped)=~green_int_to_bits(bits_flipped);


%% Convert the flipped bits back to integers
red_back_to_integers=bi2de(red_int_to_bits);
blue_back_to_integers=bi2de(blue_int_to_bits);
green_back_to_integers=bi2de(green_int_to_bits);

%% Reshaping them back to the 650 x 600 matrix if using ngc6543a.jpg
%% Reshaping them back to the 1536 x 2048 matrix if using satya.jpg

red_recovered(:,:)=reshape(red_back_to_integers,    y, x);
blue_recovered(:,:)=reshape(blue_back_to_integers,  y, x);
green_recovered(:,:)=reshape(green_back_to_integers,y, x);

%% Mapping back the integers to image 
image_recovered=[red_recovered blue_recovered green_recovered];
image_recovered=reshape(image_recovered,[y,x d]);
figure;
image(image_recovered);
