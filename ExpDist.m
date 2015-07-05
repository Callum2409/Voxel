function [value] = ExpDist(lambda)
%EXPDIST
%exponential distribution to calculate the step length
    value = -lambda*log(rand);
end

