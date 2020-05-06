function Calculations(names)
%Calculation of direct shear tests using different methods
% Input: 
%	names 	4-by-1 struct with the names of geometry, lab, rock, result

tic;
%============================ create direction for the figure output =====
timestamp=datestr(clock, 'yyyy-mm-dd-HH-MM');
path_saving=strcat(timestamp);
mkdir(path_saving);

% ======================= copy input files in the output folder ==========
copyfile (names{1} ,path_saving)
copyfile (names{2} ,path_saving)
copyfile (names{3} ,path_saving)
if ~isempty(names{4})
    copyfile (names{4} ,path_saving)
end 

% =========== import all data from the files =============================
% geometry
fid1=fopen(names{1},'r');
dims=fscanf(fid1,'%f %f %f',3);
a=dims(1);
m=dims(2);
n=dims(3);
A=fscanf(fid1,'%f');
A=reshape(A,m,n);

% for the 2 models with abrasion a copy is made
A_casa=A;
A_new=A;


% ===================== transform pixels in m of x- and y-axis =========
[y,x]=size(A);
x_step=round(x/4);
x_ticks=0:x_step:x;
%y_ticks=fliplr(y:-x_step:0); %fliped for imagesc
%y_labels=y_ticks-min(y_ticks);
y_ticks_surf=0:x_step:y; %normal for surface

