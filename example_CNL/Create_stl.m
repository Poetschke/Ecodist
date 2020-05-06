function [Name,a] = Create_stl
%GUI to create surface file from an stl file

% ========= open new panel =============================================
d2 = dialog('Position',[300 300 250 500],'Name','Create stl');

% display a short welcome text
welcome_text2=['Choose the grid constant a in m. ',...
    'It can have a big influence on the calculation time!'];
uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 450 210 40],...
           'String',welcome_text2);
% edit field for grid constant a in m
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[20 420 100 20],...
           'String','1e-3',...
           'Callback',@edit_callback);
a=1e-3;
       
% choose stl file to use       
e = dir('*.stl');
fn = {e.name};
if isempty(fn)
    disp('No file found');
    delete(gcf);
    CreateSurfaceFile;
else
    uicontrol('Parent',d2,...
        'Style','Text',...
        'Position',[20 380 100 20],...
        'String','Choose file from list');
    
    uicontrol('Parent',d2,...
    'Style','popupmenu',...
    'Position',[20 360 100 20],...
    'String',fn,...
    'Callback',@Popup_Callback);
    surface_name=fn{1};
end


uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 330 110 20],...
           'String','Name of geometry file');
% edit field for grid constant a in mm
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[20 300 100 20],...
           'String','Geometry.txt',...
           'Callback',@edit_callback3);
        Name='Geometry.txt';

% button to confirm choice
uicontrol('Parent',d2,...
       'Position',[89 40 70 25],...
       'String','Done',...
       'Callback',@button_callback);
   
% button to go back
uicontrol('Parent',d2,...
    'Position',[40 10 150 25],...
    'String','Back to Create Surface',...
    'Callback',@button_callback2);



% waiting for user input 
uiwait(d2); 
    
% =============== callback functions ====================================    
function edit_callback(edit,~)
    %idx=edit.Value
    edit_items=edit.String;
    a=str2double(char(edit_items));
    if a<0
        a=1e-3;
        edit.String=1e-3;
    end
end

function Popup_Callback(popup,~)
    idx = popup.Value;
    popup_items = popup.String;
    surface_name = char(popup_items(idx,:));
end

function button_callback(~,~)
    delete(gcf);
    % ========= CreateSurfaceFile =========================;
    [p,~,~]=import_stl_fast_original(surface_name,1);
    [z] = Aperture_Calc(p,a);
    [m,n]=size(z);
    z=z/1000; % in m
    fid=fopen(Name,'w');
    fprintf(fid, '%f %f %f\n',a,m,n);
    fprintf(fid, '%f \n', z);

    fclose(fid);
    

end


function button_callback2(~,~)
    delete(gcf);
    CreateSurfaceFile;
end

function edit_callback3(edit,~)
    %idx=edit.Value
    Name=edit.String;
    %Name=str2double(char(edit_items))
end



end

