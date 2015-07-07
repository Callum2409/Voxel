function [colour] = ColourMat(material)
%COLOURMAT
%Return the colour of the material. Is here so that can be referenced by
%voxels and normal

switch(lower(material))
    case {'water', 'h2o'}
        colour = [0.5, 0.5, 1];
    case {'lead', 'pb'}
        colour = [0, 0, 0];
    case 'graphite'
        colour = [0.7, 0.7, 0.7];
    case {'aluminium', 'al'}
        colour = [0.5, 0.8, 0.5];
    case {'silicon', 'si'}
        colour = [0.3, 1, 0.3];
    case {'iron', 'fe'}
        colour = [1, 0.5, 0.5];
    case {'lithium', 'li'}
        colour = [1, 0, 0];
    case {'cadmium', 'cd'}
        colour = [.8, .8, 0];
    case {'heavy water', 'd2o'}
        colour = [.85, .85, .85];
    case {'uranium233', 'u233'}
        colour = [.22, 1, .08];
    otherwise
        colour = 'w';
end
end