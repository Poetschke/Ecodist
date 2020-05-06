function [z] = Aperture_Calc(p,a)
% The surface is calculated on a quadratic grid for simple matrix
% operations and visualization as image.
% As the used scan-data are in mm this file is assuming this!
% Input: 
%	p	point cloud in mm 
%	a 	grid constant in m
% Output: 
%	z 	surface matrix



a=a*1000; % in mm

% ===================== find extreme values ============================
destroyEdge=10; % 5 mm destroyed
xmin=min(p(:,1))+destroyEdge+5;
xmax=max(p(:,1))-destroyEdge;
ymin=min(p(:,2))+destroyEdge;
ymax=max(p(:,2))-destroyEdge-5;

% ================== calculate the grid values in x and y direction ======
x=xmin:a:xmax;
y=ymin:a:ymax;

% ================================= generate query points xq, yq ========
[xq,yq]=meshgrid(x,y);

% ========== calculate heights and vertical aperture on quadratic grid ===
z=griddata(p(:,1),p(:,2),p(:,3),xq,yq,'natural');

z=DownsizeOmitNaN(z);

% NaN entries at the edges -> just inner part of matrix used
function z=DownsizeOmitNaN(z)
    [lines,cols]=find(isnan(z));
    while ~isempty(lines)
        [m,n]=size(z);
        % NaN in last column -> delete this column
        if ~isempty(find(cols==n, 1))
            z(:,n)=[];
        end
        % NaN in last line -> delete this line
        if ~isempty(find(lines==m,1))
            z(m,:)=[];
        end
        % NaN in first column -> delete this column
        if ~isempty(find(cols==1, 1))
            z(:,1)=[];
        end
        % NaN in first line -> delete this line
        if ~isempty(find(lines==1,1))
            z(1,:)=[];
        end
        % find NaN in new matrix
        [lines,cols]=find(isnan(z));
    end
end

end

