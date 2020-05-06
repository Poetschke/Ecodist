function [Names]=UINames(N_create)
%GUI to choose files containing rock- and lab-parameters and the geometry.
%Input is vector with 4 entries: 1=geometry, 2=lab, 3=rock, 4=lab results
% For example: [1 0 1 0] will open choose options for geometry and rock param

% create dialog field
d = dialog('Position',[300 300 250 500],'Name','File Names');
e = dir;
fn = {e.name};

% ========= according to number create GUI ==============================
if isempty(fn)
    disp('No file found');
    return
end

if N_create(1)==1
     
    % file containig geometry data
    uicontrol('Parent',d,...
       'Style','text',...
       'Position',[20 430 210 40],...
       'String','Geometry Input file');

    uicontrol('Parent',d,...
        'Style','popup',...
        'Position',[75 420 100 25],...
        'String',fn,...
        'Callback',@popup_callback1);
    choice1='';
else
    choice1='';
end

if N_create(2)==1

    % file containing experimental parameters
    uicontrol('Parent',d,...
       'Style','text',...
       'Position',[20 330 210 40],...
       'String','Shear test parameter file');

    uicontrol('Parent',d,...
        'Style','popup',...
        'Position',[75 320 100 25],...
        'String',fn,...
        'Callback',@popup_callback2); 
    choice2='';
else
    choice2='';
end

if N_create(3)==1
    % file containing rock parameters
    uicontrol('Parent',d,...
       'Style','text',...
       'Position',[20 230 210 40],...
       'String','Rock parameter file');

    uicontrol('Parent',d,...
        'Style','popup',...
        'Position',[75 220 100 25],...
        'String',fn,...
        'Callback',@popup_callback3);
    choice3='';
else
    choice3='';
end

if N_create(4)==1
    % file containing rock parameters
    uicontrol('Parent',d,...
       'Style','text',...
       'Position',[20 130 210 40],...
       'String','Lab result file');

    uicontrol('Parent',d,...
        'Style','popup',...
        'Position',[75 120 100 25],...
        'String',fn,...
        'Callback',@popup_callback4);
    choice4='';
else
    choice4='';
end

% button to confirm choice
uicontrol('Parent',d,...
    'Position',[89 50 70 25],...
    'String','Done',...
    'Callback',@button_callback);

% button to go back
uicontrol('Parent',d,...
    'Position',[69 10 100 25],...
    'String','Back to Ecodist',...
    'Callback',@button_callback2);

% waiting for user input 
uiwait(d);
Names={choice1;choice2;choice3;choice4};
 
% ================= callback functions ===================================
function button_callback(~,~)
    delete(gcf);
end

function button_callback2(~,~)
    delete(gcf);
    Ecodist;
end

function popup_callback1(popup,~)
    idx = popup.Value;
    popup_items = popup.String;
    choice1 = char(popup_items(idx,:));
end

function popup_callback2(popup,~)
    idx = popup.Value;
    popup_items = popup.String;
    choice2 = char(popup_items(idx,:));
end

function popup_callback3(popup,~)
    idx = popup.Value;
    popup_items = popup.String;
    choice3 = char(popup_items(idx,:));
end

function popup_callback4(popup,~)
    idx = popup.Value;
    popup_items = popup.String;
    choice4 = char(popup_items(idx,:));
end

end

