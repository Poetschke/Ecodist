function name=CreateLabFile(a)
%GUI to create the input file for the direct shear test parameters

d = dialog('Position',[300 300 400 500],'Name','Shear test parameters');

% insert name
uicontrol('Parent',d,...
           'Style','text',...
           'Position',[20 430 100 40],...
           'String','Name of lab parameter file: ');
       
       uicontrol('Parent',d,...
           'Style','edit',...
           'Position',[130 450 100 20],...
           'String','Input_lab.txt',...
           'Callback',@edit_callback);
    name='Input_lab.txt';

% ========== list of parameters 1st part =================================
annotation(d,'textbox','String','\sigma_n / Pa', ...
    'units','pix', 'Position', [20 340 70 25],'Interpreter','Tex');
uicontrol('Parent',d,...
           'Style','edit',...
           'Position',[100 340 60 20],...
           'String','1e6',...
           'Callback',@edit_callback2);
    sigma_n_1=1e6;
    
    
% annotation(d,'textbox','String','Shear direction [+x,-x,+y,-y]', ...
%     'units','pix', 'Position', [20 270 78 60],'Interpreter','Tex');
% uicontrol('Parent',d,...
%            'Style','edit',...
%            'Position',[100 300 60 20],...
%            'String','+x',...
%            'Callback',@edit_callback3);
%     S_1='+x';   
    
annotation(d,'textbox','String','u_s / m', ...
'units','pix', 'Position', [20 230 78 25],'Interpreter','Tex');
uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[100 230 60 20],...
       'String','10e-3',...
       'Callback',@edit_callback4);
    u_s_1=10e-3;  
    
    
% ========== list of parameters 2nd part =================================
% annotation(d,'textbox','String','\sigma_n / MPa', ...
%     'units','pix', 'Position', [20 340 70 25],'Interpreter','Tex');
uicontrol('Parent',d,...
           'Style','edit',...
           'Position',[180 340 60 20],...
           'String','1e6',...
           'Callback',@edit_callback5);
    sigma_n_2=1e6;
    
    
% annotation(d,'textbox','String','Shear direction [+x,-x,+y,-y]', ...
%     'units','pix', 'Position', [20 270 78 60],'Interpreter','Tex');
% uicontrol('Parent',d,...
%            'Style','edit',...
%            'Position',[180 300 60 20],...
%            'String','+x',...
%            'Callback',@edit_callback6);
%     S_2='+x';   
    
% annotation(d,'textbox','String','u_s / mm', ...
% 'units','pix', 'Position', [20 230 78 25],'Interpreter','Tex');
uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[180 230 60 20],...
       'String','0',...
       'Callback',@edit_callback7);
    u_s_2=0;    
    
% ========== list of parameters 3rd part =================================
% annotation(d,'textbox','String','\sigma_n / MPa', ...
%     'units','pix', 'Position', [20 340 70 25],'Interpreter','Tex');
uicontrol('Parent',d,...
           'Style','edit',...
           'Position',[260 340 60 20],...
           'String','1e6',...
           'Callback',@edit_callback8);
    sigma_n_3=1e6;
    
    
% annotation(d,'textbox','String','Shear direction [+x,-x,+y,-y]', ...
%     'units','pix', 'Position', [20 270 78 60],'Interpreter','Tex');
% uicontrol('Parent',d,...
%            'Style','edit',...
%            'Position',[260 300 60 20],...
%            'String','+x',...
%            'Callback',@edit_callback9);
%     S_3='+x';   
    
% annotation(d,'textbox','String','u_s / mm', ...
% 'units','pix', 'Position', [20 230 78 25],'Interpreter','Tex');
uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[260 230 60 20],...
       'String','0',...
       'Callback',@edit_callback10);
    u_s_3=0;      
    
    
% ========= height of sample ============================================
annotation(d,'textbox','String','h_{sample} / m', ...
    'units','pix', 'Position', [30 100 90 25],'Interpreter','Tex');

uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[130 100 60 20],...
       'String','0.15',...
       'Callback',@edit_callback12);
    h=0.15; 
    
% ========= normal stiffness ============================================
annotation(d,'textbox','String','K_{n} / Pa/m', ...
    'units','pix', 'Position', [30 150 90 25],'Interpreter','Tex');

uicontrol('Parent',d,...
       'Style','edit',...
       'Position',[130 150 60 20],...
       'String','0',...
       'Callback',@edit_callback13);
    K_n=0; 



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




