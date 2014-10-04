clc;            % necessery clearing 
clear all;      % stuffs
close all;

% Load the original image & Initialization of variables
image = imread('C:\Users\Spider\Desktop\CVPR\MousePicker\images\36.tif');
col=1;
row=1;

% Apply black&white & grain filtering
image = im2bw(image, 0.60);
image = ~(image);
image = bwareaopen(image, 10);

% Get necessery info about image
sizeHW = size(image);
sizeH = sizeHW(1);
sizeW = sizeHW(2);

% a boolean variable
quit = 0;

while ~quit
    % show image on imshow
    imshow(image)

    % wait for two clicks & get the position info
    recorded = ginput(2);   % the recorded click-info
    pos1x = floor(recorded(1,1));  % 1st position - X coordinate
    pos1y = floor(recorded(1,2));  % 1st position - Y coordinate
    pos2x = floor(recorded(2,1));  % 2nd position - X coordinate
    pos2y = floor(recorded(2,2));  % 2nd position - Y coordinate

    % Selected area validity check
    if ((pos2x>pos1x) && (pos2y>pos1y))
        selected = zeros(pos2y - pos1y,pos2x - pos1x);
        col = 1;
        row = 1;
        for rowwise = pos1x:pos2x
            for colwise = pos1y:pos2y
                selected(col,row) = image(colwise,rowwise);
                col = col+1;
            end
            row = row + 1;
            col = 1;
        end
        imshow(selected)
        ask = input('Enter the language : ','s');
        if strcmp(ask,'quit')
            quit = 1;
        else
        % DO SOMETHING FOR STORING THE SELECTED PART
                    

        % DO SOMETHING FOR STORING THE SELECTED PART
        end
        clear selected
    else
        disp('Try to drag from upper-left to lower-bottom');
    end
end