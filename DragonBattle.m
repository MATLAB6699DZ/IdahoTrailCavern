function [r] = DragonBattle(Char,Hero_Health,Shield_Metal)
% Fight with draon
%define variables and initial plot type
f4 = figure('Visible','off','Position',[469,325,550,425],...
    'MenuBar','none');
ax = axes('Units','pixels','Position',[35,110,500,300]);
Vitality=Char(3);
Strength=Char(4);
Dexterity=Char(5);
Hero_Atk_DMG=1+Strength;
Dodge_Chance=0.75+0.05*Dexterity;
Sword_Atk_DMG=Hero_Atk_DMG+15*(Strength*0.10+1);
Dragon_Health=500;
Dragon_Flame=0;
Dragon_Tail=0;
Dragon_Charge=0;
turn=1;
x(turn)=turn;
Hero(turn)=Hero_Health;
x1(turn)=turn;
Dragon(turn)=Dragon_Health;
stairs(x,Hero, 'LineWidth', 2)
hold on
stairs(x1,Dragon)
ylim([0 400])
% Create push button
btn = uicontrol('Style', 'pushbutton', 'String', 'Attack',...
    'Position', [70 60 50 20],...
    'Callback', @Attack);
% Create push button
btn = uicontrol('Style', 'pushbutton', 'String', 'Dodge',...
    'Position', [70 40 50 20],...
    'Callback', @Dodge);
% Create push button
btn = uicontrol('Style', 'pushbutton', 'String', 'Block',...
    'Position', [70 20 50 20],...
    'Callback', @Block);
% Add a text uicontrol to label.
Action = uicontrol('Style','text',...
    'Position',[20 40 50 20],...
    'String','Action');
Description = uicontrol('Style','text',...
    'Position',[150 20 250 60],...
    'FontName','Poor Richard',...
    'FontSize',12,...
    'String','You have reached the dragon!');
txt = uicontrol('Style','text',...
    'Position',[460 45 40 20],...
    'String','Health:');
txt1 = uicontrol('Style','text',...
    'Position',[500 45 30 20],...
    'String',Hero_Health);
txt2 = uicontrol('Style','text',...
    'Position',[428 65 72 20],...
    'String','Enemy Health:');
txt3 = uicontrol('Style','text',...
    'Position',[500 65 30 20],...
    'String',Dragon_Health);

