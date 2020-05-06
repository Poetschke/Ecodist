function [grass] = Grasselli_Kurve(alpha, pixnumber)
% Calculates Grasselli curve for a given distribution of theta_ast angles.
% Input: 
%	alpha 		vector with all the dip angles of surface elements opposing 
% 				the shear direction 
%	pixnumber 	number of surface elements
% Output: 
%	grass 		vector which represents the grasselli-curve

% =========== delete NaN, sorting and find maximum =======================
alpha(isnan(alpha))=[];
N=length(alpha);
alpha=sort(alpha,'descend');
Th_max=ceil(alpha(1));

% =========== initialize Grasselli curve =================================
grass=zeros(1,Th_max);

% ===== for each angle theta_ast find the value of the Grasselli curve ===
for ii=0:Th_max-1
    jj=0;
    while alpha(jj+1)>ii
        jj=jj+1;
    end
    grass(ii+1)=jj/pixnumber;
       
end

% ======== for smooth surface grass would be empty, avoid this =========
if isempty(grass)
    grass=1;
end

end

