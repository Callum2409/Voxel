close all;
clear all;

materials = {'water', 'lead', 'air', 'invis', 'si', 'fe', 'graphite', 'U233'};%the material list
voxelSize = .5;%size of each voxel
neutrons = 1;%number of neutrons
show = 1; %set to 0 to not produce graphs

%DO NOT CHANGE THIS
[rx, ry, rz] = deal(0, 0, 0);%used for rotation initialisation
initRot = 0;%if specific rotation or isotropic

%the numbers in each group between semicolons are increasing in x
%x1, x2; x1, x2....
%[3,  4;  5,  6]
%each set of numbers is increasing in y
%y1; y2; y3
%[4;  5;  7]

%the point is relative to the model and will be scaled with the voxel size

%rotation can be made to be directional, using deal(_, _, _) or isotropic
%by setting initRot to be 1


%define the voxel materials. numbers reference the above materials array

%water slab to validate
%{
voxMat          = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 2) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 3) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 4) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 5) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
point = [0, 2.5, 2.5];
[x, y, z] = deal(1, 0, 0);
%}

%hole of water through lead
%{
voxMat          = [1, 1, 1; 1, 1, 1; 2, 2, 2; 2, 2, 2; 2, 2, 2; 2, 2, 2];
voxMat(:, :, 2) = [1, 1, 1; 1, 1, 1; 2, 1, 2; 2, 1, 2; 2, 1, 2; 2, 1, 2];
voxMat(:, :, 3) = [1, 1, 1; 1, 1, 1; 2, 2, 2; 2, 2, 2; 2, 2, 2; 2, 2, 2];
point = [0, 1.5, 1.5];
[x, y, z] = deal(1, 0, 0);
%}

%water beginning end, vacuum hole in lead
%{
voxMat          = [1, 1, 1; 1, 1, 1; 2, 2, 2; 2, 2, 2; 2, 2, 2; 2, 2, 2; 1, 1, 1; 1, 1, 1];
voxMat(:, :, 2) = [1, 1, 1; 1, 1, 1; 2, 3, 2; 2, 3, 2; 2, 3, 2; 2, 3, 2; 1, 1, 1; 1, 1, 1];
voxMat(:, :, 3) = [1, 1, 1; 1, 1, 1; 2, 2, 2; 2, 2, 2; 2, 2, 2; 2, 2, 2; 1, 1, 1; 1, 1, 1];
point = [0, 1.5, 1.5];
[x, y, z] = deal(1, 0, 0);
%}

%lead cube with air gap
%{
voxMat          = [2, 2, 2, 2, 2; 2, 2, 2, 2, 2; 2, 2, 3, 2, 2; 2, 2, 2, 2, 2; 2, 2, 2, 2, 2];
voxMat(:, :, 2) = [2, 2, 2, 2, 2; 2, 2, 2, 2, 2; 2, 2, 3, 2, 2; 2, 2, 2, 2, 2; 2, 2, 2, 2, 2];
voxMat(:, :, 3) = [2, 2, 3, 2, 2; 2, 2, 3, 2, 2; 3, 3, 3, 3, 3; 2, 2, 3, 2, 2; 2, 2, 3, 2, 2];
voxMat(:, :, 4) = [2, 2, 2, 2, 2; 2, 2, 2, 2, 2; 2, 2, 3, 2, 2; 2, 2, 2, 2, 2; 2, 2, 2, 2, 2];
voxMat(:, :, 5) = [2, 2, 2, 2, 2; 2, 2, 2, 2, 2; 2, 2, 3, 2, 2; 2, 2, 2, 2, 2; 2, 2, 2, 2, 2];
point = [2.5, 2.5, 2.5];
initRot = 1;
%}

%water cube with air gap
%{
voxMat          = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 3, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 2) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 3, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 3) = [1, 1, 3, 1, 1; 1, 1, 3, 1, 1; 3, 3, 3, 3, 3; 1, 1, 3, 1, 1; 1, 1, 3, 1, 1];
voxMat(:, :, 4) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 3, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 5) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 3, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
point = [2.5, 2.5, 2.5];
initRot = 1;
%}

