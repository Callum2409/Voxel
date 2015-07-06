function [t, a, s, f] = GetMat(material)
%GETMAT
%calculate and return the information for the required material

%reference for material cross sections
%http://www.kayelaby.npl.co.uk/atomic_and_nuclear_physics/4_7/4_7_2.html

%heavy water
%http://www.ncnr.nist.gov/staff/hammouda/distance_learning/chapter_9.pdf

%switch to get the material information
switch(lower(material))
%mass, density, absorbtion cross section, scattering cross section
%uses cgs units

    case {'water', 'h2o'}
        [t, a, s, f] = MaterialInfo(18, 1, 0.6652, 103.0);
    case {'lead', 'pb'}
        [t, a, s, f] = MaterialInfo(207.2, 11.34, 0.158, 11.221);
    case 'graphite'
        [t, a, s, f] = MaterialInfo(12, 1.67, 0.0045, 4.74);
    case {'aluminium', 'al'}
        [t, a, s, f] = MaterialInfo(26.982, 2.7, 0.189, 1.45);
    case {'silicon', 'si'}
        [t, a, s, f] = MaterialInfo(28.086, 2.33, 0.152, 2.101);
    case {'iron', 'fe'}
        [t, a, s, f] = MaterialInfo(55.845, 7.874, 2.292, 11.330);
    case {'lithium', 'li'}
        [t, a, s, f] = MaterialInfo(6.94, 0.534, 62.53, 1.097);
    case {'cadmium', 'cd'}
        [t, a, s, f] = MaterialInfo(112.414, 8.65, 2918.3, 10.237);
    case {'heavy water', 'd2o'}
        [t, a, s, f] = MaterialInfo(20.0276, 1.107, 5.2e-4, 19.53);
    case {'air', 'invis'}
        [t, a, s, f] = deal(0, 0, 0, 0);
    case {'uranium233', 'u233'}
        [t, a, s, f] = MaterialInfo(238.02891, 19.05, 42.20, 12.19, 468.20);
end
end

function [sigT, sigA, sigS, sigF] = MaterialInfo(mass, density, sigmaC, sigmaS, sigmaF)
%MATERIALINFO
%calculate the values given the cross sections
Na = 6.0221413e23;%per mol
barn = 1e-24;%in cm^2

n = density * Na/mass;

if nargin == 4 %if not fissile
    sigmaF = 0;%set fissile to be 0
    sigF = 0;
else
    sigF = n*sigmaF*barn;%or calculate fission cross section
end

sigA = n*barn*(sigmaC+sigmaF);
sigS = n*sigmaS*barn;
sigT = sigA+sigS;
end