% Make figure visble after adding all components
f4.Visible = 'on';

    function Attack(~,~)
        if (Dragon_Flame==0) && (Dragon_Tail==0) && (Dragon_Charge==0) == 1
            switch randi(4)
                case 1 %Dragon_Fireballs
                    DMG_Check=Hero_Health;
                    Fire1 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    Fire = imread('Fireball.png');
                    Fire= imresize(Fire, 0.25);
                    imshow(Fire,'Border','tight');
                    Fire2 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire3 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire4 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire5 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    tic
                    while ishandle(Fire1) || ishandle(Fire2) || ishandle(Fire3) || ishandle(Fire4) || ishandle(Fire5)
                        Fire_Time=toc;
                        if Fire_Time > 5.5
                            if ishandle(Fire1)
                                Hero_Health= Hero_Health - (25+randi(4)-Vitality);
                            end
                            if ishandle(Fire2)
                                Hero_Health= Hero_Health - (25+randi(4)-Vitality);
                            end
                            if ishandle(Fire3)
                                Hero_Health= Hero_Health - (25+randi(4)-Vitality);
                            end
                            if ishandle(Fire4)
                                Hero_Health= Hero_Health - (25+randi(4)-Vitality);
                            end
                            if ishandle(Fire5)
                                Hero_Health= Hero_Health - (25+randi(4)-Vitality);
                            end
                            close('Fireball')
                        end
                        pause(0.5) 
                    end    
                    DMG_Check= DMG_Check - Hero_Health; 
                    if DMG_Check == 0
                        Dragon_Health=Dragon_Health - Sword_Atk_DMG;
                        Description.String = 'You avoided all fireballs and slashed the dragon!';
                    else
                        Description.String = "The dragon's fireballs hit with the force of an ogre";
                    end
                case 2 %Dragon Flame strike, charge of 3
                    Dragon_Flame = 1;
                    Dragon_Health=Dragon_Health - Sword_Atk_DMG;
                    Description.String = 'You slash the dragon and hear a growing rumble';
                case 3 %Dragon tail that player can dodge, cannot attack while doing it
                    Dragon_Tail = 1;
                    Dragon_Health=Dragon_Health-Sword_Atk_DMG;
                    Description.String = 'Right as you strike with your sword, the dragon rears its tail';
                case 4
                    Dragon_Charge = 1;
                    Description.String = 'The dragon takes flight!';
            end
        elseif Dragon_Flame == 1
            Dragon_Flame = 2;
            Dragon_Health=Dragon_Health - Sword_Atk_DMG;
            Description.String = "The dragon's mouth is glowing";
        elseif Dragon_Flame == 2
            Dragon_Flame = 3;
            Dragon_Health=Dragon_Health - Sword_Atk_DMG;
            Description.String = "The whole area is shaking!";
        elseif Dragon_Flame == 3
            Dragon_Flame_Atk = 100 + randi(25) - Vitality*7;
            Hero_Health= Hero_Health - Dragon_Flame_Atk;
            Dragon_Flame=0;
            if Hero_Health <= 0
                Description.String = "You were burnt to a crisp";
            else
                Description.String = 'Somehow, you survived';
            end
        elseif Dragon_Tail == 1
            Hero_Health= Hero_Health - (23+randi(4));
            Description.String = 'You greedily go for another attack only to be swatted away like a fly';
            Dragon_Tail=0;
        elseif Dragon_Charge == 1
            Dragon_Charge = 2;
            Description.FontSize= 8;
            Description.String = 'You are scared';
        elseif Dragon_Charge == 2
            Dragon_Charge=0;
            Hero_Health=Hero_Health-(45-Dexterity*5);
            Description.FontSize=12;
            Description.String = 'You attempt to strike the dragon as it dives at you! But it picked you up and threw you down';    
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Dragon(turn)=Dragon_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Dragon)
        txt1.String = Hero_Health;
        txt3.String = Dragon_Health;
        if Dragon_Health <= 0
           Description.String = 'The dragon has died';
           
            
        end
    end

    function Dodge(~,~)
       if (Dragon_Flame==0) && (Dragon_Tail==0) && (Dragon_Charge==0) == 1
           switch randi(3)
                case 1 %Dragon_Fireballs
                    DMG_Check=Hero_Health;
                    Fire1 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    Fire = imread('Fireball.png');
                    Fire= imresize(Fire, 0.25);
                    imshow(Fire,'Border','tight');
                    Fire2 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire3 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire4 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire5 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    tic
                    while ishandle(Fire1) || ishandle(Fire2) || ishandle(Fire3) || ishandle(Fire4) || ishandle(Fire5)
                        Fire_Time=toc;
                        if Fire_Time > 5.5
                            if ishandle(Fire1)
                                Hero_Health= Hero_Health - (18+randi(4));
                            end
                            if ishandle(Fire2)
                                Hero_Health= Hero_Health - (18+randi(4));
                            end
                            if ishandle(Fire3)
                                Hero_Health= Hero_Health - (18+randi(4));
                            end
                            if ishandle(Fire4)
                                Hero_Health= Hero_Health - (18+randi(4));
                            end
                            if ishandle(Fire5)
                                Hero_Health= Hero_Health - (18+randi(4));
                            end
                            close('Fireball')
                        end
                        pause(0.5) 
                    end    
                    DMG_Check= DMG_Check - Hero_Health; 
                    if DMG_Check == 0
                        Dragon_Health=Dragon_Health - Sword_Atk_DMG;
                        Description.String = 'You avoided all fireballs!';
                    else
                        Description.String = "The dragon's fireballs hit with the force of an ogre";
                    end
                case 2 %Dragon Flame strike, charge of 3
                    Description.String = 'You swear you hear the dragon laugh at the fact you are dodging from nothing';
                case 3 %Dragon tail that player can dodge, cannot attack while doing it
                    Hero_Health=Hero_Health-5;
                    Description.String = 'The dragon sees you dodging and flicks you in arrogance; how rude'; 
           end
       elseif Dragon_Flame == 1
            Dragon_Flame = 2;
            Description.String = "The dragon's mouth is glowing, and you are dodging like a fool";
        elseif Dragon_Flame == 2
            Dragon_Flame = 3;
            Description.String = "The whole area is shaking, and you are leaping around like a fool!";
        elseif Dragon_Flame == 3
            Dragon_Flame_Atk = 100 + randi(25)-Vitality*5;
            Hero_Health= Hero_Health - Dragon_Flame_Atk;
            Dragon_Flame=0;
            if Hero_Health <= 0
                Description.String = "You were burnt to a crisp";
            else
                Description.String = 'Somehow, you survived';
            end
        elseif Dragon_Tail == 1
            Dodge_Barrier=rand();
            if Dodge_Barrier < Dodge_Chance
                if Dexterity >= 3
                    Dragon_Health= Dragon_Health - 0.75*Sword_Atk_DMG;
                    Description.String = 'Dodge Counter! You leap over and slash the tail as it sweeps';
                else
                    Dragon_Health;
                    Hero_Health;
                    Description.String = 'You barely avoided the sweeping tail';
                end
            else
                Hero_Health= Hero_Health - (18+randi(4));
                Dragon_Health;
                Description.String = 'You were too slow! The tail swatted you away!';
            end
            Dragon_Tail=0;
       elseif Dragon_Charge == 1
           Dragon_Charge = 2;
           Description.FontSize= 8;
           Description.String = 'You are scared';
       elseif Dragon_Charge == 2
           Dodge_Barrier=rand();
            if Dodge_Barrier < Dodge_Chance
                if Dexterity >= 3
                    Dragon_Charge=0;
                    Hero_Health=Hero_Health-(11-Dexterity);
                    Description.FontSize=12;
                    Dragon_Health= Dragon_Health - 0.75*Sword_Atk_DMG;
                    Description.String = 'Dodge Counter! You dodge and slash the dragon as it flies by, it seems the dragon stil got you';
                else
                    Dragon_Charge=0;
                    Hero_Health=Hero_Health-(11-Dexterity);
                    Description.FontSize=12;
                    Description.String = 'You attempt to dodge, but the dragon manages to slash at you with its claws';
                end
            else
                Dragon_Charge=0;
                Hero_Health=Hero_Health-(45-Dexterity*5);
                Description.FontSize=12;
                Description.String = 'You attempt to dodge the dragon as it dives at you! But the dragon picked you up and threw you down';
            end
       end
    

        
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Dragon(turn)=Dragon_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Dragon)
        txt1.String = Hero_Health;
    end
    function Block(~,~)
        if (Dragon_Flame==0) && (Dragon_Tail==0) && (Dragon_Charge==0) == 1
           switch randi(3)
                case 1 %Dragon_Fireballs
                    DMG_Check=Hero_Health;
                    Fire1 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    Fire = imread('Fireball.png');
                    Fire= imresize(Fire, 0.25);
                    imshow(Fire,'Border','tight');
                    Fire2 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire3 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire4 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    Fire5 = figure('Position',[rand()*1300,rand()*650,5,2],...
                        'Name','Fireball');
                    imshow(Fire,'Border','tight');
                    tic
                    while ishandle(Fire1) || ishandle(Fire2) || ishandle(Fire3) || ishandle(Fire4) || ishandle(Fire5)
                        Fire_Time=toc;
                        if Fire_Time > 5.5
                            if Shield_Metal == 1
                                if ishandle(Fire1)
                                    Hero_Health= Hero_Health - (5+randi(4));
                                end
                                if ishandle(Fire2)
                                    Hero_Health= Hero_Health - (5+randi(4));
                                end
                                if ishandle(Fire3)
                                    Hero_Health= Hero_Health - (5+randi(4));
                                end
                                if ishandle(Fire4)
                                    Hero_Health= Hero_Health - (5+randi(4));
                                end
                                if ishandle(Fire5)
                                    Hero_Health= Hero_Health - (5+randi(4));
                                end
                            else
                                if ishandle(Fire1)
                                    Hero_Health= Hero_Health - (18+randi(4));
                                end
                                if ishandle(Fire2)
                                    Hero_Health= Hero_Health - (18+randi(4));
                                end
                                if ishandle(Fire3)
                                    Hero_Health= Hero_Health - (18+randi(4));
                                end
                                if ishandle(Fire4)
                                    Hero_Health= Hero_Health - (18+randi(4));
                                end
                                if ishandle(Fire5)
                                    Hero_Health= Hero_Health - (18+randi(4));
                                end
                            end
                            close('Fireball')
                        end
                        pause(0.5) 
                    end    
                    DMG_Check= DMG_Check - Hero_Health; 
                    if DMG_Check == 0
                        Description.String = 'You avoided all the fireballs!';
                    else
                        if Shield_Metal == 1
                            Description.String = "The dragon's fireballs hit your metal shield, reduced damage";
                        else
                            Description.String = "The dragon's fireballs hit with the force of an ogre";
                        end
                    end
                case 2 %Dragon Flame strike, charge of 3
                    Description.String = 'You swear you hear the dragon laugh at the fact you are dodging from nothing';
                case 3 %Dragon tail that player can dodge, cannot attack while doing it
                    Description.String = 'block while nothing'; 
                end
       elseif Dragon_Flame == 1
            Dragon_Flame = 2;
            Description.String = "The dragon's mouth is glowing, you ready your shield quite early";
        elseif Dragon_Flame == 2
            Dragon_Flame = 3;
            Description.String = "The whole area is shaking, and you ready your shield early!";
        elseif Dragon_Flame == 3
            if Shield_Metal == 1
                DMG_Check_Flame=Hero_Health;
                Flame = imread('Heat.png');
                Flame= imresize(Flame, 0.5);
                Flame3=1;
                tic
                Flame1 = figure('Position',[650,425,5,2],...
                    'Name','Breath','Visible','off');
                imshow(Flame,'Border','tight');
                while ishandle(Flame1)
                    Flame_Time=toc;
                    if Flame3==1
                        for k=1:randi(5)+25
                            if k==1
                                Flame3=2;
                                Flame1.Visible='on';
                            end
                            Flame2 = figure('Position',[600,450,5,30],...
                                'Name','Breath','Visible','on');
                            txt= uicontrol('Style','text','String','Flame',...
                                'Position',[30,12,40,10]);
                        end
                    end
                    if Flame_Time > 7
                        Dragon_Flame_Atk = 35 + randi(10);
                        Hero_Health=Hero_Health-Dragon_Flame_Atk;
                        close('Breath')
                    end
                    pause(0.5)
                end
                DMG_Check_Flame=DMG_Check_Flame-Hero_Health;
                if DMG_Check_Flame==0
                    Description.String='Incredible! You mustered through the fire!';
                else
                    if Hero_Health <= 0
                        Description.String = "You were burnt to a crisp";
                    else
                        Description.String = 'You blocked what you could but the flames were too much';
                    end
                end
            else
                Dragon_Flame_Atk = 100 + randi(25)-Vitality*7;
                Hero_Health= Hero_Health - Dragon_Flame_Atk;
                if Hero_Health <= 0
                        Description.String = "You were burnt to a crisp";
                else
                    Description.String = 'A wooden shield is not too effective against fire';
                end
            end
            Dragon_Flame=0;
        elseif Dragon_Tail == 1
            Hero_Health=Hero_Health-(16+randi(5));
            Description.String = 'The force of the tail was too much, and you went flying!';
            Dragon_Tail=0;
       elseif Dragon_Charge == 1
           Dragon_Charge = 2;
           Description.FontSize= 8;
           Description.String = 'You are scared';
       elseif Dragon_Charge == 2
                Dragon_Charge=0;
                Hero_Health=Hero_Health-(45-Dexterity*5);
                Description.FontSize=12;
                Description.String = 'You attempt to block the dragon as it dives at you! But the dragon picked you up and threw you down';
       end
       turn= turn+1;
       x(turn)=turn;
       Hero(turn)=Hero_Health;
       x1(turn)=turn;
       Dragon(turn)=Dragon_Health;
       stairs(x,Hero, 'LineWidth', 3)
       stairs(x1,Dragon)
       txt1.String = Hero_Health;
    end
        
waitfor(f4)
if Dragon_Health > 0
    Hero_Health=Hero_Health - 1000;
end

r= Hero_Health;
end