%water cube with air gap 2
%{
voxMat          = [4, 4, 4, 4, 4; 4, 1, 1, 1, 4; 4, 1, 3, 1, 4; 4, 1, 1, 1, 4; 4, 4, 4, 4, 4];
voxMat(:, :, 2) = [4, 1, 1, 1, 4; 1, 1, 1, 1, 1; 1, 1, 3, 1, 1; 1, 1, 1, 1, 1; 4, 1, 1, 1, 4];
voxMat(:, :, 3) = [4, 1, 3, 1, 4; 1, 1, 3, 1, 1; 3, 3, 3, 3, 3; 1, 1, 3, 1, 1; 4, 1, 3, 1, 4];
voxMat(:, :, 4) = [4, 1, 1, 1, 4; 1, 1, 1, 1, 1; 1, 1, 3, 1, 1; 1, 1, 1, 1, 1; 4, 1, 1, 1, 4];
voxMat(:, :, 5) = [4, 4, 4, 4, 4; 4, 1, 1, 1, 4; 4, 1, 3, 1, 4; 4, 1, 1, 1, 4; 4, 4, 4, 4, 4];
point = [2.5, 2.5, 2.5];
initRot = 1;
%}

%cube with air gap and water outside
%{
voxMat          = [4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4];
voxMat(:, :, 2) = [4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4];
voxMat(:, :, 3) = [4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 2, 2, 3, 2, 2, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4];
voxMat(:, :, 4) = [4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 1, 1, 2, 2, 2, 2, 2, 1, 1; 1, 1, 2, 2, 3, 2, 2, 1, 1; 1, 1, 2, 2, 2, 2, 2, 1, 1; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4];
voxMat(:, :, 5) = [4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 2, 2, 3, 2, 2, 4, 4; 1, 1, 2, 2, 3, 2, 2, 1, 1; 1, 1, 3, 3, 3, 3, 3, 1, 1; 1, 1, 2, 2, 3, 2, 2, 1, 1; 4, 4, 2, 2, 3, 2, 2, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4];
voxMat(:, :, 6) = [4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 1, 1, 2, 2, 2, 2, 2, 1, 1; 1, 1, 2, 2, 3, 2, 2, 1, 1; 1, 1, 2, 2, 2, 2, 2, 1, 1; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4];
voxMat(:, :, 7) = [4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 2, 2, 3, 2, 2, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 2, 2, 2, 2, 2, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4];
voxMat(:, :, 8) = [4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4];
voxMat(:, :, 9) = [4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 1, 1, 1, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4; 4, 4, 4, 4, 4, 4, 4, 4, 4];
point = [4.5, 4.5, 4.5];
initRot = 1;
%}

%neutron tank
%{
voxMat          = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
voxMat(:, :, 2) = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
voxMat(:, :, 3) = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
voxMat(:, :, 4) = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
voxMat(:, :, 5) = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
voxMat(:, :, 6) = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
voxMat(:, :, 7) = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
voxMat(:, :, 8) = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 1, 1, 1, 1, 1, 1, 1, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
voxMat(:, :, 9) = [7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7; 7, 7, 7, 7, 7, 7, 7, 7, 7];
point = [4.5, 4.5, 4.5];
initRot = 1;
%}

%lead block
%{
voxMat          = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :, 2) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :, 3) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :, 4) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :, 5) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :, 6) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :, 7) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :, 8) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :, 9) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
voxMat(:, :,10) = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2; 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
point = [5, 5, 5];
%point = [0, 4.5, 4.5];
%[x, y, z] = deal(1, 0, 0);
initRot = 1;
%}

