function A = read_xyz_file(name)
% reads file which contains xyz coordinates of surface
% Input:	name of the file in string format
% Output:	matrix A with x y z columns

fileID = fopen(name,'r');
formatSpec = '%f %f %f';
sizeA = [3 Inf];
A = fscanf(fileID,formatSpec,sizeA);
A=A';
fclose(fileID);


end

