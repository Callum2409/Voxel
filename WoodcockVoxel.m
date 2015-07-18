function [atr] = WoodcockVoxel(startPos, rots, xi, yi, zi, len, voxMat, S, particles, show)
%WOODCOCKVOXEL
%   Woodcock method for voxel model

sigmaT = max(S(:, 1));%majorant xsect
lT = 1/sigmaT;%mfp of majorant xsect
atr = zeros(1, 3);%absorb, transmit, reflect numbers

n = 1;
while n <= length(rots)
    fission = 0;
    fprintf('%i / %i, %i\n', n, length(rots), length(rots)-n);
    pos = startPos(n, :);%set the start position
    
    if rots(n) == 0 %if specific rotation
        [rx, ry, rz] = deal(xi, yi, zi);
    else
        [rx, ry, rz] = OnUnitSphere;
    end
    
    [x, y, z] = deal(rx, ry, rz);
    
    i = 2;
    while true
        %move to new position
        pos(i, :) = pos(i-1, :) + [x, y, z]*ExpDist(lT);
        
        %work out what region the particle is now in
        [stop, pos, atr] = TR(pos, atr, i, len, voxMat, rots(n), rx, ry, rz, startPos(n, :));
        if stop
            break;
        end
        %will have stopped if out of bounds
        
        [curT, curA, curF] = GetReg(pos(i, :), len, voxMat, S);%work out what region is in
        while rand > curT/sigmaT %if needs ficticious step
            pos(i, :) = pos(i, :) + [x, y, z]*ExpDist(lT);
            
            %need to check location again after making ficticious move
            [stop, pos, atr] = TR(pos, atr, i, len, voxMat, rots(n), rx, ry, rz, startPos(n, :));
            if stop
                break;
            end
            %need to work out region again in case changed, resulting in
            %different path length
            [curT, curA, curF] = GetReg(pos(i, :), len, voxMat, S);
        end
        if stop
            break;
        end
        
        if rand < curA/curT %if absorbed
            if rand < curF/curT %if fission???
                pos(i+1, 1) = 1;%although not shown, needs to be set so no error
                for a = 1:2%gets absorbed and produces 2 neutrons
                    rots(end+1) = 1;%add a new isotropic neutron
                    startPos(end+1, :) = pos(i, :);%set start position of neutron
                end
                
                fission = 1;
                break;%break from the loop
            else
                %if absorbed rather than scattered or fission
                pos(i+1, 1) = 1;%set this so can set a specific colour
                atr(1) = atr(1)+1;
                break;%break from the loop
            end
        end
        
        i=i+1;%next step
        [x, y, z] = OnUnitSphere;%generate new direction
    end
    
    if show
        hold on;
        %display the lines
        plot3(pos(1:end-1, 1), pos(1:end-1, 2), pos(1:end-1, 3), 'k');
        %display the final point colour
        if ~fission %only display end if not fissioned
            plot3(pos(end-1, 1), pos(end-1, 2), pos(end-1, 3), 'o', 'Color', pos(end,:));
        end
    end
    n = n+1;%increase the neutron number
    
    if n> 500 %have this to break so that something is shown
        %without the break, the system goes on forever
        break;
    end
end

if show
    plot3(startPos(1, 1), startPos(1, 2), startPos(1, 3), 'rx');%display start point
    hold off;
end

%fprintf('a\tt\tr\n%i\t%i\t%i\n', atr(1), atr(2), atr(3));
end

function [sigmaT, sigmaA, sigmaF] = GetReg(pos, len, voxMat, S)
%GETREG
%work out what region the neutron is in
loc = floor(pos/len)+1;%used to find voxel array index
curS = S(voxMat(loc(1), loc(2), loc(3)),  :);%get the sigma values for the current voxel material
sigmaT = curS(1);
sigmaA = curS(2);
sigmaF = curS(3);
end

function [stop, pos, atr] = TR(pos, atr, i, len, voxMat, rot, rx, ry, rz, startPos)
%TR
%determine if the neutron has been transmitted or reflected
stop = 0;%used so can break from enough loops

%work out if any of the position values are out of bounds
sz = [size(voxMat), ones(1, 3-length(size(voxMat)))];
leftP = pos(i, :) > len*sz;
leftN = pos(i, :) < zeros(1, 3);

front = dot((pos(i, :) - startPos), [rx, ry, rz]);%if behind the initial direction

for xyz = 1:length(leftP)
    %if any out of bounds due to transmission or reflection
    if leftP(xyz) || leftN(xyz)%if left in +ve or -ve directions
        if rot == 0 %if is not isotropic
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
