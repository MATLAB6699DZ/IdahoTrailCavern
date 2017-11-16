function [r] = OgreBattle(Char,Hero_Health)
% Fight with ogre
%define variables and initial plot type
f3 = figure('Visible','off','Position',[469,325,550,425],...
    'MenuBar','none');
ax = axes('Units','pixels','Position',[35,110,500,300]);
Level=Char(1);
Vitality=Char(3);
Strength=Char(4);
Dexterity=Char(5);
Ogre_Charge=2;
Hero_Atk_DMG=1+Strength;
Dodge_Chance=0.77+0.03*Dexterity;
Sword_Atk_DMG=Hero_Atk_DMG+12*(Strength*0.10+1);
Sheild_Block=randi(10)*.01;
Ogre_Health=150+randi(20)*Level;
Ogre_Atk=30+randi(6);
turn=1;
x(turn)=turn;
Hero(turn)=Hero_Health;
x1(turn)=turn;
Ogre(turn)=Ogre_Health;
stairs(x,Hero, 'LineWidth', 2)
hold on
stairs(x1,Ogre)
ylim([0 Ogre_Health])
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
    'Position',[150 40 250 40],...
    'FontName','Poor Richard',...
    'FontSize',12,...
    'String','An Ogre has spotted you! Be careful, they hit hard!');
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
    'String',Ogre_Health);
PI = figure('Position',[350,275,84,84],...
    'MenuBar', 'none');
    PI1 = imread('Player.bmp');
    PI1 = imresize(PI1,4);
    imshow(PI1,'Border','tight');
OI = figure('Position',[1050,675,84,84],...
    'MenuBar', 'none');
    OI1 = imread('Ogre_Image.bmp');
    OI1 = imresize(OI1,4);
    imshow(OI1,'Border','tight');
% Make figure visble after adding all components
f3.Visible = 'on';
    function Attack(~,~)
        if Ogre_Health > 0
            Ogre_Atk=30+randi(6);
        else
            Ogre_Atk=0;
        end
        %0 in charge
        if Ogre_Charge == 0
     %Strength check   
            if Strength >= 3
                Critical=rand();
                if Critical < 0.15
                    Ogre_Health = Ogre_Health - Sword_Atk_DMG*2;
                    Ogre_Charge=1;
                else
                %Fail of strength check as if normal..
                Ogre_Charge= Ogre_Charge + (randi(2));
                Ogre_Health= Ogre_Health - Sword_Atk_DMG;
                end
            else
                Critical=1;
                Ogre_Charge= Ogre_Charge + (randi(2));
                Ogre_Health= Ogre_Health - Sword_Atk_DMG;
            end
            %Description
            if Ogre_Charge == 1
                %putting if critical was 0.15 allows skip another strength
                %check
                if Critical < 0.15
                    Description.String = "Critical Strike! The ogre is stunned!";
                else 
                    Description.String = "Your attack made the ogre falter!";
                end
            else
                Description.String = "The ogre is readying an attack";
            end
            %next charge of 1
        elseif Ogre_Charge == 1
            if Strength >= 3
                Critical=rand();
                if Critical < 0.15
                    Ogre_Health = Ogre_Health - Sword_Atk_DMG*2;
                    Ogre_Charge=1;
                    Description.String = "Critical Strike! The ogre is stunned!";
                else
                    Ogre_Swipe=randi(100);
                    if Ogre_Swipe <= 35
                        Hero_Health=Hero_Health-(12 + randi(4));
                        Description.String = "The ogre swipes at you with his hand and readies his club!";
                        Ogre_Charge= 2;
                    else
                        Ogre_Charge = 2;
                        Ogre_Health= Ogre_Health - Sword_Atk_DMG;
                        Description.String = "The ogre is readying an attack";
                    end
                end
            else
                Ogre_Swipe=randi(100)+2*Dexterity;
                if Ogre_Swipe <= 35
                    Hero_Health=Hero_Health-(12 + randi(4));
                    Description.String = "The ogre swipes at you with his hand and readies his club!";
                    Ogre_Charge= 2;
                else
                    Ogre_Charge = 2;
                    Ogre_Health= Ogre_Health - Sword_Atk_DMG;
                    Description.String = "The ogre is readying an attack";
                end
            end
        else
            Hero_Health = Hero_Health - Ogre_Atk;
            Ogre_Charge= 0;
            Description.String = "Your attack was in vain; the ogre's club smashes into you";
            for k= 1:4
            movegui(f3,[489,325])
            pause(1/21)
            movegui(f3,[449,325])
            pause(1/21)
            end
            movegui(f3,[469,325])
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Ogre(turn)=Ogre_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Ogre)
        txt1.String = Hero_Health;
        txt3.String = Ogre_Health;
        if Ogre_Health <= 0
            Description.String = 'The ogre has died';
            
        end
    end

    function Dodge(~,~)
        if Ogre_Health > 0
            Ogre_Atk=30+randi(6);
        else
            Ogre_Atk=0;
        end
        Dodge_Barrier=rand();
        if Ogre_Charge < 2
            Ogre_Charge= 2;
            Ogre_Health;
            Hero_Health;
            Description.String = 'You dodged while the ogre readies his club';
        else
            if Dodge_Barrier < Dodge_Chance
                if Dexterity >= 3
                    Ogre_Health=Ogre_Health-0.75*Sword_Atk_DMG;
                    Description.String = 'Dodge Counter! You adeptly dodged the club and slashed the ogre!';
                    Ogre_Charge= 0;
                else
                    Ogre_Health;
                    Hero_Health;
                    Description.String = 'You narrowly avoid the club smashing into the ground';
                    Ogre_Charge= 0;
                end
            else
                Hero_Health= Hero_Health - Ogre_Atk;
                Ogre_Health;
                Description.String = "Too late! The ogre's club smashes down upon you";
                Ogre_Charge= 0;
                for k= 1:4
                    movegui(f3,[489,325])
                    pause(1/21)
                    movegui(f3,[449,325])
                    pause(1/21)
                end
                movegui(f3,[469,325])
            end
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Ogre(turn)=Ogre_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Ogre)
        txt1.String = Hero_Health;
        txt3.String = Ogre_Health;

    end
    function Block(~,~)
        if Ogre_Health > 0
            Ogre_Atk=25+randi(6);
        else
            Ogre_Atk=0;
        end
        if Ogre_Charge > 2
            Ogre_Charge= 2;
            Description.String = 'You blocked while the ogre readies his club';
        else
            Ogre_Health;
            Hero_Health= Hero_Health - Ogre_Atk*(1-Sheild_Block);
            Description.String = "The ogre's attack was too much, the block did little";
            Ogre_Charge = 0;
            for k= 1:4
                movegui(f3,[489,325])
              
                pause(1/21)
                movegui(f3,[449,325])
                pause(1/21)
            end
            movegui(f3,[469,325])
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Ogre(turn)=Ogre_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Ogre)
        txt1.String = Hero_Health;
    end
waitfor(f3)
if ishandle(PI)
    close(PI)
end
if ishandle(OI)
    close(OI)
end
if Ogre_Health > 0
    Hero_Health=Hero_Health - 1000;
end
if Vitality >= 3
    Hero_Health+10;
    if Hero_Health > 90+Vitality*10
    Hero_Health=90+Vitality*10;
    end
    r=Hero_Health;
else
    r=Hero_Health;
end
end
