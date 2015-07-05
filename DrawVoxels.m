function DrawVoxels(pos, len, material)
%DRAWVOXELS
%create a voxel
cube = [0 0 0; 0 1 0; 1 1 0; 1 0 0; ...
    0 0 1; 0 1 1; 1 1 1; 1 0 1];

cube = cube*len;%work out the cube dimensions
%move the cube to the correct location
vertices = cube + repmat((pos-ones(1, 3))*len, length(cube), 1);

faces = [1 2 3 4; 2 6 7 3; 4 3 7 8; 1 5 8 4; 1 2 6 5; 5 6 7 8];

%cube drawing reference
%http://smallbusiness.chron.com/graph-cube-matlab-54144.html

linestyle = '--';%linestyle so can have invisible voxels
%switch for all the materials so can have different colours

colour = ColourMat(material);

if strcmp(lower(material), 'invis')
        colour = 'none';
        linestyle = 'none';
end

p = patch('Vertices', vertices, 'Faces', faces, 'FaceColor', colour, 'LineStyle',linestyle);
%make it mostly transparent so the paths can be seen
set(p,'FaceAlpha',0.15);
end