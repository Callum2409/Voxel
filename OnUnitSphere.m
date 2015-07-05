function [ x, y, u ] = OnUnitSphere
%ONUNITSPHERE
%generate the cartesian coords of an evenly distributed random point on a
%sphere

th = 2*rand*pi;
u = 2*rand-1;

x = sqrt(1-u.^2).*cos(th);
y = sqrt(1-u.^2).*sin(th);
end

%http://mathworld.wolfram.com/SpherePointPicking.html