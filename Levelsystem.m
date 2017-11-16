function [Char] = Levelsystem(Char)
    l = figure('Visible','off','MenuBar','none');
    %Char= [Level EXP Vitality Strength Dexterity Hero_Health]
    %Char=[3 0 1 1 3 100];
    Level=Char(1);
    EXP=Char(2);
    Vitality=Char(3);
    Strength=Char(4);
    Dexterity=Char(5);
    
    
    txt = uicontrol('Style','text',...
        'Position',[50 300 450 80],...
        'FontName','Poor Richard',...
        'FontSize',15,...
        'String','You have leveled up!  Please pick an attribute to level up. You have also been fully healed');
    

    Vital = uicontrol('Style', 'pushbutton', 'String', 'Vitality +1',...
        'Position', [237 210 75 30],...
        'FontName','Poor Richard',...
        'FontSize',12,...
        'Callback', @Vitality1);       
    Stren = uicontrol('Style', 'pushbutton', 'String', 'Strength +1',...
        'Position', [237 170 75 30],...
        'FontName','Poor Richard',...
        'FontSize',12,...
        'Callback', @Strength1);
    Dext = uicontrol('Style', 'pushbutton', 'String', 'Dexterity +1',...
        'Position', [237 130 75 30],...
        'FontName','Poor Richard',...
        'FontSize',12,...
        'Callback', @Dexterity1);
    
    Perk = uicontrol('Style','text',...
        'Position',[50 30 450 80],...
        'FontName','Poor Richard',...
        'FontSize',15,'Visible','off',...
        'String','');
    
    Perk1 = uicontrol('Style','text',...
        'Position',[0 250 200 20],...
        'FontName','Poor Richard',...
        'FontSize',12,...
        'String','Current Perks:');
    Perk2 = uicontrol('Style','text',...
        'Position',[0 230 200 20],...
        'FontName','Poor Richard',...
        'FontSize',12,'Visible','off',...
        'String','Regen');
    Perk3 = uicontrol('Style','text',...
        'Position',[0 210 200 20],...
        'FontName','Poor Richard',...
        'FontSize',12,'Visible','off',...
        'String','Critical Strike');
    Perk4 = uicontrol('Style','text',...
        'Position',[0 190 200 20],...
        'FontName','Poor Richard',...
        'FontSize',12,'Visible','off',...
        'String','Dodge Counter');
					
    % Add a text uicontrol to label the slider.

    
    % Make figure visble after adding all components
    l.Visible = 'on';
    
    if Vitality >= 3
        Perk2.Visible='on';
    end
    if Strength >= 3
        Perk3.Visible='on';
    end
    if Dexterity >= 3
        Perk4.Visible='on';
    end
    
    function [V] = Vitality1(~,~)
        Vitality = Vitality + 1;
        V=Vitality;
        if Vitality == 3
            Perk.String='You have the perk, Regen! After each battle you heal 10 Health!';
            Perk.Visible='on';
            pause(3)
        end
        delete(l)

    end
function [S]= Strength1(~,~)
        Strength = Strength + 1;
        S=Strength;
        if Strength == 3
            Perk.String='You have gained the perk, Critical Strike! Each Attack has a small chance of doing double damage.';
            Perk.Visible='on';
            pause(3)
        end
        delete(l)
end
function [D] = Dexterity1(~,~)
        Dexterity = Dexterity + 1;
        D=Dexterity;
        if Dexterity == 3
            Perk.String='You have gained the perk, Dodge Counter! Each dodge deals some damage as a counter';
            Perk.Visible='on';
            pause(3)
        end
        delete(l)
end

%     function surfzlim(source,event)
%         val = 51 - source.Value;
%         % For R2014a and earlier:
%         % val = 51 - get(source,'Value');
% 
%         zlim(ax,[-val val]);
%     end
waitfor(l)
Char= [Level EXP Vitality Strength Dexterity];

end