%lead/water block, stripes
%{
voxMat          = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 2) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 3) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 4) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 5) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 6) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 7) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 8) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 9) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :,10) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
%point = [4.5, 4.5, 4.5];
point = [0, 4.5, 4.5];
[x, y, z] = deal(1, 0, 0);
%initRot = 1;
%}

%lead/water block, alternating
%{
voxMat          = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1];
voxMat(:, :, 2) = [2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 3) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1];
voxMat(:, :, 4) = [2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 5) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1];
voxMat(:, :, 6) = [2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 7) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1];
voxMat(:, :, 8) = [2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
voxMat(:, :, 9) = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1];
voxMat(:, :,10) = [2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2; 2, 1, 2, 1, 2, 1, 2, 1, 2, 1; 1, 2, 1, 2, 1, 2, 1, 2, 1, 2];
%point = [4.5, 4.5, 4.5];
point = [0, 5, 5];
%point = [0, 4.5, 4.5];
[x, y, z] = deal(1, 0, 0);
%initRot = 1;
%}

%lead/water alternating
%{
voxMat          = [1, 2; 2, 1];
voxMat(:, :, 2) = [2, 1; 1, 2];
voxMat = repmat(voxMat, [2, 5, 5]);
point = [0, 5, 5];
[x, y, z] = deal(1, 0, 0);
%}

%neutron guide: a graphite column inside water
%{
voxMat          = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 2) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 3) = [1, 1, 7, 1, 1; 1, 1, 7, 1, 1; 1, 1, 7, 1, 1; 1, 1, 7, 1, 1; 1, 1, 7, 1, 1; 1, 1, 7, 1, 1; 1, 1, 7, 1, 1];
voxMat(:, :, 4) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 5) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
point = [0, 2.5, 2.5];
[x, y, z] = deal(1, 0, 0);
%}

%neutron guide cube
%{
voxMat          = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 7, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 2) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 7, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 3) = [1, 1, 7, 1, 1; 1, 1, 7, 1, 1; 7, 7, 7, 7, 7; 1, 1, 7, 1, 1; 1, 1, 7, 1, 1];
voxMat(:, :, 4) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 7, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
voxMat(:, :, 5) = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 7, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 1, 1];
point = [2.5, 2.5, 2.5];
initRot = 1;
%}

%graphite building brick
%{
voxMat          = [7, 7, 7; 7, 3, 7; 7, 7, 7; 7, 3, 7; 7, 7, 7; 7, 3, 7; 7, 7, 7];
voxMat(:, :, 2) = [7, 7, 7; 7, 3, 7; 7, 7, 7; 7, 3, 7; 7, 7, 7; 7, 3, 7; 7, 7, 7];
point = [0, 1.5, 1];
[x, y, z] = deal(1, 0, 0);
%}

%air with uranium voxel
%
voxMat          = [4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4];
voxMat(:, :, 2) = [4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4];
voxMat(:, :, 3) = [4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 8, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4];
voxMat(:, :, 4) = [4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4];
voxMat(:, :, 5) = [4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4; 4, 4, 4, 4, 4];
point = [0, 2.5, 2.5];
[rx, ry, rz] = deal(1, 0, 0);
%}

%get the material info array
for mat = 1:length(materials)
    [t, a, ~, f] = GetMat(materials{mat});
    S(mat, :) = [t, a, f];
end

%draw each voxel
if show
    xyz = size(voxMat);
    xyz = [xyz, ones(1, 3-length(xyz))];
    for x = 1:xyz(1)
        for y = 1:xyz(2)
            for z = 1:xyz(3)
                DrawVoxels([x, y, z], voxelSize, materials{voxMat(x, y, z)});
            end
        end
    end
    GraphTitles('','x /cm', 'y /cm', 'z /cm');
end

point = point*voxelSize;%scale the start point
WoodcockVoxel(repmat(point, neutrons, 1), repmat(initRot, neutrons, 1), rx, ry, rz, voxelSize, voxMat,S, neutrons, show);%calculate

if show
    axis equal tight;%make it show cubes so need same axis sizes
end