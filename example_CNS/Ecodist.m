function Ecodist
%Ecodist is the main function of the function set
%	It opens the GUI and finally executes Calculations function
%	4 inputs have to be created by filling form fields 
%	or choosing text files with specific format:
%		Geometry
%		Rock parameters
%		Shear test boundary conditions
%		Shear test results

close all
names={'';'';'';''};

% create dialog field
d = dialog('Position',[300 300 250 500],'Name','ECoDiST');

% display a short welcome text
welcome_text=['Welcome to ECoDiST! ',...
    'You will be guided through the programme.'];
uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 450 210 40],...
           'String',welcome_text);
       
% question if input files needed 
uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 300 210 40],...
           'String','Do you want to create input files?');

% radiobutton to choose one option       
hBtnGrp = uibuttongroup('Parent',d,'Position',...
    [0 0.4 1 0.23],'SelectionChangedFcn',@bselection1);
    uicontrol('Style','Radio', 'Parent',hBtnGrp, ...
        'HandleVisibility','off', 'Position',[0 80 50 30], 'String','Yes');
    uicontrol('Style','Radio', 'Parent',hBtnGrp,...
        'HandleVisibility','off', 'Position',[0 50 100 30],...
        'String','Just Geometry');
    uicontrol('Style','Radio', 'Parent',hBtnGrp, ...
        'HandleVisibility','off', 'Position',[0 20 50 30], 'String','No');
    choice1='Yes';
    
  
    
% button to confirm choice
uicontrol('Parent',d,...
       'Position',[89 20 70 25],...
       'String','Done',...
       'Callback',@button_callback);
    
% waiting for user input 
uiwait(d); 



% ==================== callback functions ================================
% callback button group
function bselection1(~,event)
    choice1=event.NewValue.String;
end  

% callback function for done button
function button_callback(~,~)
    delete(gcf);
    if strcmp(choice1,'Yes')
        names=UINames([0 0 0 1]);

        % call function to create geometry
        [names{1},a]=CreateSurfaceFile;

        % call function to create lab parameter file
        names{2}=CreateLabFile(a);

        % call function to create rock parameter file
        names{3}=CreateRockFile;



    elseif strcmp(choice1,'Just Geometry')
        % call function to choose input files for rock and lab parameters
        names=UINames([0 1 1 1]);
        % call function to create geometry
        [names{1}]=CreateSurfaceFile;

    else
        % call function to choose all input files
        names=UINames([1 1 1 1]);
    end

    % =============== Execute the function to do the calculations ============
    Calculations(names);
end

end

