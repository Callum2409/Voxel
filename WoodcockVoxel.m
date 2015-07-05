function [atr] = WoodcockVoxel(startPos, rot, len, voxMat, S, particles, show)
%WOODCOCKVOXEL
%   Woodcock method for voxel model

sigmaT = max(S(:, 1));%majorant xsect
lT = 1/sigmaT;%mfp of majorant xsect
atr = zeros(1, 3);%absorb, transmit, reflect numbers

for n = 1:particles
    pos = startPos;%set the start position
    [x, y, z] = eval(rot);%get the rotation. uses eval so can be isotropic
    
    i = 2;
    while true
        %move to new position
        pos(i, :) = pos(i-1, :) + [x, y, z]*ExpDist(lT);
        
        %work out what region the particle is now in
        [stop, pos, atr] = TR(pos, atr, i, len, voxMat, rot, startPos);
        if stop
            break;
        end
        %will have stopped if out of bounds
        
        [curT, curA] = GetReg(pos(i, :), len, voxMat, S);%work out what region is in
        while rand > curT/sigmaT %if needs ficticious step
            pos(i, :) = pos(i, :) + [x, y, z]*ExpDist(lT);
            
            %need to check location again after making ficticious move
            [stop, pos, atr] = TR(pos, atr, i, len, voxMat, rot, startPos);
            if stop
                break;
            end
            %need to work out region again in case changed, resulting in
            %different path length
            [curT, curA] = GetReg(pos(i, :), len, voxMat, S);
        end
        if stop
            break;
        end
        
        if rand < curA/curT
            %if absorbed rather than scattered
            pos(i+1, 1) = 1;%set this so can set a specific colour
            atr(1) = atr(1)+1;
            break;%break from the loop
        end
        
        i=i+1;%next step
        [x, y, z] = OnUnitSphere;%generate new direction
    end
    
    if show
        hold on;
        %display the lines
        plot3(pos(1:end-1, 1), pos(1:end-1, 2), pos(1:end-1, 3), 'k');
        %display the final point colour
        plot3(pos(end-1, 1), pos(end-1, 2), pos(end-1, 3), 'o', 'Color', pos(end,:));
    end
end

if show
    plot3(startPos(1), startPos(2), startPos(3), 'rx');%display start point
    hold off;
end

fprintf('a\tt\tr\n%i\t%i\t%i\n', atr(1), atr(2), atr(3));
end

function [sigmaT, sigmaA] = GetReg(pos, len, voxMat, S)
%GETREG
%work out what region the neutron is in
loc = floor(pos/len)+1;%used to find voxel array index
curS = S(voxMat(loc(1), loc(2), loc(3)),  :);%get the sigma values for the current voxel material
sigmaT = curS(1);
sigmaA = curS(2);
end

function [stop, pos, atr] = TR(pos, atr, i, len, voxMat, rot, startPos)
%TR
%determine if the neutron has been transmitted or reflected
stop = 0;%used so can break from enough loops

%work out if any of the position values are out of bounds
sz = [size(voxMat), ones(1, 3-length(size(voxMat)))];
leftP = pos(i, :) > len*sz;
leftN = pos(i, :) < zeros(1, 3);

[rx, ry, rz] = eval(rot);%get the rotation planes
front = dot((pos(i, :) - startPos), [rx, ry, rz]);%if behind the initial direction

for xyz = 1:length(leftP)
    %if any out of bounds due to transmission or reflection
    if leftP(xyz) || leftN(xyz)%if left in +ve or -ve directions
        if ~strcmp(rot, 'OnUnitSphere')%if is not isotropic
            if front < 0 && (leftN(xyz) || leftP(xyz))
                pos(i+1, 3) = 1;%set this so can be made blue easily
                atr(3) = atr(3) +1;%increase the tranmission numbers
                stop = 1;
                return;
            end
        end
        %if not left in any direction or is isotropic, then transmitted
        pos(i+1, 2) = 1;%set this so can be made green easily
        atr(2) = atr(2) +1;%increase the tranmission numbers
        stop = 1;
        return;
    end
end
end