% ================= callback functions ===================================
function button_callback(~,~)
    delete(gcf);
    % ===== write file ==================
    fid=fopen(name,'w');
    
    fprintf(fid, '%f   %f\n',sigma_n_1,u_s_1);
    fprintf(fid, '%f   %f\n',sigma_n_2,u_s_2);
    fprintf(fid, '%f   %f\n',sigma_n_3,u_s_3);
    fprintf(fid, '%f %f \n', h,K_n);
    
    fclose(fid);
end

function button_callback2(~,~)
    delete(gcf);
    Ecodist;
end

function edit_callback(edit,~)
    name=edit.String;
end

% ======= callback of 1st part ===========================================
function edit_callback2(edit,~)
    edit_items=edit.String;
    sigma_n_1=str2double(char(edit_items));
    if sigma_n_1<0 || isnan(sigma_n_1)
        sigma_n_1=0;
        edit.String=0;
    end
end

% function edit_callback3(edit,~)
%     S_1=edit.String;
%     if strcmp(S_1,'+x')|| strcmp(S_1,'-x') || strcmp(S_1,'+y') || strcmp(S_1,'-y')
%     elseif strcmp(S_1,'x')
%         S_1='+x';
%         edit.String='+x';
%     elseif strcmp(S_1,'y')
%         S_1='+y';
%         edit.String='+y';
%     else
%         S_1='+x';
%         edit.String='+x';
%     end
% end

function edit_callback4(edit,~)
    edit_items=edit.String;
    u_s_1=str2double(char(edit_items));
    if u_s_1<0 || isnan(u_s_1)
        u_s_1=10e-3;
        edit.String=10e-3;
    elseif mod(u_s_1,a)~=0
        u_s_1=a*ceil(u_s_1/a);
        edit.String=u_s_1;
    end
end

% =========== callback of 2nd part ======================================
function edit_callback5(edit,~)
    edit_items=edit.String;
    sigma_n_2=str2double(char(edit_items));
    if sigma_n_2<0 || isnan(sigma_n_2)
        sigma_n_2=0;
        edit.String=0;
    end
end

% function edit_callback6(edit,~)
%     S_2=edit.String;
%     if strcmp(S_2,'+x')|| strcmp(S_2,'-x') || strcmp(S_2,'+y') || strcmp(S_2,'-y')
%     elseif strcmp(S_2,'x')
%         S_2='+x';
%         edit.String='+x';
%     elseif strcmp(S_2,'y')
%         S_2='+y';
%         edit.String='+y';
%     else
%         S_2='+x';
%         edit.String='+x';
%     end
% end

function edit_callback7(edit,~)
    edit_items=edit.String;
    u_s_2=str2double(char(edit_items));
    if u_s_2<0 || isnan(u_s_2)
        u_s_2=0;
        edit.String=0;
    elseif mod(u_s_2,a)~=0
        u_s_2=a*ceil(u_s_2/a);
        edit.String=u_s_2;
    end
end

% =========== callback of 3rd part ======================================
function edit_callback8(edit,~)
    edit_items=edit.String;
    sigma_n_3=str2double(char(edit_items));
    if sigma_n_3<0 || isnan(sigma_n_3)
        sigma_n_3=0;
        edit.String=0;
    end
end

% function edit_callback9(edit,~)
%     S_3=edit.String;
%     if strcmp(S_3,'+x')|| strcmp(S_3,'-x') || strcmp(S_3,'+y') || strcmp(S_3,'-y')
%     elseif strcmp(S_3,'x')
%         S_3='+x';
%         edit.String='+x';
%     elseif strcmp(S_3,'y')
%         S_3='+y';
%         edit.String='+y';
%     else
%         S_3='+x';
%         edit.String='+x';
%     end
% end

function edit_callback10(edit,~)
    edit_items=edit.String;
    u_s_3=str2double(char(edit_items));
    if u_s_3<0 || isnan(u_s_3)
        u_s_3=0;
        edit.String=0;
    elseif mod(u_s_3,a)~=0
        u_s_3=a*ceil(u_s_3/a);
        edit.String=u_s_3;
    end
end

function edit_callback12(edit,~)
    edit_items=edit.String;
    h=str2double(char(edit_items));
    if h<0 || isnan(h)
        h=0.15;
        edit.String=0.15;
    end
end

function edit_callback13(edit,~)
    edit_items=edit.String;
    K_n=str2double(char(edit_items));
    if K_n<0 || isnan(K_n)
        K_n=0;
        edit.String=0.15;
    end
end

end

