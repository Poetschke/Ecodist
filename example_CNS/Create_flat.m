function [Name,a] = Create_flat
%GUI to create flat surface file

% ========= open new panel =============================================
d2 = dialog('Position',[300 300 250 500],'Name','Create flat');

% display a short welcome text
welcome_text2=['Choose the grid constant a in m. ',...
    'It can have a big influence on the calculation time!'];
uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 450 210 40],...
           'String',welcome_text2);
% edit field for grid constant a in mm
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[20 420 100 20],...
           'String','1e-3',...
           'Callback',@edit_callback);
a=1e-3;
       


uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 360 110 20],...
           'String','Width / m');
% edit field for width w in mm
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[120 360 100 20],...
           'String','0.100',...
           'Callback',@edit_callback4);
        w=0.100;
        
 uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 330 110 20],...
           'String','Length / m');
% edit field for length l in mm
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[120 330 100 20],...
           'String','0.100',...
           'Callback',@edit_callback5);
        l=0.100;



uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 280 110 20],...
           'String','Name of geometry file');
% edit field for Name of geometry file
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[20 250 100 20],...
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
    z=zeros(w/a,l/a);
    [m,n]=size(z);
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

function edit_callback4(edit,~)
    edit_items=edit.String;
    w=str2double(char(edit_items));
    if w<0 || isnan(w)
        w=0.100;
        edit.String=0.100;
    elseif mod(w,a)~=0
        w=a*floor(w/a);
        edit.String=w;
    end
end

function edit_callback5(edit,~)
    edit_items=edit.String;
    l=str2double(char(edit_items));
    if l<0 || isnan(l)
        l=0.100;
        edit.String=0.100;
    elseif mod(l,a)~=0
        l=a*floor(l/a);
        edit.String=l;
    end
end
end

