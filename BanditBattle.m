function [r] = BanditBattle(Char,Hero_Health,Shield_Metal)
% Fight with bandit
%define variables and initial plot type
f2 = figure('Visible','off','Position',[469,325,550,425],...
    'Name','BanditBattle','MenuBar','none');
ax = axes('Units','pixels','Position',[35,110,500,300]);
Level=Char(1);
Vitality=Char(3);
Strength=Char(4);
Dexterity=Char(5);
Hero_Atk_DMG=1+Strength;
Bandit_Stun=0;
Dodge_Chance=0.75+0.03*Dexterity;
Sword_Atk_DMG=Hero_Atk_DMG+15*(Strength*0.10+1);
Sheild_Block=randi(10)*.01+0.90;
Bandit_Health=90+randi(20)*Level;
Bandit_Atk=8+randi(3)*Level;
turn=1;
x(turn)=turn;
Hero(turn)=Hero_Health;
x1(turn)=turn;
Bandit(turn)=Bandit_Health;
stairs(x,Hero, 'LineWidth', 2)
hold on
stairs(x1,Bandit)
ylim([0 150])
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
    'String','You encounter a blood thirsty Bandit. You sense he is in a rage');
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
    'String',Bandit_Health);
PI = figure('Position',[350,275,84,84],...
    'MenuBar', 'none');
    PI1 = imread('Player.bmp');
    PI1 = imresize(PI1,4);
    imshow(PI1,'Border','tight');
BI = figure('Position',[1050,675,84,84],...
    'MenuBar', 'none');
    BI1 = imread('Bandit_Image.bmp');
    BI1 = imresize(BI1,4);
    imshow(BI1,'Border','tight');
% Make figure visble after adding all components
f2.Visible = 'on';

    function Attack(~,~)
        
        if Bandit_Health > 0
            Bandit_Atk=4+randi(6);
        else
            Bandit_Atk=0;
        end
        if Bandit_Stun==1
            Hero_Health=Hero_Health+Bandit_Atk;
        end
        if Strength >= 3
            Critical=rand();
            if Critical < 0.15
                Bandit_Health = Bandit_Health - Sword_Atk_DMG*2;
            else
                Bandit_Health= Bandit_Health - Sword_Atk_DMG;
            end
        else
            Critical=1;
            Bandit_Health= Bandit_Health - Sword_Atk_DMG;
        end
        if Bandit_Health > 0
            Hero_Health = Hero_Health - Bandit_Atk;
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Bandit(turn)=Bandit_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Bandit)
        txt1.String = Hero_Health;
        txt3.String = Bandit_Health;
        if Bandit_Health > 50
            if Critical < 0.15
                Description.String = "Critical Strike!";
            else
                if Bandit_Stun==1
                    Description.String = 'You strike the stunned bandit!';
                else
                    Description.String = "The two of you exhange blows, He doesn't seem too let up";
                end
                    
            end
        elseif (Bandit_Health <= 15) < (Bandit_Health <= 50)
            if Critical < 0.15
                Description.String = "Critical Strike!";
            else
                Description.String = 'He seems weak!';
            end
        elseif (Bandit_Health <= 0) < (Bandit_Health <= 15)
            if Critical < 0.15
                Description.String = "Critical Strike!";
            else
                Description.String = 'Th bandit coughs up blood';
            end
        else Bandit_Health <= 0;
            Description.String = 'The bandit has died';
            end
        Bandit_Stun=0;
    end
    
    function Dodge(~,~)
      if Bandit_Stun==1
          Description.String = 'You jumped around while the bandit is stunned.';
          Bandit_Stun=0;
      else
        if Bandit_Health > 0
            Bandit_Atk=8+randi(6);
        else
            Bandit_Atk=0;
        end
        Dodge_Barrier=rand();
        if Dodge_Barrier < Dodge_Chance
            if Dexterity >= 3
                Bandit_Health= Bandit_Health - 0.75*Sword_Atk_DMG;
                Description.String = 'Dodge Counter! You dodged and slashed him';
            else
                Bandit_Health;
                Hero_Health;
                Description.String = 'You successfully dodged his slash';
            end
        else
            Hero_Health= Hero_Health - Bandit_Atk;
            Bandit_Health;
            Description.String = 'You were too late! He lands a blow!';
        end
      end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Bandit(turn)=Bandit_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Bandit)
        txt1.String = Hero_Health;
        txt3.String = Bandit_Health;
        if Bandit_Health <= 0
            Description.String = 'The bandit has died';
        end
        Bandit_Stun=0;
    end
    function Block(~,~)
        if Shield_Metal==0
            if Bandit_Health > 0
                Bandit_Atk=8+randi(6);
            else
                Bandit_Atk=0;
            end
            Bandit_Health;
            Hero_Health= Hero_Health - Bandit_Atk*(1-Sheild_Block);
            Description.String = 'You reduce the damage taken by blocking';
        else
            if Bandit_Stun==0
                chance_B=rand();
                if chance_B <= 0.15
                    Description.String = 'You tried bashing too early! Leaving yourself open, the bandit dealt you a punishing blow!';
                    Hero_Health=Hero_Health-20;
                else
                Bandit_Health=Bandit_Health-(3+randi(3));
                Bandit_Stun=1;
                Description.String = 'You bash the bandit with your shield right as he attacked, stunning him';
                end
            else
                Bandit_Stun=0;
                Description.String = 'You stand there with your shield raised as he is stunned';
            end
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Bandit(turn)=Bandit_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Bandit)
        txt1.String = Hero_Health;
        txt3.String = Bandit_Health;
    end
waitfor(f2)
if ishandle(PI)
    close(PI)
end
if ishandle(BI)
    close(BI)
end
if Bandit_Health > 0
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
