function name=CreateRockFile
%GUI to create the input file for the rock parameters

d = dialog('Position',[300 300 250 500],'Name','Rock parameters');

% insert name
uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 430 100 40],...
           'String','Name of rock parameter file: ');
       
       uicontrol('Parent',d,...
           'Style','edit',...
           'Position',[130 450 100 20],...
           'String','Input_rock.txt',...
           'Callback',@edit_callback);
    name='Input_rock.txt';

    % ========== list of parameters ========================================
annotation(d,'textbox','String','E / Pa', ...
    'units','pix', 'Position', [20 340 70 25],'Interpreter','Tex');
% uicontrol('Parent',d,...
%            'Style','text',...
%            'Position',[20 340 70 25],...
%            'String','E/ MPa');
uicontrol('Parent',d,...
           'Style','edit',...
           'Position',[100 340 60 20],...
           'String','50e9',...
           'Callback',@edit_callback2);
    E=50e9;
    
    
annotation(d,'textbox','String','\phi / \circ', ...
    'units','pix', 'Position', [20 300 70 25],'Interpreter','Tex');
uicontrol('Parent',d,...
           'Style','edit',...
           'Position',[100 300 60 20],...
           'String','52.5',...
           'Callback',@edit_callback3);
    phi=52.5; 
    
annotation(d,'textbox','String','c / Pa', ...
'units','pix', 'Position', [20 260 70 25],'Interpreter','Tex');
uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[100 260 60 20],...
       'String','22.5e6',...
       'Callback',@edit_callback4);
    c=22.5e6;
    
annotation(d,'textbox','String','\phi_b / \circ', ...
'units','pix', 'Position', [20 220 70 25],'Interpreter','Tex');
uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[100 220 60 20],...
       'String','30',...
       'Callback',@edit_callback5);
phi_b=30; 

annotation(d,'textbox','String','\sigma_t / Pa', ...
'units','pix', 'Position', [20 180 70 25],'Interpreter','Tex');
uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[100 180 60 20],...
       'String','7e6',...
       'Callback',@edit_callback6);
sigma_t=7e6; 

annotation(d,'textbox','String','\sigma_c / Pa', ...
'units','pix', 'Position', [20 140 70 25],'Interpreter','Tex');
uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[100 140 60 20],...
       'String','120e6',...
       'Callback',@edit_callback7);
sigma_c=120e6; 


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

% ============== create rock paramter file ===============================
fid=fopen(name,'w');

fprintf(fid, 'E %f \n', E);
fprintf(fid, 'phi %f \n', phi);
fprintf(fid, 'c %f \n', c);
fprintf(fid, 'phi_b %f \n', phi_b);
fprintf(fid, 'sigma_t %f \n', sigma_t);
fprintf(fid, 'sigma_c %f \n', sigma_c);

fclose(fid);


% ================= callback functions ===================================
function button_callback(~,~)
    delete(gcf);
end

function button_callback2(~,~)
    delete(gcf);
    Ecodist;
end

function edit_callback(edit,~)
    %idx=edit.Value
    name=edit.String;
%     a=str2double(char(edit_items));
%     if a<0
%         a=0;
%         edit.String=0;
%     end
end

function edit_callback2(edit,~)
    %idx=edit.Value
    edit_items=edit.String;
    E=str2double(char(edit_items));
    if E<0
        E=50e9;
        edit.String=50e9;
    end
end

function edit_callback3(edit,~)
    %idx=edit.Value
    edit_items=edit.String;
    phi=str2double(char(edit_items));
    if phi<0
        phi=52.5;
        edit.String=52.5;
    end
end

function edit_callback4(edit,~)
    %idx=edit.Value
    edit_items=edit.String;
    c=str2double(char(edit_items));
    if c<0 || isnan(c)
        c=22.5e6;
        edit.String=22.5e6;
    end
end

function edit_callback5(edit,~)
    %idx=edit.Value
    edit_items=edit.String;
    phi_b=str2double(char(edit_items));
    if phi_b<0 || isnan(phi_b)
        phi_b=30;
        edit.String=30;
    end
end

function edit_callback6(edit,~)
    %idx=edit.Value
    edit_items=edit.String;
    sigma_t=str2double(char(edit_items));
    if sigma_t<0 || isnan(sigma_t)
        sigma_t=7e6;
        edit.String=7e6;
    end
end

function edit_callback7(edit,~)
    %idx=edit.Value
    edit_items=edit.String;
    sigma_c=str2double(char(edit_items));
    if sigma_c<0 || isnan(sigma_c)
        sigma_c=120e6;
        edit.String=120e6;
    end
end

end