% ============= figure of surface =================================
figure()
s=surf(A);
s.EdgeColor = 'none';
colormap hot
c=colorbar;
c.Label.String='height  / m';
c.Label.FontSize=14;
ax=gca;
ax.DataAspectRatio = [1 1 0.25*a];
title('Surface','FontSize',16);
xticks(x_ticks);
xticklabels({num2str(a*x_ticks')});
xlabel('x / m');
yticks(y_ticks_surf);
yticklabels({num2str(a*y_ticks_surf')});
%yticklabels({flipud(num2str(a*y_labels'))});
ylabel('y / m');
zlabel('z / m');
ax = gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
ax.ZAxis.FontSize = 14;
saveas(gcf,[pwd,'\',path_saving,'\','Surface.png']);


% ======================= lab parameters ================================
fid2=fopen(names{2},'r');
B=textscan(fid2,'%f %f');

sigma_n_vector=B{1}(1:end-1); %normal stresses as vector
%S=B{2}; %shear directions as cell array
u_s_vector=B{2}(1:end-1); %shear displacements as vector 

h0=B{1}(end); %height of sample in m.
K_n=B{2}(end); % normal stiffness in Pa/m

% === delete zeros =====
destroy=find(u_s_vector==0);
sigma_n_vector(destroy)=[];
u_s_vector(destroy)=[];
%S(destroy)=[];



% ========================= rock parameters =============================
fid3=fopen(names{3},'r');
B=textscan(fid3,'%s %f');

pos=strcmp(B{1},'E');
E=B{2}(pos);

pos=strcmp(B{1},'phi');
phi=B{2}(pos);

pos=strcmp(B{1},'c');
c=B{2}(pos);

pos=strcmp(B{1},'phi_b');
phi_b=B{2}(pos);

pos=strcmp(B{1},'sigma_t');
sigma_t=B{2}(pos);

pos=strcmp(B{1},'sigma_c');
sigma_c=B{2}(pos);

% calculate missing rock parameters
JCS=sigma_c;

% ================ lab results =========================================

if isempty(names{4})
    result=0;
else 
    result=1;
    fid=fopen(names{4},'r');
    LabRes=fscanf(fid,'%f %f %f %f\n'); %u_s sigma_n tau u_n in m, MPa, MPa, m
    mn=length(LabRes);
    LabRes=reshape(LabRes,4,mn/4);
    LabRes=LabRes';
end


% ====== loop for all shear steps ========================================

% ==== peak values initialization ============
tau_BartonBandis1985=zeros(size(sigma_n_vector));
tau_Xia2014=zeros(size(sigma_n_vector));
tau_Casagrande2018=zeros(size(sigma_n_vector));
tau_New2018=zeros(size(sigma_n_vector));

% ==== residual values initialization ============
tau_BartonBandis1985Res=zeros(size(sigma_n_vector));
tau_Casagrande2018Res=zeros(size(sigma_n_vector));
tau_New2018Res=zeros(size(sigma_n_vector));


if result==1
    tau_Lab=zeros(size(sigma_n_vector));
    tau_Lab_res=tau_Lab;
end
indx=ones(size(sigma_n_vector));
indx2=ones(size(sigma_n_vector));

for jj=1:length(sigma_n_vector)
    % === lab result ===
    if result==1
        if jj==1
            [~,indx2(jj)]=ismember([333 333 333 333],LabRes(indx(jj):end,:),'rows');
        else
            [~,indx2(jj)]=ismember([333 333 333 333],LabRes(indx2(jj-1)+1:end,:),'rows');
        end
        
        
        if indx2(1)==1
            [~,indx2(1)]=ismember([333 333 333],LabRes(2:end,:),'rows');
        end
        if jj~=1
            indx(jj)=indx(jj)+indx2(jj-1);
            indx2(jj)=indx2(jj)+indx2(jj-1);
        end
        LabRes_temp=LabRes(indx(jj):indx2(jj),:);
        tau_Lab(jj)=max(LabRes_temp(:,3));
        %tau_Lab_res(jj)=tau_Lab_Manuell(jj);
        tau_Lab_res(jj)=LabRes_temp(end-1,3);
        
    end



    % == normal stress and maximum displacement at current shear level ==
    sigma_n=sigma_n_vector(jj);
    u_s=u_s_vector(jj);


    % ========== Barton-Bandis 1985 ======================================
    [JRC] = JRC_calc(A,a);
    delta_u_s=1e-5;
    phi_r=phi_b;
    L=a*length(A(1,:)); %lenght in m
    [delta_BB1985,sigma_n_BB1985,tau_BB1985,dil_BB1985,e_BB1985]=BB1985(L,JRC,JCS,sigma_n,phi_r,phi_b,delta_u_s,u_s,K_n);
    tau_BB1985_peak=max(tau_BB1985);

    tau_BartonBandis1985(jj)=tau_BB1985_peak;
    tau_BartonBandis1985Res(jj)=tau_BB1985(end);
    
    figure()
    plot(delta_BB1985,dil_BB1985);
    title('dilation BB 1985');
    
    figure()
    plot(delta_BB1985,sigma_n_BB1985);
    title('Normal stress BB 1985');
    
    figure()
    plot(delta_BB1985,e_BB1985);
    title('hydraulic aperture');


    % ====== Xia ===================================================
    [Theta_star]= Gradients_square_grid(A,a,[1 0 0]);

    alpha=Theta_star(Theta_star>=0);
    pixarea=m*n;
    [grass] = Grasselli_Kurve(alpha,pixarea);
    [C,th_max,A_0,~] = Fit_grasselli(alpha,grass);

    tau_xia = Xia2014(sigma_n, sigma_t,phi_b,A_0,th_max, C);

    tau_Xia2014(jj)=tau_xia;




    % ========= Casagrande ===============================================

    [tau_casa_p,tau_casa_r,A_casa]=Casagrande2017(A_casa,c,sigma_n,phi_b,phi,a);

    tau_Casagrande2018(jj)=tau_casa_p;
    tau_Casagrande2018Res(jj)=tau_casa_r;

    % =========== NEW =====================================================
        
    F_n=sigma_n*m*n*a^2;
    [sigma_n_new,tau_new_shear,u_shear,A_new,dil_new,dil_angle]=...
        Poetschke_2018(A_new,A_new,a,h0,F_n,u_s,phi_b,phi,E,c,K_n,path_saving);
    tau_new_p=max(tau_new_shear);
    
    figure()
    plot(u_shear,sigma_n_new);
    title('\sigma_n New model');



    tau_New2018(jj)=tau_new_p;
    tau_New2018Res(jj)=tau_new_shear(end);

    fid=fopen([pwd,'\',path_saving,'\','Log',num2str(sigma_n),'.txt'],'w');
        fprintf(fid,'u_s/m   tau/Pa  u_n/m \n');
        for p=1:length(u_shear)
            fprintf(fid,'%1.7f %8.0f %1.7f\n',u_shear(p), tau_new_shear(p),dil_new(p));
        end

    fclose(fid);


    figure()
    if result==1
        plot(LabRes(indx(jj):indx2(jj)-1,1),LabRes(indx(jj):indx2(jj)-1,3));
        hold on
        plot(u_shear,tau_new_shear,'--');
        plot(delta_BB1985,tau_BB1985,':');
        if K_n==0
            title(['\sigma_n = ',num2str(sigma_n_vector(jj)/1e6),' MPa']);
        else
            title(['\sigma_n = ',num2str(sigma_n_vector(jj)/1e6),' MPa',' +',num2str(K_n/1e9),'MPa/mm*u_n']);
        end

        lg=legend({'Lab','New','Bar-Ban'},'Location','southeast');%'southeast');
        lg.FontSize=14;
        set(findall(gca, 'Type', 'Line'),'LineWidth',3);
        xlabel('u_s / m');
        ylabel('\tau / Pa');
        ax = gca;
        ax.XAxis.FontSize = 14;
        ax.YAxis.FontSize = 14;
        saveas(gcf,[pwd,'\',path_saving,'\',['New-vs-Lab-vs-BB',num2str(jj),'.png']]);
    elseif result==0
        plot(u_shear,tau_new_shear);
        set(findall(gca, 'Type', 'Line'),'LineWidth',3);
    end
    xlabel('u_s / m');
    ylabel('\tau / Pa');
    ax = gca;
    ax.XAxis.FontSize = 14;
    ax.YAxis.FontSize = 14;

    if result==1 %normal displacement
        figure()
        plot(LabRes(indx(jj):indx2(jj)-1,1),LabRes(indx(jj):indx2(jj)-1,4));
        hold on
        plot(u_shear,dil_new,'--');
        plot(delta_BB1985,dil_BB1985,':');
        if K_n==0
            title(['\sigma_n = ',num2str(sigma_n_vector(jj)/1e6),' MPa']);
        else
            title(['\sigma_n = ',num2str(sigma_n_vector(jj)/1e6),' MPa',' +',num2str(K_n/1e9),'MPa/mm*u_n']);
        end
        lg=legend({'Lab','New','BB'},'Location','southeast');%'southeast');
        lg.FontSize=14;
        set(findall(gca, 'Type', 'Line'),'LineWidth',3);
        xlabel('u_s / m');
        ylabel('u_n / m');
        ax = gca;
        ax.XAxis.FontSize = 14;
        ax.YAxis.FontSize = 14;
        saveas(gcf,[pwd,'\',path_saving,'\',['Dilatation',num2str(jj),'.png']]);
        xlabel('u_s / m');
        ylabel('u_n / m');
        ax = gca;
        ax.XAxis.FontSize = 14;
        ax.YAxis.FontSize = 14;
    end
    
    

end


pixmax=round(u_s/a); 

figure()
imagesc(A(:,1:end-pixmax)-A_new(:,1:end-pixmax))
title('A-A_{new}');
colorbar




figure('units','normalized','outerposition',[0 0 1 1])
if result==1
    plot(sigma_n_vector,tau_Lab,'cd-','MarkerSize',8,'MarkerFaceColor','c');
end
hold on
plot(sigma_n_vector,tau_BartonBandis1985,'k+','MarkerSize',8,'MarkerFaceColor','k');
plot(sigma_n_vector,tau_Xia2014,'g<','MarkerSize',8,'MarkerFaceColor','w');
plot(sigma_n_vector,tau_Casagrande2018,'bv','MarkerSize',8,'MarkerFaceColor','b');
plot(sigma_n_vector,tau_New2018,'ro','MarkerSize',8,'MarkerFaceColor','w');
hold off
if result==1
    lg=legend({'Lab','Bar-Ban','Xia','Casagrande','NEW'},'Location','bestoutside');%,'Experiment','Barton after shear','Xia after shear');
else
    lg=legend({'Bar-Ban','Xia','Casagrande','NEW'},'Location','bestoutside');%,'Experiment','Barton after shear','Xia after shear');
end
lg.FontSize=14;
title('Peak shear strength','FontSize',16);
xlabel('\sigma_n / Pa');
ylabel('\tau_p / Pa');
xlim([0 inf])
ylim([0 inf])
ax = gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
saveas(gcf,[pwd,'\',path_saving,'\','Comparison_final_Peak.png']);

figure('units','normalized','outerposition',[0 0 1 1])
if result==1
    plot(sigma_n_vector,tau_Lab_res,'cd-','MarkerSize',8,'MarkerFaceColor','c');
end
hold on
plot(sigma_n_vector,tau_BartonBandis1985Res,'k+','MarkerSize',8,'MarkerFaceColor','k');
%plot(sigma_n_vector,tau_Xia2014,'g<','MarkerSize',8,'MarkerFaceColor','w');
plot(sigma_n_vector,tau_Casagrande2018Res,'bv','MarkerSize',8,'MarkerFaceColor','b');
plot(sigma_n_vector,tau_New2018Res,'ro','MarkerSize',8,'MarkerFaceColor','w');
hold off
if result==1
    lg=legend({'Lab','Bar-Ban','Casagrande','NEW'},'Location','bestoutside');%,'Experiment','Barton after shear','Xia after shear');
else
    lg=legend({'Bar-Ban','Casagrande','NEW'},'Location','bestoutside');%,'Experiment','Barton after shear','Xia after shear');
end
lg.FontSize=14;
title('Residual shear strength','FontSize',16);
xlabel('\sigma_n / Pa');
ylabel('\tau_r / Pa');
xlim([0 inf])
ylim([0 inf])
ax = gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
saveas(gcf,[pwd,'\',path_saving,'\','Comparison_final_Res.png']);

% ======================= write log file ================================
time_c=toc;
fid=fopen([pwd,'\',path_saving,'\','Log.txt'],'w');
fprintf(fid, 'a= %f m \n',a);
fprintf(fid, 'y= %f m \n',m*a);
fprintf(fid, 'x= %f m \n',n*a);
fprintf(fid, 'Calculation time= %f s\n',time_c);
fprintf(fid,'sigma_n   BB1985p BB1985 r  Xia2014 Casa2018p Casa2018r  New2018p New2018r   \n');
for rr=1:length(sigma_n_vector)
    fprintf(fid,'%8.0f %8.0f %8.0f %8.0f  %8.0f %8.0f %8.0f %8.0f \n',sigma_n_vector(rr), ...
        tau_BartonBandis1985(rr), tau_BartonBandis1985Res(rr), ...
        tau_Xia2014(rr), tau_Casagrande2018(rr), tau_Casagrande2018Res(rr),...
        tau_New2018(rr),tau_New2018Res(rr));
end


fclose(fid);

end

