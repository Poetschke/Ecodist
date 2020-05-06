function [surface_name,a]=CreateSurfaceFile
%GUI to create a surface file and store it as a matrix. It is possible to create
%an artificial surface or use scan data of a real surface.


% create dialog field
d = dialog('Position',[300 300 250 500],'Name','Create Surface File');

% display a short welcome text
welcome_text=['Choose which kind of a surface you want to create. ',...
    'You can use scan data as input or create artificial surfaces.'];
uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 450 210 40],...
           'String',welcome_text);
       
% question which kind of surface
uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 300 210 40],...
           'String','Kind of surface?');

% radiobutton to choose one option       
hBtnGrp = uibuttongroup('Parent',d,'Position',...
    [0 0.3 1 0.35],'SelectionChangedFcn',@bselection1);
    uicontrol('Style','Radio', 'Parent',hBtnGrp, ...
        'HandleVisibility','off', 'Position',[0 140 250 30], ...
        'String','Surface scan as xyz point cloud');
    uicontrol('Style','Radio', 'Parent',hBtnGrp,...
        'HandleVisibility','off', 'Position',[0 110 250 30],...
        'String','Surface scan as stl file');
    uicontrol('Style','Radio', 'Parent',hBtnGrp, ...
        'HandleVisibility','off', 'Position',[0 80 250 30],...
        'String','Flat surface');
    uicontrol('Style','Radio', 'Parent',hBtnGrp, ...
        'HandleVisibility','off', 'Position',[0 50 250 30],...
        'String','Saw tooth profile');
    uicontrol('Style','Radio', 'Parent',hBtnGrp, ...
        'HandleVisibility','off', 'Position',[0 20 250 30],...
        'String','Arbitrary Surface');
    
    choice1='Surface scan as xyz point cloud';
    
    
% button to confirm choice
uicontrol('Parent',d,...
       'Position',[89 40 70 25],...
       'String','Done',...
       'Callback',@button_callback);
   
% button to go back
uicontrol('Parent',d,...
    'Position',[69 10 100 25],...
    'String','Back to Ecodist',...
    'Callback',@button_callback2);
    
% waiting for user input 
uiwait(d); 

% ================ callback function for done button =====================
function button_callback(~,~)
delete(gcf);

% d2 = dialog('Position',[300 300 250 500],'Name','Surface Inputs');
% 
% % display a short welcome text
% welcome_text2=['Choose the grid constant a in mm. ',...
%     'It can have a big influence on the calculation time!'];
% uicontrol('Parent',d2,...
%            'Style','text',...
%            'Position',[20 450 210 40],...
%            'String',welcome_text2);
%        
% % question which kind of surface
% uicontrol('Parent',d2,...
%            'Style','edit',...
%            'Position',[20 420 100 20],...
%            'String','1',...
%            'Callback',@edit_callback);
%        a=1;


if strcmp(choice1,'Surface scan as xyz point cloud')
    [surface_name,a] = Create_xyz;

    
elseif strcmp(choice1,'Surface scan as stl file')
    [surface_name,a] = Create_stl;
    
elseif strcmp(choice1,'Flat surface')
    [surface_name,a] = Create_flat;
    
elseif strcmp(choice1,'Saw tooth profile')
    [surface_name,a]  = create_saw;

elseif strcmp(choice1,'Arbitrary Surface')
    [surface_name,a]  = create_art;

else
    return
end

end

% callback function of made choice
function bselection1(~,event)
    choice1=event.NewValue.String;
end    

% callback for back button
function button_callback2(~,~)
    delete(gcf);
    Ecodist;
end



end

