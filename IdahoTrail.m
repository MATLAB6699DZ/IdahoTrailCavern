clc
clear
%Music
%mudeth - Antibirth- OST - 15 Machine in the Walls.mp3
%mudeth - Anitbirth- OST - 05 Esc (Arcade).mp3
%mudeth - Antibirth- OST - 20 Subterranean Homesick Malign (Caves).mp3
% [a, fs] = audioread('mudeth - Antibirth- OST - 15 Machine in the Walls.mp3');
% song1 = audioplayer(a, fs);
% play(song1)

warning('off','all'); % turns off all warning messages

load Adventure
f1 = Start;
waitfor(f1)

f = figure('Name','Map');
Player = imread('Player.bmp');
Ogre = imread('Player.bmp');
%Char= [Level EXP Vitality Strength Dexterity Hero_Health]
Char=[1 0 1 1 1];
Level=Char(1);
EXP=Char(2);
Vitality=Char(3);
Strength=Char(4);
Dexterity=Char(5);
Shield_Metal=0;
Hero_Health=90+10*Vitality;
running = 1;
posY = 1;
posX = 1;
World{1,1}= Player;
for k=1:3
World{randi(9)+1,randi(9)+1}= Monster;
World{randi(9)+1,randi(9)+1}= Ogre;
end
World{10,10}=Door;
imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);


while running==1
h = figure(1);
waitforbuttonpress;
switch get(h, 'CurrentKey')
    case 'rightarrow'
        World{posY,posX} = Blank;
        posX = posX + 1;
    case 'downarrow'
        World{posY,posX} = Blank;
        posY = posY + 1;
    case 'uparrow'
        World{posY,posX} = Blank;
        posY = posY - 1;
    case 'leftarrow'
        World{posY,posX} = Blank;
        posX = posX - 1;
end
if World{posY,posX} == Blank
    World{posY,posX} = Player;
elseif World{posY,posX} == Monster
    [r] = BanditBattle(Char,Hero_Health,Shield_Metal);
    Hero_Health=r;
    World{posY,posX} = Player;
    EXP=EXP + 1;
elseif World{posY,posX} == Ogre
    [d] = OgreBattle(Char,Hero_Health);
    Hero_Health= d;
    EXP=EXP+3;
    World{posY,posX} = Player;
elseif World{posY,posX} == Door
    if Shield_Metal==0
        
    load Adventure
    Player = imread('Player.bmp');
    Ogre = imread('Player.bmp');
    for k=1:3
        World{randi(8)+1,randi(8)+1}= Monster;
        World{randi(8)+1,randi(8)+1}= Ogre;
    end
    World{5,5}=Shield;
    Door1 = imread('Door1.bmp');
    World{1,1}=Door1;
    end
elseif World{posY,posX} == Shield
    Shield_Metal=1;
    World{posY,posX} = Player;
elseif World{posY,posX} == Door1
    load Adventure
    Player = imread('Player.bmp');
    Ogre = imread('Player.bmp');
    Dragon = imread('Genivious.bmp');
    for k=1:3
        World{randi(8)+1,randi(8)+1}= Monster;
        World{randi(8)+1,randi(8)+1}= Ogre;
    end 
    World{10,10}=Dragon;
elseif World{posY,posY}==Dragon
    [r] = DragonBattle(Char,Hero_Health,Shield_Metal);
    
end
if Hero_Health < -500
    fprintf('You cannot escape from enemies!\n Game Over!\n')
    close All
    break
    break
elseif Hero_Health <= 0
    fprintf('Game Over!\n')
    close All
    break
    break
end
World{posY,posX} = Player;
imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);
    if (EXP >= 15) && (Level == 9)
        %Char= [Level EXP Vitality Strength Dexterity];
        Char(2)=EXP-15;
        Char(1)=10;
        [Char] = Levelsystem(Char);
        Level=Char(1);
        EXP=Char(2);
        Vitality=Char(3);
        Strength=Char(4);
        Dexterity=Char(5);
        Hero_Health=90+10*Vitality;
    elseif (EXP >= 15) && (Level == 7)
        %Char= [Level EXP Vitality Strength Dexterity];
        Char(2)=EXP-15;
        Char(1)=8;
        [Char] = Levelsystem(Char);
        Level=Char(1);
        EXP=Char(2);
        Vitality=Char(3);
        Strength=Char(4);
        Dexterity=Char(5);
        Hero_Health=90+10*Vitality;
    elseif(EXP >= 15) && (Level == 6)
        %Char= [Level EXP Vitality Strength Dexterity];
        Char(2)=EXP-15;
        Char(1)=7;
        [Char] = Levelsystem(Char);
        Level=Char(1);
        EXP=Char(2);
        Vitality=Char(3);
        Strength=Char(4);
        Dexterity=Char(5);
        Hero_Health=90+10*Vitality;
    elseif (EXP >= 12) && (Level == 5)
        Char(2)=EXP-12;
        Char(1)=6;
        [Char] = Levelsystem(Char);
        Level=Char(1);
        EXP=Char(2);
        Vitality=Char(3);
        Strength=Char(4);
        Dexterity=Char(5);
        Hero_Health=90+10*Vitality;
    elseif (EXP >= 9) && (Level == 4)
        Char(2)=EXP-9;
        Char(1)=5;
        [Char] = Levelsystem(Char);
        Level=Char(1);
        EXP=Char(2);
        Vitality=Char(3);
        Strength=Char(4);
        Dexterity=Char(5);
        Hero_Health=90+10*Vitality;
        Char(6)=Hero_Health;
    elseif (EXP >= 6) && (Level == 3)
        Char(2)=EXP-6;
        Char(1)=4;
        [Char] = Levelsystem(Char);
        Level=Char(1);
        EXP=Char(2);
        Vitality=Char(3);
        Strength=Char(4);
        Dexterity=Char(5);
        Hero_Health=90+10*Vitality;
        Char(6)=Hero_Health;
    elseif (EXP >= 3) && (Level == 2)
        Char(2)=EXP-3;
        Char(1)=3;
        [Char] = Levelsystem(Char);
        Level=Char(1);
        EXP=Char(2);
        Vitality=Char(3);
        Strength=Char(4);
        Dexterity=Char(5);
        Hero_Health=90+10*Vitality;
        Char(6)=Hero_Health;
    elseif (EXP >= 2) && (Level == 1)
        Char(2)=EXP-2;
        Char(1)=2;
        [Char] = Levelsystem(Char);
        Level=Char(1);
        EXP=Char(2);
        Vitality=Char(3);
        Strength=Char(4);
        Dexterity=Char(5);
        Hero_Health=90+10*Vitality;
        Char(6)=Hero_Health;
    else
    EXP=EXP;
    end
    end
% pause(song1)
clear

