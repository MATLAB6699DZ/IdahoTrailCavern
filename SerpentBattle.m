function [r] = SerpentBattle(Char,Hero_Health)
% Fight with Serpent
%define variables and initial plot type
f5 = figure('Visible','off','Position',[469,325,550,425],...
    'MenuBar','none','Color',[0.94 0.94 0.94]);
ax = axes('Units','pixels','Position',[35,110,500,300]);
Vitality=Char(3);
Strength=Char(4);
Dexterity=Char(5);
Serpent_Spit=4;
initiate=1;
Serpent_Dodge=0.75;
Poison=0;
Hero_Atk_DMG=1+Strength;
%Dodge_Chance=0.77+0.03*Dexterity; unused
Sword_Atk_DMG=Hero_Atk_DMG+12*(Strength*0.20+1);
%Sheild_Block=randi(10)*.01; unused
Serpent_Health=250;
turn=1;
x(turn)=turn;
Hero(turn)=Hero_Health;
x1(turn)=turn;
Serpent(turn)=Serpent_Health;
stairs(x,Hero, 'LineWidth', 2)
hold on
stairs(x1,Serpent)
ylim([0 251])
% Create push button
btn_A = uicontrol('Style', 'pushbutton', 'String', 'Attack',...
    'Position', [70 60 50 20],...
    'Callback', @Attack);
% Create push button
btn_D = uicontrol('Style', 'pushbutton', 'String', 'Dodge',...
    'Position', [70 40 50 20],...
    'Callback', @Dodge);
% Create push button
btn_B = uicontrol('Style', 'pushbutton', 'String', 'Block',...
    'Position', [70 20 50 20],...
    'Callback', @Block);
% Add a text uicontrol to label.
Action = uicontrol('Style','text',...
    'Position',[20 40 50 20],...
    'String','Action');
Description = uicontrol('Style','text',...
    'Position',[120 40 300 40],...
    'FontName','Poor Richard',...
    'FontSize',10,...
    'String','A serpent was guarding the shield!');
Description1 = uicontrol('Style','text',...
    'Position',[120 0 300 40],...
    'FontName','Poor Richard',...
    'FontSize',10,...
    'Visible','off',...
    'String','');
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
    'String',Serpent_Health);

PI = figure('Position',[350,275,84,84],...
    'MenuBar', 'none');
    PI1 = imread('Player.bmp');
    PI1 = imresize(PI1,4);
    imshow(PI1,'Border','tight');
SI = figure('Position',[1050,675,84,84],...
    'MenuBar', 'none');
    SI1 = imread('Serpent_Image.bmp');
    SI1 = imresize(SI1,4);
    imshow(SI1,'Border','tight');
