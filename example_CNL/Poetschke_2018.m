function [sigma_n,tau_shear,u_shear,z1_new,u_n,dil_angle]= ...
	Poetschke_2018(z1,z2,a,h0,F_n,u_s,phi_b,phi,E_stat,cohesion,K_n,path_saving)
% Function to simulate direct shear tests using surface scan data and basic
% rock parameters. Different upper and bottom geometries are intended, but right
% now the Code overall uses identical ones.
% Input: 
%	z1		height values (matrix) upper half in m 
%	z2		height values (matrix) bottom half in m 
%	a		grid const in m 
%	Fn		normal force in N 
%	u_s		max. shear displacement in m 
%	phi_b	basic friction in degree
%	phi		friction (inner friction of material) in degree
%	E_stat	static E modulus in Pa 
% 	cohesion in Pa 
%	path_saving - directory to save result files 
% Output: 
%	sigma_0		normal stress in Pa
%	tau_shear	shear stress in Pa  
%	u_shear		shear vector in m (according to sigma_0 and tau_shear)

%============= preparation =============================================
F_n_0=F_n;			%normal force at beginning of shear test 

pixmax=round(u_s/a); 	%number of pixels the matrices have to be shifted

%get dimensions in pixels
Groundsize=a*size(z1);
w0=Groundsize(1);
l0=Groundsize(2);

%copies of input geometry
z1_before=z1;
z1_new=z1;

%initialize vectors
sigma_n=zeros(pixmax+1,1);
tau_shear=zeros(pixmax+1,1);
u_n=zeros(pixmax+1,1);
dil_angle=zeros(pixmax+1,1);
u_shear=a*(0:pixmax);

% ============= stepwise shear displacement ========================================
for kk=1:pixmax
	pix=1;
	z1=z1(:,1:end-pix); % moved in pos. x-direction
	z2=z2(:,pix+1:end); % fixed

	i=0;
	count=0;

	% ====== iteration until no further shear ====================
	while i==0
		% ======= shift to initial position where F=0 ============================  
		Aper=z1-z2;
		Ap_min=min(Aper(:));
		Aper=Aper - Ap_min; 

		z2=z2+Ap_min; % now contact without overlap

		% ======= z-displacement =================================================
		u_z=0:0.000025:max(Aper(:));

		% == calculate force F for the z-displacements using function Force_normal
		F=zeros(size(u_z));
		for i=1:length(u_z)
			Aper_temp=Aper-u_z(i);
			F(i) = Force_normal(Aper_temp, h0,E_stat,a);
		end

		% ======= dilation where normal forces are balanced ==================
		dil=-u_z(find(F>=F_n,1));
		if isempty(dil) %for very high normal stesses resulting dilation 
			dil=-1e-5;
		end

		z2=z2-dil;

		% ======== get the result where no overlap occurs. the virtual overlap 
		% is stored in the overlap variable. ==============================
		ii=find(z1-z2<0);
		overlap=zeros(size(z1));
		overlap(ii)=z1(ii)-z2(ii);

		% ======= calculate apparent dip angles ==============================
		[Th_star]=Gradients_square_grid(z1,a,[1 0 0]);

		Th_star(overlap~=0);		% ????????????????????????????????

		% ==== calculate sliding and shear forces for areas in contact =======
		Ncf=nnz(overlap); % number of contributing facets

		f_local=F_n/Ncf; % local force acting on one facet
		F_slide=zeros(size(z1)); % sliding force
		F_shear=F_slide; % shear force

		% calculate shearing force (for destruction of active elements)
		F_shear(overlap<0)=(a)^2*(cohesion+f_local/((a)^2)...
			*tand(phi));

		% if theta angle to close to 90 degree numerical problems can occur 
		th_critical=87-phi_b;
		Th_help=Th_star;
		Th_help(Th_help>th_critical)=th_critical;

		% calculate sliding force 
		F_slide(overlap<0)=f_local*tand((phi_b+Th_help(overlap<0)));

		% ========= destruction of rock material ===============================
		[m,n]=size(z1);
		% active parts of surface
		contr=find(F_slide>F_shear);
		contr(contr>m*n-m)=[];
		beta=max(Th_star(:));

		% destruction by flattening active elements by 0.1 degree
		for j=1:length(contr)
			z1(contr(j))=z1(contr(j))+a*(sind(beta)-sind(beta-0.1));
			z2(contr(j)+m)=z2(contr(j)+m)-a*(sind(beta)-sind(beta-0.1));
		end

		% if no active elements found the while loop can be stopped
		if isempty(contr)
			i=1;
		else
			i=0;
		end

		% counter for iterations
		count=count+1;

		% geometry for final result (maybe update after while loop better)
		z1_new=[z1,z1_new(:,end-(kk-1):end)];

	end

	% shear stress needed to equal the slide resistance 
	tau_shear(kk+1)=sum(F_slide(:))/((l0-kk*a)*w0);

	% normal displacement
	u_n(kk+1)=abs(dil);

	% dilatation angle 
	dil_angle(kk+1)=beta;

	% New normal stress due to dilatation + stiffness
	sigma_n(kk+1)=F_n_0/(w0*(l0-kk*a))+K_n*u_n(kk+1);

	% normal force corresponding to normal stress and new surface size 
	F_n=sigma_n(kk+1)*w0*(l0-kk*a);

