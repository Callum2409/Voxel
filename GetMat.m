function [t, a, s] = GetMat(material)
%GETMAT
%calculate and return the information for the required material

%reference for material cross sections
%http://www.kayelaby.npl.co.uk/atomic_and_nuclear_physics/4_7/4_7_2.html

%heavy water
%http://www.ncnr.nist.gov/staff/hammouda/distance_learning/chapter_9.pdf

%switch to get the material information
switch(lower(material))
    case {'water', 'h2o'}
        [t, a, s] = MaterialInfo(18, 1, 0.6652, 103.0);
    case {'lead', 'pb'}
        [t, a, s] = MaterialInfo(207.2, 11.34, 0.158, 11.221);
    case 'graphite'
        [t, a, s] = MaterialInfo(12, 1.67, 0.0045, 4.74);
    case {'aluminium', 'al'}
        [t, a, s] = MaterialInfo(26.982, 2.7, 0.189, 1.45);
    case {'silicon', 'si'}
        [t, a, s] = MaterialInfo(28.086, 2.33, 0.152, 2.101);
    case {'iron', 'fe'}
        [t, a, s] = MaterialInfo(55.845, 7.874, 2.292, 11.330);
    case {'lithium', 'li'}
        [t, a, s] = MaterialInfo(6.94, 0.534, 62.53, 1.097);
    case {'cadmium', 'cd'}
        [t, a, s] = MaterialInfo(112.414, 8.65, 2918.3, 10.237);
    case {'heavy water', 'd2o'}
        [t, a, s] = MaterialInfo(20.0276, 1.107, 5.2e-4, 19.53);
    case {'air', 'invis'}
        [t, a, s] = deal(0, 0, 0);
    case 'test'
        [t, a, s] = MaterialInfo(112.6, 6.17, .4116, 57.1105);
end
end

function [sigT, sigA, sigS] = MaterialInfo(mass, density, sigmaA, sigmaS)
%MATERIALINFO
%calculate the values given the cross sections
Na = 6.0221413e23;%per mol
barn = 1e-24;%in cm^2

n = density * Na/mass;
sigA = n*sigmaA*barn;
sigS = n*sigmaS*barn;
sigT = sigA+sigS;
end

