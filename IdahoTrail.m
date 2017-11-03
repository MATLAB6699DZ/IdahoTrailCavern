clear
clc
warning('off','all'); % turns off all warning messages


load Adventure

running = 1;
posX = 1;
posY = 1;
World{1,1}= Player;
imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);
%Its a for loop right now, not sure what we will all do yet  for the loop so I put a for to test it.
for k= 1:4
h = figure(1);
waitforbuttonpress;
switch get(h, 'CurrentKey')
    case 'rightarrow'
        World{posX,posY} = Blank;
        posY = posY + 1;
        World{posX,posY} = Player;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);
    case 'downarrow'
        World{posX,posY} = Blank;
        posX = posX + 1;
        World{posX,posY} = Player;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);
    case 'uparrow'
        World{posX,posY} = Blank;
        posX = posX - 1;
        World{posX,posY} = Player;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);
    case 'leftarrow'
        World{posX,posY} = Blank;
        posY = posY - 1;
        World{posX,posY} = Player;
        imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);
    
    
    
end
end
% <- arrow


    %ESCAPE to end game/return to home menu
    
    
    %move enemies
    imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);


