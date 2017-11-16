clc
clear
%Music
[a, fs] = audioread('mudeth - Antibirth- OST - 28 The Hammer of Pompeii (Necropolis).mp3');
song1 = audioplayer(a, fs);
play(song1)

warning('off','all'); % turns off all warning messages

load Adventure
[Char] = Start;

f = figure('Name','Map','MenuBar','none');
Ogre = imread('Ogre_Image.bmp');
Tea = imread('tea.bmp');
Serpent = imread('Serpent_Image.bmp');
Bandit = imread('Bandit_Image.bmp');
Dragon9_9 = imread('dragon_upleft.bmp');
Dragon9_10 = imread('dragon_upright.bmp');
Dragon10_9 = imread('dragon_downleft.bmp');
Dragon10_10 = imread('dragon_downright.bmp');
Door1=4;
%Char= [Level EXP Vitality Strength Dexterity Hero_Health]
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
World{randi(9)+1,randi(9)+1}= Bandit;
World{randi(9)+1,randi(9)+1}= Ogre;
end
World{randi(9)+1,randi(9)+1}= Tea;
World{10,10}=Door;
imshow([World{1,:};World{2,:};World{3,:};World{4,:};World{5,:};World{6,:};World{7,:};World{8,:};World{9,:};World{10,:};]);


while running==1
h = figure(1);
waitforbuttonpress;
switch get(h, 'CurrentKey')
    case 'rightarrow'
        if (posX+1)<=10
        World{posY,posX} = Blank;
        posX = posX + 1;
        end
    case 'downarrow'
        if (posY+1)<=10
        World{posY,posX} = Blank;
        posY = posY + 1;
        end
    case 'uparrow'
        if (posY-1)~=0  
        World{posY,posX} = Blank;
        posY = posY - 1;
        end
    case 'leftarrow'
        if (posX-1)~=0
        World{posY,posX} = Blank;
        posX = posX - 1;
        end
end
if World{posY,posX} == Blank
    World{posY,posX} = Player;
elseif World{posY,posX} == Tea
    if 90+Vitality*10 - 50 >= Hero_Health
        Hero_Health=Hero_Health+50;
    else
        Hero_Health=90+10*Vitality;
    end
    World{posY,posX} = Player;
elseif World{posY,posX} == Bandit
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
    load Adventure
    for k=1:3
        World{randi(9)+1,randi(9)+1}= Bandit;
        World{randi(9)+1,randi(9)+1}= Ogre;
        if k== 3
            World{randi(8)+1,randi(8)+1}=Tea;
        end
    end 
    World{5,5}=Serpent;
    Door1 = imread('Door1.bmp');
    World{1,1}=Door1;
elseif World{posY,posX} == Serpent
    Shield_Metal=1;
    [r] = SerpentBattle(Char,Hero_Health);
    Hero_Health= r;
    EXP=EXP+10;
    World{posY,posX} = Player;
elseif World{posY,posX} == Door1
    load Adventure
      for k=1:4
        World{randi(9)+1,randi(9)+1}= Bandit;
        World{randi(9)+1,randi(9)+1}= Ogre;            
        if k == 4
            World{randi(8)+1,randi(8)+1}= Serpent;
            World{randi(8)+1,randi(8)+1}= Tea;
        end 
    end
    World{9,9}=Dragon9_9;
    World{9,10}=Dragon9_10;
    World{10,9}=Dragon10_9;
    World{10,10}=Dragon10_10;
elseif (World{posY,posX}== Dragon9_9) | (World{posY,posX}== Dragon10_9) | (World{posY,posX}== Dragon9_10)
    pause(song1)
    [A, Fs] = audioread('mudeth - Antibirth- OST - 08 Gloria Filio (Moms Heart).mp3');
    song2 = audioplayer(A, Fs);
    play(song2)
    [r] = DragonBattle(Char,Hero_Health,Shield_Metal);
    Hero_Health=r;
    if Hero_Health > 0
        fprintf('You saved THE Bell Laboratories\n');
        close All
        break
        break
    end
end
if (Hero_Health > -1000) < (Hero_Health <= 0)
    fprintf('Game Over!\n')
    close All
    break
    break
elseif Hero_Health <= 0
    fprintf('You cannot escape from enemies!\n Game Over!\n')
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
pause(song1);
pause(song2);
clear

