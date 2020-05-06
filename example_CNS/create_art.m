function [Name,a] = create_art
%GUI to create artificial surface file

% ========= open new panel =============================================
d2 = dialog('Position',[300 300 250 500],'Name','Create arbitrary');

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

% edit field for alpha1 in °
uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 300 110 20],...
           'String','Hurst');
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[120 300 100 20],...
           'String','0.5',...
           'Callback',@edit_callback6);
        Hurst=0.5;
        
% edit field for alpha2 in °
uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 270 110 20],...
           'String','sigma / m');
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[120 270 100 20],...
           'String','0.001',...
           'Callback',@edit_callback7);
        sigma=0.001;
        

uicontrol('Parent',d2,...
           'Style','text',...
           'Position',[20 130 110 20],...
           'String','Name of geometry file');
% edit field for grid constant a in mm
uicontrol('Parent',d2,...
           'Style','edit',...
           'Position',[20 100 100 20],...
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



function button_callback(~,~)
    delete(gcf);
    % ========= CreateSurfaceFile =========================;
    pix_x=round(l/a);
    pix_y=round(w/a);
    [z , ~ , ~] = artificial_surf(sigma, Hurst, l, pix_x , pix_y);
    
    
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

function edit_callback6(edit,~)
    edit_items=edit.String;
    Hurst=str2double(char(edit_items));
    if Hurst<0 || isnan(Hurst) || Hurst>1
        Hurst=0.5;
        edit.String=0.5;
    end
end

function edit_callback7(edit,~)
    edit_items=edit.String;
    sigma=str2double(char(edit_items));
    if sigma<0 || isnan(sigma) 
        sigma=0.001;
        edit.String=0.001;
    end
end



end