end


% ========== write geometry file for new geometry ========================

[m,n]=size(z1_new);

fid=fopen('Geometry_new.txt','w');
fprintf(fid, '%f %f %f\n',a,m,n);
fprintf(fid, '%f \n', z1_new);
fclose(fid);


% ======== figure output =================================================
% the orientation of surf and imagesc visualization of the heigth matrix
% are flipped

% ====transform pixels in m of x- and y-axis =
[y,x]=size(z1);
x_step=round(x/4);
x_ticks=0:x_step:x;
% y_ticks=fliplr(y:-x_step:0); %fliped for imagesc
% y_labels=y_ticks-min(y_ticks);
y_ticks_surf=0:x_step:y; %normal for surface

% abrasion_map
figure()
abrasion_map=z1_before(:,1:end-pixmax)-z1;
abrasion_map(abrasion_map~=0)=1;
abrasion_map(abrasion_map~=1)=0;
save("Abrasion_map.mat",'abrasion_map');
surf(z1,abrasion_map);
%s.EdgeColor = 'none';
ax=gca;
ax.DataAspectRatio = [1 1 0.25*a];
colormap bluewhitered
title('Occurrence of destruction');
xticks(x_ticks);
xticklabels({num2str(a*x_ticks')});
xlabel('x / m');
yticks(y_ticks_surf);
yticklabels({num2str(a*y_ticks_surf')});
ylabel('y / m');
zlabel('z / m');
ax = gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
saveas(gcf,[pwd,'\',path_saving,'\','Abrasion_marked.png']);

% abrasion_map no edges
figure()
abrasion_map=z1_before(:,1:end-pixmax)-z1;
abrasion_map(abrasion_map~=0)=1;
abrasion_map(abrasion_map~=1)=0;
save("Abrasion_map.mat",'abrasion_map');
s=surf(z1,abrasion_map);
s.EdgeColor = 'none';
ax=gca;
ax.DataAspectRatio = [1 1 0.25*a];
colormap bluewhitered
title('Occurrence of destruction');
xticks(x_ticks);
xticklabels({num2str(a*x_ticks')});
xlabel('x / m');
yticks(y_ticks_surf);
yticklabels({num2str(a*y_ticks_surf')});
ylabel('y / m');
zlabel('z / m');
ax = gca;
ax.XAxis.FontSize = 14;
ax.YAxis.FontSize = 14;
saveas(gcf,[pwd,'\',path_saving,'\','Abrasion_markedNoEdges.png']);

% abrasion_map planar
figure()
imagesc(fliplr(abrasion_map));
colormap gray
saveas(gcf,[pwd,'\',path_saving,'\','Abrasion_markedImage.png']);



end