f5.Visible = 'on';

    function Attack(~,~)
        if Serpent_Spit < 4
            Serpent_Chance_D=rand();
            if Serpent_Chance_D >= (Serpent_Dodge+0.025*Dexterity)
                Description.String = 'The serpent dodged your attack!';
                Serpent_Spit= Serpent_Spit + randi(4);
            else
                Serpent_Health=Serpent_Health-Sword_Atk_DMG;
                Description.String = 'You slash the serpent';
                Serpent_Spit= Serpent_Spit + randi(4);
            end
        elseif Serpent_Spit>=4
            Serpent_Health=Serpent_Health-Sword_Atk_DMG;
            Description.String = 'You manage to rush the serpent down and strike it, but it poisons you';
            for k=1:3
                f5.Color=[0 0.8 0];
                pause(0.08)
                f5.Color=[0.94 0.94 0.94];
                pause(0.08)
            end
            f5.Color=[0 0.8 0];
            if Poison == 0
                Poison=Poison+10;
                if initiate==1
                    initiate=0;
                    Description1.Visible = 'on';
                end
            else
                Poison=Poison+5;
            end
            Serpent_Spit=0;
        end
        if Poison == 1
            Description1.String = 'The poison has faded';
            f5.Color = [0.94 0.94 0.94];
        elseif (Poison > 1) && (Poison < 5)
            Description1.String = 'The poison starts to fade';
        elseif (Poison >= 5) && (Poison <= 15)
            Description1.String = 'You feel sick';
        elseif Poison > 15
            Description1.String = 'The poison distorts you with macabre sensations!';
        end
        Poison=Poison-1;
        if Poison > 0
            for k=1:3
                f5.Color=[0 0.8 0];
                pause(0.08)
                f5.Color=[0.94 0.94 0.94];
                pause(0.08)
            end
            f5.Color=[0 0.8 0];
            Poison_DMG= Poison-Vitality*2;
            if Poison_DMG <=0
                Poison_DMG=1;
            end
            Hero_Health=Hero_Health-Poison_DMG;
        elseif Poison <= 0
            Poison=0;
            f5.Color=[0.94 0.94 0.94];
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Serpent(turn)=Serpent_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Serpent)
        txt1.String = Hero_Health;
        txt3.String = Serpent_Health;
    end

    function Dodge(~,~)
        if Serpent_Spit < 4
            if Poison > 0
                Description.String = 'The poison must be getting to your head; you dodge randomally';
            else
                Description.String = 'You dodge for no reason';
            end
            Serpent_Spit = Serpent_Spit + randi(2);
        elseif Serpent_Spit >= 4
            Description.String = 'You try dodging, but the serpent predicted it!';
            for k=1:3
                f5.Color=[0 0.8 0];
                pause(0.08)
                f5.Color=[0.94 0.94 0.94];
                pause(0.08)
            end
            f5.Color=[0 0.8 0];
            if Poison == 0
                Poison=Poison+10;
                if initiate==1
                    initiate=0;
                    Description1.Visible = 'on';
                end
            else
                Poison=Poison+5;
                Serpent_Spit=0;
            end
        end
        
        if Poison == 1
            Description1.String = 'The poison has faded';
            f5.Color = [0.94 0.94 0.94];
        elseif (Poison > 1) && (Poison < 5)
            Description1.String = 'The poison starts to fade';
        elseif (Poison >= 5) && (Poison <= 15)
            Description1.String = 'You feel sick';
        elseif Poison > 15
            Description1.String = 'The poison distorts you with macabre sensations!';
        end
        Poison=Poison-1;
        if Poison > 0
            for k=1:3
                f5.Color=[0 0.8 0];
                pause(0.08)
                f5.Color=[0.94 0.94 0.94];
                pause(0.08)
            end
            f5.Color=[0 0.8 0];
            Poison_DMG= Poison-Vitality*2;
            if Poison_DMG <=0
                Poison_DMG=1;
            end
            Hero_Health=Hero_Health-Poison_DMG;
        elseif Poison <= 0
            Poison=0;
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Serpent(turn)=Serpent_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Serpent)
        txt1.String = Hero_Health;
        txt3.String = Serpent_Health;
    end

    function Block(~,~)
        if Serpent_Spit < 4
            if Poison > 0
                Description.String = 'Paranoid, you pull up your shield for no reason';
                Serpent_Spit=Serpent_Spit+1;
            end
        elseif Serpent_Spit>=4
            if initiate == 1
                Description.String = 'The serpent surprised you! You are poisoned!';
                for k=1:3
                    f5.Color=[0 0.8 0];
                    pause(0.08)
                    f5.Color=[0.94 0.94 0.94];
                    pause(0.08)
                end
                f5.Color=[0 0.8 0];
                if Poison == 0
                    Poison=Poison+10;
                    if initiate==1
                        initiate=0;
                        Description1.Visible = 'on';
                    end
                else
                    Poison=Poison+5;
                    Serpent_Spit=0;
                end
            else
                Description.String= ('You block the poison');
                Serpent_Spit=0;
            end
        end
        
        if Poison == 1
            Description1.String = 'The poison has faded';
            f5.Color = [0.94 0.94 0.94];
        elseif (Poison > 1) && (Poison < 5)
            Description1.String = 'The poison starts to fade';
        elseif (Poison >= 5) && (Poison <= 15)
            Description1.String = 'You feel sick';
        elseif Poison > 15
            Description1.String = 'The poison distorts you with macabre sensations!';
        end
        Poison=Poison-1;
        if Poison > 0
            for k=1:2
                f5.Color=[0 0.8 0];
                pause(0.08)
                f5.Color=[0.94 0.94 0.94];
                pause(0.08)
            end
            f5.Color=[0 0.8 0];
            Poison_DMG= Poison-Vitality*2;
            if Poison_DMG <=0
                Poison_DMG=1;
            end
            Hero_Health=Hero_Health-Poison_DMG;
        elseif Poison <= 0
            Poison=0;
        end
        turn= turn+1;
        x(turn)=turn;
        Hero(turn)=Hero_Health;
        x1(turn)=turn;
        Serpent(turn)=Serpent_Health;
        stairs(x,Hero, 'LineWidth', 3)
        stairs(x1,Serpent)
        txt1.String = Hero_Health;
        txt3.String = Serpent_Health;
        
    end
waitfor(f5)
if ishandle(PI)
    close(PI)
end
if ishandle(SI)
    close(SI)
end
if Serpent_Health > 0
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
